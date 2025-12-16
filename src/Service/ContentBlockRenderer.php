<?php

namespace App\Service;

use App\Entity\Article;
use App\Entity\ContentBlock;
use App\Entity\Page;
use Twig\Environment;

/**
 * Service to render content blocks with optimizations
 */
class ContentBlockRenderer
{
    private ?WidgetRenderer $widgetRenderer = null;

    public function __construct(
        private Environment $twig,
        private ImageOptimizerService $imageOptimizer,
        private string $projectDir
    ) {}

    public function setWidgetRenderer(WidgetRenderer $widgetRenderer): void
    {
        $this->widgetRenderer = $widgetRenderer;
    }

    /**
     * Render all content blocks for an article
     */
    public function renderArticleBlocks(Article $article): string
    {
        if (!$article->getUseBlocks()) {
            return $article->getContent();
        }

        $html = '';
        foreach ($article->getContentBlocks() as $block) {
            $html .= $this->renderBlock($block);
        }

        return $html;
    }

    /**
     * Render all content blocks for a page
     */
    public function renderPageBlocks(Page $page): string
    {
        if (!$page->getUseBlocks()) {
            return '';
        }

        $html = '';
        foreach ($page->getContentBlocks() as $block) {
            $html .= $this->renderBlock($block);
        }

        return $html;
    }

    /**
     * Render a single content block
     */
    public function renderBlock(ContentBlock $block): string
    {
        return match ($block->getType()) {
            ContentBlock::TYPE_TEXT => $this->renderTextBlock($block),
            ContentBlock::TYPE_IMAGE => $this->renderImageBlock($block),
            ContentBlock::TYPE_GALLERY => $this->renderGalleryBlock($block),
            ContentBlock::TYPE_VIDEO => $this->renderVideoBlock($block),
            ContentBlock::TYPE_QUOTE => $this->renderQuoteBlock($block),
            ContentBlock::TYPE_ACCORDION => $this->renderAccordionBlock($block),
            ContentBlock::TYPE_CTA => $this->renderCtaBlock($block),
            ContentBlock::TYPE_WIDGET => $this->renderWidgetBlock($block),
            ContentBlock::TYPE_ROW => $this->renderRowBlock($block),
            ContentBlock::TYPE_ALERT_BOX => $this->renderAlertBoxBlock($block),
            ContentBlock::TYPE_HERO_BANNER => $this->renderHeroBannerBlock($block),
            ContentBlock::TYPE_FEATURE_LIST => $this->renderFeatureListBlock($block),
            default => '',
        };
    }

    private function renderWidgetBlock(ContentBlock $block): string
    {
        if (!$this->widgetRenderer) {
            return '<div class="widget-error">Widget renderer non configuré</div>';
        }

        return $this->widgetRenderer->render($block);
    }

    private function renderTextBlock(ContentBlock $block): string
    {
        $content = $block->getContent();
        return sprintf('<div class="block-text prose max-w-none">%s</div>', $content);
    }

    private function renderImageBlock(ContentBlock $block): string
    {
        $url = $block->getImageUrl();
        if (!$url) {
            return '';
        }

        $alt = htmlspecialchars($block->getImageAlt(), ENT_QUOTES, 'UTF-8');
        $caption = $block->getImageCaption();
        $alignment = $block->getImageAlignment();
        $size = $block->getImageSize();

        // Generate optimized image URLs
        $srcset = $this->generateSrcset($url);
        $sizes = $this->getSizesAttribute($size);
        $thumbUrl = $this->getThumbUrl($url);

        // Alignment classes
        $alignClass = match ($alignment) {
            'left' => 'float-left mr-6 mb-4',
            'right' => 'float-right ml-6 mb-4',
            default => 'mx-auto',
        };

        // Size classes
        $sizeClass = match ($size) {
            'small' => 'max-w-xs',
            'medium' => 'max-w-md',
            'large' => 'max-w-2xl',
            default => 'w-full',
        };

        $html = sprintf(
            '<figure class="block-image %s %s my-6">',
            $alignClass,
            $sizeClass
        );

        $html .= sprintf(
            '<img src="%s" alt="%s" loading="lazy" decoding="async" class="rounded-lg w-full" %s %s>',
            htmlspecialchars($url, ENT_QUOTES, 'UTF-8'),
            $alt,
            $srcset ? sprintf('srcset="%s"', $srcset) : '',
            $sizes ? sprintf('sizes="%s"', $sizes) : ''
        );

        if ($caption) {
            $html .= sprintf(
                '<figcaption class="text-sm text-gray-600 text-center mt-2">%s</figcaption>',
                htmlspecialchars($caption, ENT_QUOTES, 'UTF-8')
            );
        }

        $html .= '</figure>';

        return $html;
    }

