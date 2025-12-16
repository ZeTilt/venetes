<?php

namespace App\Command;

use Doctrine\DBAL\Connection;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;

#[AsCommand(
    name: 'app:export-blocks',
    description: 'Exporte les content_blocks en SQL avec mapping des IDs',
)]
class ExportBlocksCommand extends Command
{
    public function __construct(
        private Connection $connection
    ) {
        parent::__construct();
    }

    protected function configure(): void
    {
        $this
            ->addOption('output', 'o', InputOption::VALUE_REQUIRED, 'Fichier de sortie', 'dumps/content_blocks_export.sql')
            ->addOption('include-pages', null, InputOption::VALUE_NONE, 'Inclure les nouvelles pages (IDs 40-43)');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        // Mapping des IDs local -> prod
        $mapping = [
            29 => 1, 30 => 2, 31 => 3, 32 => 4, 33 => 5,
            34 => 6, 35 => 7, 36 => 8, 37 => 9, 39 => 10,
            40 => 11, 41 => 12, 42 => 13, 43 => 14,
        ];

        $newPageIds = [40, 41, 42, 43];
        $includingPages = $input->getOption('include-pages');

        $sql = "-- Export pour import sur BDD prod\n";
        $sql .= "-- Généré le " . date('Y-m-d H:i:s') . "\n";
        $sql .= "-- Mapping pages: 29->1, 30->2, 31->3, 32->4, 33->5, 34->6, 35->7, 36->8, 37->9, 39->10, 40->11, 41->12, 42->13, 43->14\n\n";

        // Exporter les nouvelles pages si demandé
        if ($includingPages) {
            $sql .= "-- ===========================================\n";
            $sql .= "-- PARTIE 1: Créer les nouvelles pages (11-14)\n";
            $sql .= "-- ===========================================\n\n";
            $sql .= "DELETE FROM content_blocks WHERE page_id IN (11, 12, 13, 14);\n";
            $sql .= "DELETE FROM pages WHERE id IN (11, 12, 13, 14);\n\n";

            $stmt = $this->connection->executeQuery(
                "SELECT * FROM pages WHERE id IN (40, 41, 42, 43) ORDER BY id"
            );
            $pages = $stmt->fetchAllAssociative();

            foreach ($pages as $page) {
                $newId = $mapping[$page['id']];
                $sql .= "INSERT INTO pages (id, author_id, title, slug, excerpt, content, template_path, type, status, meta_title, meta_description, tags, created_at, updated_at, sort_order, use_blocks) VALUES (";
                $sql .= "$newId, 1, ";
                $sql .= $this->connection->quote($page['title']) . ", ";
                $sql .= $this->connection->quote($page['slug']) . ", ";
                $sql .= $this->connection->quote($page['excerpt'] ?? '') . ", ";
                $sql .= $this->connection->quote($page['content'] ?? '') . ", ";
                $sql .= $this->connection->quote($page['template_path'] ?? 'pages/page.html.twig') . ", ";
                $sql .= $this->connection->quote($page['type'] ?? 'page') . ", ";
                $sql .= $this->connection->quote($page['status'] ?? 'published') . ", ";
                $sql .= $this->connection->quote($page['meta_title'] ?? '') . ", ";
                $sql .= $this->connection->quote($page['meta_description'] ?? '') . ", ";
                $sql .= "'[]', NOW(), NOW(), 0, 1);\n";
            }

            $sql .= "\n-- ===========================================\n";
            $sql .= "-- PARTIE 2: Blocs de contenu\n";
            $sql .= "-- ===========================================\n\n";
        }

        // Supprimer les anciens blocs
        $allProdIds = array_values($mapping);
        $sql .= "-- Supprimer les anciens blocs\n";
        $sql .= "DELETE FROM content_blocks WHERE page_id IN (" . implode(', ', $allProdIds) . ");\n\n";
        $sql .= "-- Insérer les nouveaux blocs\n";

        // Récupérer et exporter les blocs
        $stmt = $this->connection->executeQuery(
            "SELECT page_id, type, data, position FROM content_blocks WHERE page_id IS NOT NULL ORDER BY page_id, position"
        );
        $blocks = $stmt->fetchAllAssociative();

        foreach ($blocks as $block) {
            $newPageId = $mapping[$block['page_id']] ?? null;
            if (!$newPageId) continue;

            $data = $this->connection->quote($block['data']);
            $type = $this->connection->quote($block['type']);

            $sql .= "INSERT INTO content_blocks (page_id, article_id, type, data, position) VALUES ";
            $sql .= "($newPageId, NULL, $type, $data, {$block['position']});\n";
        }

        $sql .= "\n-- Mettre à jour use_blocks sur les pages\n";
        $sql .= "UPDATE pages SET use_blocks = 1 WHERE id IN (" . implode(', ', $allProdIds) . ");\n\n";
        $sql .= "-- Fin de l'export\n";

        $outputFile = $input->getOption('output');
        file_put_contents($outputFile, $sql);

        $output->writeln("<info>Export terminé: $outputFile</info>");
        $output->writeln("<info>" . count($blocks) . " blocs exportés</info>");
        if ($includingPages) {
            $output->writeln("<info>4 nouvelles pages incluses</info>");
        }

        return Command::SUCCESS;
    }
}
