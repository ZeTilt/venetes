<?php
/**
 * Initialisation de la base de données (à utiliser une seule fois)
 */

$secretToken = '9e09431816b075ff16d3494e28f413bf';

if (($_GET['token'] ?? '') !== $secretToken) {
    http_response_code(403);
    die('Acces interdit');
}

set_time_limit(300);
header('Content-Type: text/plain; charset=utf-8');

$projectDir = dirname(__DIR__);
chdir($projectDir);

$php = '/usr/local/php8.3/bin/php';

echo "=== INITIALISATION BASE DE DONNEES ===\n";
echo "Date: " . date('Y-m-d H:i:s') . "\n\n";

// Étape 1: Créer le schéma complet
echo "--- Creation du schema ---\n";
$cmd = "$php bin/console doctrine:schema:create --env=prod --no-interaction 2>&1";
echo "$ $cmd\n";
passthru($cmd, $code1);
echo "\nCode retour: $code1\n\n";

// Étape 2: Marquer toutes les migrations comme exécutées
echo "--- Marquage des migrations ---\n";
$cmd = "$php bin/console doctrine:migrations:version --add --all --no-interaction --env=prod 2>&1";
echo "$ $cmd\n";
passthru($cmd, $code2);
echo "\nCode retour: $code2\n\n";

// Étape 3: Charger les fixtures (données de base)
echo "--- Chargement des fixtures ---\n";
$cmd = "$php bin/console doctrine:fixtures:load --no-interaction --env=prod 2>&1";
echo "$ $cmd\n";
passthru($cmd, $code3);
echo "\nCode retour: $code3\n\n";

echo "=== FIN INITIALISATION ===\n";
if ($code1 === 0 && $code2 === 0) {
    echo "✅ Base de donnees initialisee avec succes!\n";
    echo "\nSupprimez ce fichier apres utilisation pour des raisons de securite.\n";
} else {
    echo "⚠️ Des erreurs sont survenues\n";
}