    private function renderGalleryBlock(ContentBlock $block): string
    {
        $images = $block->getGalleryImages();
        if (empty($images)) {
            return '';
        }

        $layout = $block->getGalleryLayout();
        $columns = $block->getGalleryColumns();

        if ($layout === 'carousel') {
            return $this->renderCarouselGallery($images);
        }

        // Grid or masonry layout
        $gridClass = match ($columns) {
            2 => 'grid-cols-2',
            3 => 'grid-cols-2 md:grid-cols-3',
            4 => 'grid-cols-2 md:grid-cols-4',
            default => 'grid-cols-3',
        };

        $html = sprintf('<div class="block-gallery grid %s gap-4 my-6">', $gridClass);

        foreach ($images as $image) {
            $url = $image['url'] ?? '';
            $alt = htmlspecialchars($image['alt'] ?? '', ENT_QUOTES, 'UTF-8');
            $thumbUrl = $this->getThumbUrl($url);

            $html .= sprintf(
                '<a href="%s" class="gallery-item block aspect-square overflow-hidden rounded-lg" data-lightbox="gallery">
                    <img src="%s" alt="%s" loading="lazy" decoding="async" class="w-full h-full object-cover hover:scale-105 transition-transform duration-300">
                </a>',
                htmlspecialchars($url, ENT_QUOTES, 'UTF-8'),
                htmlspecialchars($thumbUrl ?: $url, ENT_QUOTES, 'UTF-8'),
                $alt
            );
        }

        $html .= '</div>';

        return $html;
    }

    private function renderCarouselGallery(array $images): string
    {
        $urls = array_map(fn($img) => $img['url'] ?? '', $images);
        $urlsString = implode(',', $urls);

        return sprintf(
            '[carousel]%s[/carousel]',
            $urlsString
        );
    }

    private function renderVideoBlock(ContentBlock $block): string
    {
        $url = $block->getVideoUrl();
        if (!$url) {
            return '';
        }

        $caption = $block->getVideoCaption();
        $provider = $block->getVideoProvider();
        $videoId = $block->getVideoId();

        $html = '<figure class="block-video my-6">';

        if ($provider === 'youtube' && $videoId) {
            // Lazy load YouTube with thumbnail
            $thumbnailUrl = sprintf('https://img.youtube.com/vi/%s/maxresdefault.jpg', $videoId);
            $html .= sprintf(
                '<div class="video-container relative aspect-video bg-gray-900 rounded-lg overflow-hidden cursor-pointer youtube-facade" data-video-id="%s">
                    <img src="%s" alt="Vidéo YouTube" loading="lazy" class="w-full h-full object-cover">
                    <div class="absolute inset-0 flex items-center justify-center">
                        <button class="play-button w-16 h-16 bg-red-600 rounded-full flex items-center justify-center hover:bg-red-700 transition-colors">
                            <svg class="w-8 h-8 text-white ml-1" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M8 5v14l11-7z"/>
                            </svg>
                        </button>
                    </div>
                </div>',
                $videoId,
                $thumbnailUrl
            );
        } elseif ($provider === 'vimeo' && $videoId) {
            $html .= sprintf(
                '<div class="video-container aspect-video rounded-lg overflow-hidden">
                    <iframe src="https://player.vimeo.com/video/%s" class="w-full h-full" frameborder="0" allow="autoplay; fullscreen" allowfullscreen loading="lazy"></iframe>
                </div>',
                $videoId
            );
        } else {
            // Local video
            $html .= sprintf(
                '<div class="video-container aspect-video rounded-lg overflow-hidden">
                    <video src="%s" controls class="w-full h-full" preload="metadata"></video>
                </div>',
                htmlspecialchars($url, ENT_QUOTES, 'UTF-8')
            );
        }

        if ($caption) {
            $html .= sprintf(
                '<figcaption class="text-sm text-gray-600 text-center mt-2">%s</figcaption>',
                htmlspecialchars($caption, ENT_QUOTES, 'UTF-8')
            );
        }

        $html .= '</figure>';

        return $html;
    }

