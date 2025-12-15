<?php
/**
 * Creation superadmin (supprimer apres utilisation)
 */

$secretToken = '9e09431816b075ff16d3494e28f413bf';

if (($_GET['token'] ?? '') !== $secretToken) {
    http_response_code(403);
    die('Acces interdit');
}

header('Content-Type: text/plain; charset=utf-8');

$projectDir = dirname(__DIR__);
$php = '/usr/local/php8.3/bin/php';

// Parametres - MODIFIEZ ICI
$email = $_GET['email'] ?? 'admin@plongee-venetes.fr';
$password = $_GET['password'] ?? 'ChangezMoi123!';
$firstName = $_GET['firstName'] ?? 'Admin';
$lastName = $_GET['lastName'] ?? 'Venetes';

echo "=== CREATION SUPERADMIN ===\n\n";

$cmd = sprintf(
    '%s %s/bin/console app:create-admin-user %s %s %s %s --env=prod 2>&1',
    $php,
    $projectDir,
    escapeshellarg($email),
    escapeshellarg($password),
    escapeshellarg($firstName),
    escapeshellarg($lastName)
);

echo "$ $cmd\n\n";
passthru($cmd, $code);

echo "\n\nSUPPRIMEZ CE FICHIER IMMEDIATEMENT !\n";
