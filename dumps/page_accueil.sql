-- Page Accueil pour édition depuis le backoffice
INSERT INTO `pages` (id, author_id, title, slug, excerpt, content, template_path, type, status, featured_image, meta_title, meta_description, tags, published_at, created_at, updated_at, sort_order, use_blocks)
VALUES (
    11,
    1,
    'Accueil',
    'accueil',
    'Page d''accueil du site',
    '<h2 class="cta-title">Prêt à plonger avec nous ?</h2>
<p class="cta-text">
    Rejoignez le Club Subaquatique des Vénètes et découvrez les merveilles des fonds marins.
    Formation, convivialité et aventure vous attendent !
</p>
<div class="cta-buttons">
    <a href="/tarifs-2025" class="cta-btn cta-btn-primary">
        Voir nos tarifs
    </a>
    <a href="/contact" class="cta-btn cta-btn-secondary">
        Nous contacter
    </a>
</div>',
    'home/index.html.twig',
    'home',
    'published',
    NULL,
    'Accueil - Club Subaquatique des Vénètes',
    'Club de plongée à Vannes. Formations FFESSM, sorties en mer, convivialité.',
    '[]',
    NOW(),
    NOW(),
    NOW(),
    0,
    0
);