    private function renderQuoteBlock(ContentBlock $block): string
    {
        $text = $block->getQuoteText();
        if (!$text) {
            return '';
        }

        $author = $block->getQuoteAuthor();

        $html = '<blockquote class="block-quote border-l-4 border-club-orange pl-6 py-2 my-6 italic text-gray-700">';
        $html .= sprintf('<p class="text-lg">%s</p>', htmlspecialchars($text, ENT_QUOTES, 'UTF-8'));

        if ($author) {
            $html .= sprintf(
                '<footer class="text-sm text-gray-500 mt-2 not-italic">— %s</footer>',
                htmlspecialchars($author, ENT_QUOTES, 'UTF-8')
            );
        }

        $html .= '</blockquote>';

        return $html;
    }

    private function renderAccordionBlock(ContentBlock $block): string
    {
        $items = $block->getAccordionItems();
        if (empty($items)) {
            return '';
        }

        $html = '<div class="block-accordion my-6 space-y-2" x-data="{ open: null }">';

        foreach ($items as $index => $item) {
            $title = htmlspecialchars($item['title'] ?? '', ENT_QUOTES, 'UTF-8');
            $content = $item['content'] ?? '';

            $html .= sprintf(
                '<div class="accordion-item border border-gray-200 rounded-lg overflow-hidden">
                    <button type="button"
                            class="accordion-header w-full px-4 py-3 text-left font-medium text-gray-900 bg-gray-50 hover:bg-gray-100 flex items-center justify-between"
                            @click="open = open === %d ? null : %d">
                        <span>%s</span>
                        <svg class="w-5 h-5 transition-transform" :class="{ \'rotate-180\': open === %d }" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                        </svg>
                    </button>
                    <div class="accordion-content px-4 py-3" x-show="open === %d" x-collapse>
                        %s
                    </div>
                </div>',
                $index, $index, $title, $index, $index, $content
            );
        }

        $html .= '</div>';

        return $html;
    }

    private function renderCtaBlock(ContentBlock $block): string
    {
        $text = $block->getCtaText();
        $url = $block->getCtaUrl();
        $style = $block->getCtaStyle();

        $buttonClass = match ($style) {
            'secondary' => 'bg-club-blue text-white px-4 py-2 rounded hover:bg-club-blue-dark',
            'outline' => 'border-2 border-club-orange text-club-orange px-4 py-2 rounded hover:bg-club-orange hover:text-white',
            default => 'bg-club-orange text-white px-4 py-2 rounded hover:bg-club-orange-dark',
        };

        return sprintf(
            '<div class="block-cta">
                <a href="%s" class="%s">
                    %s
                </a>
            </div>',
            htmlspecialchars($url, ENT_QUOTES, 'UTF-8'),
            $buttonClass,
            htmlspecialchars($text, ENT_QUOTES, 'UTF-8')
        );
    }

