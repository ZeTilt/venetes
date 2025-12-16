<?php

namespace App\Command;

use App\Entity\ContentBlock;
use App\Entity\Page;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

#[AsCommand(
    name: 'app:convert-pages-to-blocks',
    description: 'Convertit le contenu HTML des pages en blocs de contenu',
)]
class ConvertPagesToBlocksCommand extends Command
{
    public function __construct(
        private EntityManagerInterface $entityManager
    ) {
        parent::__construct();
    }

    protected function configure(): void
    {
        $this
            ->addOption('dry-run', null, InputOption::VALUE_NONE, 'Affiche les conversions sans les appliquer')
            ->addOption('page-id', null, InputOption::VALUE_REQUIRED, 'Convertir uniquement cette page');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        $dryRun = $input->getOption('dry-run');
        $pageId = $input->getOption('page-id');

        $io->title('Conversion des pages en blocs de contenu');

        if ($dryRun) {
            $io->warning('Mode dry-run activé - aucune modification ne sera effectuée');
        }

        $qb = $this->entityManager->createQueryBuilder()
            ->select('p')
            ->from(Page::class, 'p')
            ->where('p.useBlocks = false')
            ->andWhere('p.content IS NOT NULL')
            ->andWhere("p.content != ''");

        if ($pageId) {
            $qb->andWhere('p.id = :pageId')->setParameter('pageId', $pageId);
        }

        $pages = $qb->getQuery()->getResult();

        if (empty($pages)) {
            $io->success('Aucune page à convertir.');
            return Command::SUCCESS;
        }

        $io->info(sprintf('Trouvé %d page(s) à convertir', count($pages)));

        foreach ($pages as $page) {
            $io->section(sprintf('Page: %s (ID: %d)', $page->getTitle(), $page->getId()));

            $blocks = $this->parseHtmlToBlocks($page->getContent(), $io);

            $io->text(sprintf('  -> %d bloc(s) créé(s)', count($blocks)));

            if (!$dryRun && count($blocks) > 0) {
                // Supprimer les anciens blocs si existants
                foreach ($page->getContentBlocks() as $oldBlock) {
                    $this->entityManager->remove($oldBlock);
                }

                // Ajouter les nouveaux blocs
                foreach ($blocks as $position => $blockData) {
                    $block = new ContentBlock();
                    $block->setPage($page);
                    $block->setType($blockData['type']);
                    $block->setData($blockData['data']);
                    $block->setPosition($position);
                    $this->entityManager->persist($block);
                }

                $page->setUseBlocks(true);
                $this->entityManager->flush();

                $io->success(sprintf('  Page "%s" convertie avec succès', $page->getTitle()));
            }
        }

        if ($dryRun) {
            $io->note('Exécutez sans --dry-run pour appliquer les modifications');
        }

        return Command::SUCCESS;
    }

