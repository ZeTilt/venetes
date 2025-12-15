<?php
/**
 * Script de déploiement post-push
 *
 * Appeler après chaque git push :
 * https://beta.plongee-venetes.fr/deploy.php?token=VOTRE_TOKEN
 *
 * IMPORTANT: Changer le token ci-dessous !
 */

// Token de sécurité - À CHANGER !
$secretToken = 'CHANGE_ME_' . md5('venetes2025');

// Vérification du token
if (($_GET['token'] ?? '') !== $secretToken) {
    http_response_code(403);
    header('Content-Type: text/plain');
    die('Acces interdit. Token invalide.');
}

// Configuration
set_time_limit(300); // 5 minutes max
header('Content-Type: text/plain; charset=utf-8');

$projectDir = dirname(__DIR__);
chdir($projectDir);

echo "=== DEPLOIEMENT VENETES ===\n";
echo "Date: " . date('Y-m-d H:i:s') . "\n";
echo "Repertoire: $projectDir\n\n";

$steps = [
    'Composer install' => 'composer install --no-dev --optimize-autoloader 2>&1',
    'Cache clear' => 'php bin/console cache:clear --env=prod 2>&1',
    'Cache warmup' => 'php bin/console cache:warmup --env=prod 2>&1',
    'Assets install' => 'php bin/console assets:install --env=prod 2>&1',
    'Migrations' => 'php bin/console doctrine:migrations:migrate --no-interaction --env=prod 2>&1',
];

$success = true;

foreach ($steps as $name => $command) {
    echo "--- $name ---\n";
    $output = [];
    $returnCode = 0;
    exec($command, $output, $returnCode);

    echo implode("\n", $output) . "\n";

    if ($returnCode !== 0) {
        echo "[ERREUR] Code retour: $returnCode\n";
        $success = false;
    } else {
        echo "[OK]\n";
    }
    echo "\n";
}

echo "=== FIN DEPLOIEMENT ===\n";
echo "Statut: " . ($success ? 'SUCCES' : 'ERREUR') . "\n";
echo "Duree: " . round(microtime(true) - $_SERVER['REQUEST_TIME_FLOAT'], 2) . "s\n";