    private function renderRowBlock(ContentBlock $block): string
    {
        $data = $block->getData();
        $cells = $data['cells'] ?? [];
        $totalCols = (int) ($data['columns'] ?? 12);
        $gap = $data['gap'] ?? 'normal';
        $verticalAlign = $data['vertical_align'] ?? 'top';

        if (empty($cells)) {
            return '';
        }

        $gapClass = match ($gap) {
            'none' => 'gap-0',
            'small' => 'gap-2',
            'large' => 'gap-8',
            default => 'gap-4',
        };

        $alignClass = match ($verticalAlign) {
            'center' => 'items-center',
            'bottom' => 'items-end',
            'stretch' => 'items-stretch',
            default => 'items-start',
        };

        $html = sprintf(
            '<div class="block-row grid grid-cols-%d %s %s my-6">',
            $totalCols,
            $gapClass,
            $alignClass
        );

        foreach ($cells as $cell) {
            $colspan = (int) ($cell['colspan'] ?? 1);
            $cellContent = $this->renderCellContent($cell);
            $html .= sprintf(
                '<div class="block-cell col-span-%d">%s</div>',
                $colspan,
                $cellContent
            );
        }

        $html .= '</div>';

        return $html;
    }

    private function renderCellContent(array $cell): string
    {
        $type = $cell['type'] ?? 'text';
        $cellData = $cell['data'] ?? [];

        return match ($type) {
            'text' => $cellData['content'] ?? '',
            'image' => $this->renderCellImage($cellData),
            'widget' => $this->renderCellWidget($cellData),
            'cta' => $this->renderCellCta($cellData),
            default => '',
        };
    }

    private function renderCellImage(array $data): string
    {
        $url = $data['url'] ?? '';
        if (empty($url)) return '';

        $alt = htmlspecialchars($data['alt'] ?? '', ENT_QUOTES, 'UTF-8');
        $caption = $data['caption'] ?? '';

        $html = sprintf(
            '<figure class="block-cell-image"><img src="%s" alt="%s" loading="lazy" class="w-full h-auto rounded-lg">',
            htmlspecialchars($url, ENT_QUOTES, 'UTF-8'),
            $alt
        );

        if ($caption) {
            $html .= sprintf('<figcaption class="text-sm text-gray-500 mt-2">%s</figcaption>', htmlspecialchars($caption, ENT_QUOTES, 'UTF-8'));
        }

        $html .= '</figure>';
        return $html;
    }

    private function renderCellWidget(array $data): string
    {
        if (!$this->widgetRenderer) {
            return '';
        }

        $widgetType = $data['widget_type'] ?? '';
        $config = $data['config'] ?? [];

        if (empty($widgetType)) return '';

        // Create a temporary block-like structure for the widget renderer
        $tempBlock = new ContentBlock();
        $tempBlock->setType(ContentBlock::TYPE_WIDGET);
        $tempBlock->setData(['widget_type' => $widgetType, 'config' => $config]);

        return $this->widgetRenderer->render($tempBlock);
    }

    private function renderCellCta(array $data): string
    {
        $text = $data['text'] ?? 'En savoir plus';
        $url = $data['url'] ?? '#';
        $style = $data['style'] ?? 'primary';

        $buttonClass = match ($style) {
            'secondary' => 'bg-club-blue text-white px-4 py-2 rounded hover:bg-club-blue-dark',
            'outline' => 'border-2 border-club-orange text-club-orange px-4 py-2 rounded hover:bg-club-orange hover:text-white',
            default => 'bg-club-orange text-white px-4 py-2 rounded hover:bg-club-orange-dark',
        };

        return sprintf(
            '<div class="block-cell-cta"><a href="%s" class="%s">%s</a></div>',
            htmlspecialchars($url, ENT_QUOTES, 'UTF-8'),
            $buttonClass,
            htmlspecialchars($text, ENT_QUOTES, 'UTF-8')
        );
    }