    private function parseHtmlToBlocks(string $html, SymfonyStyle $io): array
    {
        $blocks = [];

        // Nettoyer le HTML
        $html = trim($html);

        // Supprimer le wrapper prose si présent
        if (preg_match('/<div class="prose[^"]*">(.*)<\/div>$/s', $html, $matches)) {
            $html = trim($matches[1]);
        }

        // Parser le HTML avec DOMDocument
        $dom = new \DOMDocument();
        libxml_use_internal_errors(true);
        $dom->loadHTML('<?xml encoding="UTF-8"><div id="wrapper">' . $html . '</div>', LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
        libxml_clear_errors();

        $xpath = new \DOMXPath($dom);
        $wrapper = $dom->getElementById('wrapper');

        if (!$wrapper) {
            // Fallback: mettre tout en bloc texte
            $blocks[] = ['type' => ContentBlock::TYPE_TEXT, 'data' => ['content' => $html]];
            return $blocks;
        }

        foreach ($wrapper->childNodes as $node) {
            if ($node->nodeType !== XML_ELEMENT_NODE) {
                continue;
            }

            $block = $this->parseNode($node, $dom);
            if ($block) {
                $blocks = array_merge($blocks, is_array($block[0] ?? null) ? $block : [$block]);
            }
        }

        // Consolider les blocs texte consécutifs
        $blocks = $this->consolidateTextBlocks($blocks);

        return $blocks;
    }

    private function parseNode(\DOMNode $node, \DOMDocument $dom): ?array
    {
        $tagName = strtolower($node->nodeName);
        $class = $node->getAttribute('class') ?? '';
        $innerHTML = $this->getInnerHTML($node, $dom);

        // Détecter les alert boxes (bg-blue-50, bg-green-50, bg-yellow-50, bg-red-50 avec border-l-4)
        if (preg_match('/bg-(blue|green|yellow|red)-50.*border-l-4|border-l-4.*bg-(blue|green|yellow|red)-50/', $class)) {
            return $this->parseAlertBox($node, $dom);
        }

        // Détecter les hero banners (bg-gradient-to-r)
        if (str_contains($class, 'bg-gradient-to-r')) {
            return $this->parseHeroBanner($node, $dom);
        }

        // Détecter les grilles (grid md:grid-cols-2)
        if (str_contains($class, 'grid') && preg_match('/grid-cols-\d/', $class)) {
            return $this->parseGrid($node, $dom);
        }

        // Détecter les listes avec icônes (feature list)
        if ($tagName === 'ul' && str_contains($class, 'space-y')) {
            $firstLi = $node->getElementsByTagName('li')->item(0);
            if ($firstLi && str_contains($firstLi->getAttribute('class') ?? '', 'flex')) {
                return $this->parseFeatureList($node, $dom);
            }
        }

        // Titres et paragraphes -> bloc texte
        if (in_array($tagName, ['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'ul', 'ol'])) {
            return ['type' => ContentBlock::TYPE_TEXT, 'data' => ['content' => $dom->saveHTML($node)]];
        }

        // Div générique -> bloc texte
        if ($tagName === 'div') {
            return ['type' => ContentBlock::TYPE_TEXT, 'data' => ['content' => $dom->saveHTML($node)]];
        }

        return null;
    }

    private function parseAlertBox(\DOMNode $node, \DOMDocument $dom): array
    {
        $class = $node->getAttribute('class') ?? '';

        // Déterminer le style
        $style = 'info';
        if (str_contains($class, 'bg-green') || str_contains($class, 'border-green')) {
            $style = 'success';
        } elseif (str_contains($class, 'bg-yellow') || str_contains($class, 'border-yellow')) {
            $style = 'warning';
        } elseif (str_contains($class, 'bg-red') || str_contains($class, 'border-red')) {
            $style = 'error';
        }

        // Extraire le contenu
        $content = '';
        $title = '';

        foreach ($node->childNodes as $child) {
            if ($child->nodeType === XML_ELEMENT_NODE) {
                $childTag = strtolower($child->nodeName);
                $childHTML = $this->getInnerHTML($child, $dom);

                if (in_array($childTag, ['h3', 'h4', 'strong']) && empty($title)) {
                    $title = strip_tags($childHTML);
                } elseif ($childTag === 'p') {
                    // Vérifier si c'est un strong au début
                    if (preg_match('/<strong>([^<]+)<\/strong>\s*[-–]\s*(.*)$/s', $childHTML, $m)) {
                        $title = $m[1];
                        $content = $m[2];
                    } else {
                        $content .= strip_tags($childHTML, '<a><strong><em>');
                    }
                } else {
                    $content .= strip_tags($childHTML, '<a><strong><em>');
                }
            }
        }

        return [
            'type' => ContentBlock::TYPE_ALERT_BOX,
            'data' => [
                'style' => $style,
                'title' => trim($title),
                'content' => trim($content),
            ]
        ];
    }

    private function parseHeroBanner(\DOMNode $node, \DOMDocument $dom): array
    {
        $class = $node->getAttribute('class') ?? '';

        // Déterminer le gradient
        $gradient = 'orange';
        if (str_contains($class, 'from-blue')) {
            $gradient = 'blue';
        } elseif (str_contains($class, 'from-cyan')) {
            $gradient = 'cyan';
        } elseif (str_contains($class, 'from-green')) {
            $gradient = 'green';
        } elseif (str_contains($class, 'from-gray')) {
            $gradient = 'gray';
        } elseif (str_contains($class, 'from-purple')) {
            $gradient = 'purple';
        }

        $title = '';
        $subtitle = '';

        foreach ($node->childNodes as $child) {
            if ($child->nodeType === XML_ELEMENT_NODE) {
                $childTag = strtolower($child->nodeName);
                $childHTML = $this->getInnerHTML($child, $dom);

                if (in_array($childTag, ['h2', 'h3']) && empty($title)) {
                    $title = strip_tags($childHTML);
                } elseif ($childTag === 'p' && empty($subtitle)) {
                    $subtitle = strip_tags($childHTML);
                }
            }
        }

        return [
            'type' => ContentBlock::TYPE_HERO_BANNER,
            'data' => [
                'gradient' => $gradient,
                'icon' => '',
                'title' => trim($title),
                'subtitle' => trim($subtitle),
            ]
        ];
    }

    private function parseFeatureList(\DOMNode $node, \DOMDocument $dom): array
    {
        $items = [];

        foreach ($node->getElementsByTagName('li') as $li) {
            $text = '';
            $description = '';

            // Essayer de trouver le texte principal et la description
            $spans = $li->getElementsByTagName('span');
            if ($spans->length > 0) {
                $text = strip_tags($this->getInnerHTML($spans->item(0), $dom));
                if ($spans->length > 1) {
                    $description = strip_tags($this->getInnerHTML($spans->item(1), $dom));
                }
            } else {
                // Prendre tout le texte du li
                $text = strip_tags($this->getInnerHTML($li, $dom));
            }

            if (!empty(trim($text))) {
                $items[] = [
                    'text' => trim($text),
                    'description' => trim($description),
                ];
            }
        }

        return [
            'type' => ContentBlock::TYPE_FEATURE_LIST,
            'data' => [
                'icon_type' => 'check',
                'columns' => 1,
                'title' => '',
                'items' => $items,
            ]
        ];
    }

    private function parseGrid(\DOMNode $node, \DOMDocument $dom): array
    {
        $blocks = [];
        $class = $node->getAttribute('class') ?? '';

        // Déterminer le nombre de colonnes
        $columns = 2;
        if (preg_match('/grid-cols-(\d)/', $class, $m)) {
            $columns = (int) $m[1];
        }

        // Parser les enfants récursivement
        foreach ($node->childNodes as $child) {
            if ($child->nodeType === XML_ELEMENT_NODE) {
                $childBlock = $this->parseNode($child, $dom);
                if ($childBlock) {
                    $blocks = array_merge($blocks, is_array($childBlock[0] ?? null) ? $childBlock : [$childBlock]);
                }
            }
        }

        // Si pas de blocs enfants, retourner comme texte
        if (empty($blocks)) {
            return ['type' => ContentBlock::TYPE_TEXT, 'data' => ['content' => $dom->saveHTML($node)]];
        }

        return $blocks;
    }

    private function consolidateTextBlocks(array $blocks): array
    {
        $consolidated = [];
        $currentText = '';

        foreach ($blocks as $block) {
            if ($block['type'] === ContentBlock::TYPE_TEXT) {
                $currentText .= $block['data']['content'];
            } else {
                if (!empty($currentText)) {
                    $consolidated[] = ['type' => ContentBlock::TYPE_TEXT, 'data' => ['content' => $currentText]];
                    $currentText = '';
                }
                $consolidated[] = $block;
            }
        }

        if (!empty($currentText)) {
            $consolidated[] = ['type' => ContentBlock::TYPE_TEXT, 'data' => ['content' => $currentText]];
        }

        return $consolidated;
    }

    private function getInnerHTML(\DOMNode $node, \DOMDocument $dom): string
    {
        $innerHTML = '';
        foreach ($node->childNodes as $child) {
            $innerHTML .= $dom->saveHTML($child);
        }
        return $innerHTML;
    }
}
