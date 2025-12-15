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
echo "PHP: " . PHP_VERSION . "\n\n";

// Trouver composer sur OVH
$composerPaths = [
    '/usr/local/bin/composer',
    '/usr/bin/composer',
    'composer',
    'composer.phar',
    $projectDir . '/composer.phar',
];

$composer = null;
foreach ($composerPaths as $path) {
    exec("which $path 2>/dev/null", $output, $code);
    if ($code === 0 || file_exists($path)) {
        $composer = $path;
        break;
    }
    $output = [];
}

// Si composer n'est pas trouvé, le télécharger
if (!$composer) {
    echo "--- Telechargement de Composer ---\n";
    $composerSetup = file_get_contents('https://getcomposer.org/installer');
    file_put_contents('composer-setup.php', $composerSetup);
    exec('php composer-setup.php --quiet 2>&1', $output, $code);
    unlink('composer-setup.php');
    if (file_exists($projectDir . '/composer.phar')) {
        $composer = 'php ' . $projectDir . '/composer.phar';
        echo "Composer telecharge: composer.phar\n\n";
    } else {
        echo "[ERREUR] Impossible de telecharger Composer\n";
        echo implode("\n", $output) . "\n";
        exit(1);
    }
} else {
    echo "Composer trouve: $composer\n\n";
    // Si c'est un chemin vers composer.phar, préfixer avec php
    if (strpos($composer, '.phar') !== false && strpos($composer, 'php ') === false) {
        $composer = 'php ' . $composer;
    }
}

// Vérifier PHP CLI
echo "--- Verification PHP CLI ---\n";
exec('php -v 2>&1', $phpVersion, $code);
echo implode("\n", array_slice($phpVersion, 0, 1)) . "\n\n";

// Étapes de déploiement
$steps = [
    'Composer install' => "$composer install --no-dev --optimize-autoloader --no-interaction 2>&1",
    'Cache clear' => 'php bin/console cache:clear --env=prod --no-interaction 2>&1',
    'Cache warmup' => 'php bin/console cache:warmup --env=prod --no-interaction 2>&1',
    'Assets install' => 'php bin/console assets:install public --env=prod --no-interaction 2>&1',
    'Migrations' => 'php bin/console doctrine:migrations:migrate --no-interaction --env=prod --allow-no-migration 2>&1',
];

$success = true;
$errors = [];

foreach ($steps as $name => $command) {
    echo "--- $name ---\n";
    echo "Commande: $command\n";
    $output = [];
    $returnCode = 0;

    exec($command, $output, $returnCode);

    $outputStr = implode("\n", $output);
    echo $outputStr . "\n";

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
        $dotenv = new \Symfony\Component\Dotenv\Dotenv();
        $dotenv->loadEnv($projectDir . '/.env');

        $dbUrl = $_ENV['DATABASE_URL'] ?? '';
        if ($dbUrl) {
            $params = parse_url($dbUrl);
            $dbname = ltrim($params['path'] ?? '', '/');
            $pdo = new PDO(
                "mysql:host={$params['host']};port=" . ($params['port'] ?? 3306) . ";dbname=$dbname",
                $params['user'] ?? '',
                $params['pass'] ?? '',
                [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
            );
            echo "[OK] Connexion base de donnees reussie\n";
        }
    }
} catch (Exception $e) {
    echo "[ERREUR] Base de donnees: " . $e->getMessage() . "\n";
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
    echo "Testez le site: https://beta.plongee-venetes.fr\n";
} else {
    echo "\n⚠️ Deploiement termine avec des erreurs.\n";
    echo "Verifiez les messages ci-dessus.\n";
}