    /**
     * Render an alert box block (info, success, warning, error)
     */
    private function renderAlertBoxBlock(ContentBlock $block): string
    {
        $content = $block->getAlertContent();
        if (!$content) {
            return '';
        }

        $title = $block->getAlertTitle();
        $styleClasses = $block->getAlertStyleClasses();

        $bgClass = $styleClasses['bg'];
        $borderClass = $styleClasses['border'];
        $textClass = $styleClasses['text'];
        $iconType = $styleClasses['icon'];

        // SVG icons for each alert type
        $iconSvg = match ($iconType) {
            'check' => '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>',
            'warning' => '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/></svg>',
            'error' => '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/></svg>',
            default => '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/></svg>',
        };

        $html = sprintf(
            '<div class="block-alert-box %s %s border-l-4 p-4 my-6 rounded-r-lg">',
            $bgClass,
            $borderClass
        );

        $html .= sprintf('<div class="flex items-start"><div class="%s mr-3 flex-shrink-0">%s</div>', $textClass, $iconSvg);
        $html .= '<div class="flex-1">';

        if ($title) {
            $html .= sprintf('<h4 class="%s font-semibold mb-1">%s</h4>', $textClass, htmlspecialchars($title, ENT_QUOTES, 'UTF-8'));
        }

        $html .= sprintf('<div class="%s">%s</div>', $textClass, $content);
        $html .= '</div></div></div>';

        return $html;
    }

    /**
     * Render a hero banner block with gradient background
     */
    private function renderHeroBannerBlock(ContentBlock $block): string
    {
        $title = $block->getHeroTitle();
        if (!$title) {
            return '';
        }

        $subtitle = $block->getHeroSubtitle();
        $gradientClasses = $block->getHeroGradientClasses();
        $icon = $block->getHeroIcon();

        $html = sprintf(
            '<div class="block-hero-banner bg-gradient-to-r %s text-white rounded-lg p-6 my-6">',
            $gradientClasses
        );

        $html .= '<div class="flex items-center">';

        if ($icon) {
            $html .= sprintf(
                '<div class="mr-4 text-4xl">%s</div>',
                htmlspecialchars($icon, ENT_QUOTES, 'UTF-8')
            );
        }

        $html .= '<div>';
        $html .= sprintf(
            '<h3 class="text-xl font-bold">%s</h3>',
            htmlspecialchars($title, ENT_QUOTES, 'UTF-8')
        );

        if ($subtitle) {
            $html .= sprintf(
                '<p class="mt-1 opacity-90">%s</p>',
                htmlspecialchars($subtitle, ENT_QUOTES, 'UTF-8')
            );
        }

        $html .= '</div></div></div>';

        return $html;
    }

    /**
     * Render a feature list block with icons
     */
    private function renderFeatureListBlock(ContentBlock $block): string
    {
        $items = $block->getFeatureItems();
        if (empty($items)) {
            return '';
        }

        $title = $block->getFeatureTitle();
        $iconType = $block->getFeatureIconType();
        $columns = $block->getFeatureColumns();

        // Generate icon SVG based on type
        $getIcon = function (int $index) use ($iconType): string {
            return match ($iconType) {
                ContentBlock::FEATURE_ICON_CHECK => '<svg class="w-5 h-5 text-green-500 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/></svg>',
                ContentBlock::FEATURE_ICON_BULLET => '<span class="w-2 h-2 bg-club-orange rounded-full flex-shrink-0 mt-2"></span>',
                ContentBlock::FEATURE_ICON_NUMBER => sprintf('<span class="w-6 h-6 bg-club-orange text-white rounded-full flex-shrink-0 flex items-center justify-center text-sm font-semibold">%d</span>', $index + 1),
                ContentBlock::FEATURE_ICON_ARROW => '<svg class="w-5 h-5 text-club-orange flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"/></svg>',
                default => '<svg class="w-5 h-5 text-green-500 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/></svg>',
            };
        };

        $gridClass = match ($columns) {
            2 => 'md:grid-cols-2',
            3 => 'md:grid-cols-3',
            default => '',
        };

        $html = '<div class="block-feature-list my-6">';

        if ($title) {
            $html .= sprintf(
                '<h4 class="text-lg font-semibold text-gray-900 mb-4">%s</h4>',
                htmlspecialchars($title, ENT_QUOTES, 'UTF-8')
            );
        }

        $html .= sprintf('<ul class="grid %s gap-3">', $gridClass);

        foreach ($items as $index => $item) {
            $text = $item['text'] ?? '';
            $description = $item['description'] ?? null;

            $html .= '<li class="flex gap-3">';
            $html .= $getIcon($index);
            $html .= '<div>';
            $html .= sprintf('<span class="text-gray-800">%s</span>', htmlspecialchars($text, ENT_QUOTES, 'UTF-8'));

            if ($description) {
                $html .= sprintf(
                    '<p class="text-sm text-gray-500 mt-1">%s</p>',
                    htmlspecialchars($description, ENT_QUOTES, 'UTF-8')
                );
            }

            $html .= '</div></li>';
        }

        $html .= '</ul></div>';

        return $html;
    }

