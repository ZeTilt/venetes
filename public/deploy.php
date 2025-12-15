<?php
/**
 * Script de déploiement post-push pour OVH Mutualisé
 *
 * Appeler après chaque git push :
 * https://beta.plongee-venetes.fr/deploy.php?token=VOTRE_TOKEN
 */

// Token de sécurité
$secretToken = '9e09431816b075ff16d3494e28f413bf';

// Vérification du token
if (($_GET['token'] ?? '') !== $secretToken) {
    http_response_code(403);
    header('Content-Type: text/plain');
    die('Acces interdit. Token invalide.');
}

// Configuration
set_time_limit(600); // 10 minutes max
header('Content-Type: text/plain; charset=utf-8');

$projectDir = dirname(__DIR__);
chdir($projectDir);

echo "=== DEPLOIEMENT VENETES (OVH Mutualise) ===\n";
echo "Date: " . date('Y-m-d H:i:s') . "\n";
echo "Repertoire: $projectDir\n";
echo "PHP version: " . PHP_VERSION . "\n\n";

// Trouver PHP sur OVH mutualisé
$phpPaths = [
    '/usr/local/php8.3/bin/php',
    '/usr/local/php8.2/bin/php',
    '/usr/local/php8.1/bin/php',
    '/usr/bin/php8.3',
    '/usr/bin/php',
    'php',
];

$php = null;
echo "--- Recherche PHP CLI ---\n";
foreach ($phpPaths as $path) {
    if (file_exists($path) || ($path === 'php')) {
        exec("$path -v 2>&1", $output, $code);
        if ($code === 0 && !empty($output)) {
            $php = $path;
            echo "PHP trouve: $path\n";
            echo $output[0] . "\n";
            break;
        }
        $output = [];
    }
}

if (!$php) {
    // Essayer de trouver PHP via which
    exec('which php 2>&1', $whichOutput, $code);
    if ($code === 0 && !empty($whichOutput)) {
        $php = trim($whichOutput[0]);
        echo "PHP trouve via which: $php\n";
    }
}

if (!$php) {
    echo "[ERREUR] PHP CLI non trouve!\n";
    echo "Chemins testes:\n";
    foreach ($phpPaths as $path) {
        echo "  - $path\n";
    }
    exit(1);
}
echo "\n";

// Trouver ou télécharger Composer
$composerPaths = [
    $projectDir . '/composer.phar',
    '/usr/local/bin/composer',
    '/usr/bin/composer',
];

$composer = null;
echo "--- Recherche Composer ---\n";
foreach ($composerPaths as $path) {
    if (file_exists($path)) {
        $composer = $path;
        echo "Composer trouve: $path\n";
        break;
    }
}

if (!$composer) {
    echo "Composer non trouve, telechargement...\n";

    // Télécharger composer via PHP (pas via exec)
    $installerUrl = 'https://getcomposer.org/installer';
    $installerCode = @file_get_contents($installerUrl);

    if ($installerCode === false) {
        echo "[ERREUR] Impossible de telecharger l'installeur Composer\n";
        exit(1);
    }

    file_put_contents($projectDir . '/composer-setup.php', $installerCode);

    // Exécuter l'installeur
    exec("$php {$projectDir}/composer-setup.php --install-dir={$projectDir} --filename=composer.phar 2>&1", $output, $code);
    echo implode("\n", $output) . "\n";

    @unlink($projectDir . '/composer-setup.php');

    if (file_exists($projectDir . '/composer.phar')) {
        $composer = $projectDir . '/composer.phar';
        echo "Composer telecharge avec succes!\n";
    } else {
        echo "[ERREUR] Echec du telechargement de Composer\n";
        exit(1);
    }
}
echo "\n";

// Construire les commandes avec le bon chemin PHP
$composerCmd = (strpos($composer, '.phar') !== false)
    ? "$php $composer"
    : $composer;

// Étapes de déploiement
$steps = [
    'Composer install' => "$composerCmd install --no-dev --optimize-autoloader --no-interaction",
    'Cache clear' => "$php bin/console cache:clear --env=prod --no-interaction",
    'Cache warmup' => "$php bin/console cache:warmup --env=prod --no-interaction",
    'Assets install' => "$php bin/console assets:install public --env=prod --no-interaction",
    'Migrations' => "$php bin/console doctrine:migrations:migrate --no-interaction --env=prod --allow-no-migration",
];

$success = true;
$errors = [];

foreach ($steps as $name => $command) {
    echo "--- $name ---\n";
    echo "$ $command\n";
    $output = [];
    $returnCode = 0;

    exec("$command 2>&1", $output, $returnCode);

    echo implode("\n", $output) . "\n";

    if ($returnCode !== 0) {
        echo "[ERREUR] Code retour: $returnCode\n";
        $success = false;
        $errors[] = $name;
    } else {
        echo "[OK]\n";
    }
    echo "\n";
}

// Vérification finale
echo "=== VERIFICATION FINALE ===\n";

// Test autoloader
if (file_exists($projectDir . '/vendor/autoload.php')) {
    echo "[OK] Autoloader Composer present\n";
} else {
    echo "[ERREUR] Autoloader Composer manquant\n";
    $success = false;
}

// Test .env.local
if (file_exists($projectDir . '/.env.local')) {
    echo "[OK] .env.local present\n";
} else {
    echo "[ERREUR] .env.local manquant - uploadez-le via FTP\n";
    $success = false;
}

// Test connexion BDD
echo "\n--- Test connexion base de donnees ---\n";
try {
    if (file_exists($projectDir . '/vendor/autoload.php')) {
        require $projectDir . '/vendor/autoload.php';

        // Charger les variables d'environnement
        if (file_exists($projectDir . '/.env.local')) {
            $dotenv = new \Symfony\Component\Dotenv\Dotenv();
            $dotenv->loadEnv($projectDir . '/.env');
        }

        $dbUrl = $_ENV['DATABASE_URL'] ?? $_SERVER['DATABASE_URL'] ?? '';
        if ($dbUrl) {
            $params = parse_url($dbUrl);
            $dbname = ltrim($params['path'] ?? '', '/');
            $pdo = new PDO(
                "mysql:host={$params['host']};port=" . ($params['port'] ?? 3306) . ";dbname=$dbname",
                $params['user'] ?? '',
                urldecode($params['pass'] ?? ''),
                [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
            );
            echo "[OK] Connexion BDD reussie ($dbname)\n";
        } else {
            echo "[WARN] DATABASE_URL non defini\n";
        }
    }
} catch (Exception $e) {
    echo "[ERREUR] BDD: " . $e->getMessage() . "\n";
    $success = false;
}

echo "\n=== FIN DEPLOIEMENT ===\n";
echo "Statut: " . ($success ? 'SUCCES' : 'ERREUR') . "\n";
if (!empty($errors)) {
    echo "Etapes en erreur: " . implode(', ', $errors) . "\n";
}
echo "Duree: " . round(microtime(true) - $_SERVER['REQUEST_TIME_FLOAT'], 2) . "s\n";

if ($success) {
    echo "\n✅ Deploiement termine avec succes!\n";
    echo "Testez: https://beta.plongee-venetes.fr\n";
} else {
    echo "\n⚠️ Deploiement avec erreurs - verifiez ci-dessus\n";
}