    /**
     * Generate srcset for responsive images
     */
    private function generateSrcset(string $url): string
    {
        // Check if it's a local image
        if (!str_starts_with($url, '/')) {
            return '';
        }

        $srcset = [];
        $basePath = $this->projectDir . '/public' . $url;

        if (!file_exists($basePath)) {
            return '';
        }

        // Check for WebP version
        $webpPath = preg_replace('/\.(jpg|jpeg|png)$/i', '.webp', $basePath);
        if (file_exists($webpPath)) {
            $webpUrl = preg_replace('/\.(jpg|jpeg|png)$/i', '.webp', $url);
            // Get image width
            $imageInfo = @getimagesize($basePath);
            if ($imageInfo) {
                $srcset[] = $webpUrl . ' ' . $imageInfo[0] . 'w';
            }
        }

        // Check for thumbnail
        $thumbPath = preg_replace('/\.(\w+)$/', '_thumb.$1', $basePath);
        $thumbWebpPath = preg_replace('/\.(jpg|jpeg|png)$/i', '.webp', $thumbPath);

        if (file_exists($thumbWebpPath)) {
            $thumbWebpUrl = preg_replace('/\.(\w+)$/', '_thumb.$1', $url);
            $thumbWebpUrl = preg_replace('/\.(jpg|jpeg|png)$/i', '.webp', $thumbWebpUrl);
            $srcset[] = $thumbWebpUrl . ' 800w';
        } elseif (file_exists($thumbPath)) {
            $thumbUrl = preg_replace('/\.(\w+)$/', '_thumb.$1', $url);
            $srcset[] = $thumbUrl . ' 800w';
        }

        return implode(', ', $srcset);
    }

    /**
     * Get sizes attribute based on image size setting
     */
    private function getSizesAttribute(string $size): string
    {
        return match ($size) {
            'small' => '(max-width: 320px) 100vw, 320px',
            'medium' => '(max-width: 448px) 100vw, 448px',
            'large' => '(max-width: 672px) 100vw, 672px',
            default => '100vw',
        };
    }

    /**
     * Get thumbnail URL for an image
     */
    private function getThumbUrl(string $url): string
    {
        if (!str_starts_with($url, '/')) {
            return $url;
        }

        $thumbUrl = preg_replace('/\.(\w+)$/', '_thumb.$1', $url);
        $thumbPath = $this->projectDir . '/public' . $thumbUrl;

        // Prefer WebP thumbnail
        $thumbWebpUrl = preg_replace('/\.(jpg|jpeg|png)$/i', '.webp', $thumbUrl);
        $thumbWebpPath = $this->projectDir . '/public' . $thumbWebpUrl;

        if (file_exists($thumbWebpPath)) {
            return $thumbWebpUrl;
        }

        if (file_exists($thumbPath)) {
            return $thumbUrl;
        }

        return $url;
    }
}
