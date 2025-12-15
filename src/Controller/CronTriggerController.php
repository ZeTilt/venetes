<?php

namespace App\Controller;

use App\Command\CaciReminderCommand;
use App\Command\CaciRetentionCommand;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Console\Input\ArrayInput;
use Symfony\Component\Console\Output\BufferedOutput;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * Contrôleur pour déclencher les tâches cron via HTTP
 *
 * Utile sur hébergement mutualisé sans accès aux vrais cron jobs.
 * Appeler depuis cron-job.org ou manuellement.
 */
#[Route('/cron')]
class CronTriggerController extends AbstractController
{
    public function __construct(
        private CaciReminderCommand $caciReminderCommand,
        private CaciRetentionCommand $caciRetentionCommand,
    ) {}

    #[Route('/{token}/status', name: 'cron_status', methods: ['GET'])]
    public function status(string $token): Response
    {
        $this->validateToken($token);

        return new Response("Cron endpoint OK\n" . date('Y-m-d H:i:s'), 200, [
            'Content-Type' => 'text/plain'
        ]);
    }

    #[Route('/{token}/caci-reminder', name: 'cron_caci_reminder', methods: ['GET'])]
    public function caciReminder(string $token): Response
    {
        $this->validateToken($token);

        $input = new ArrayInput([]);
        $output = new BufferedOutput();

        try {
            $returnCode = $this->caciReminderCommand->run($input, $output);
            $content = $output->fetch();

            return new Response(
                "=== CACI Reminder ===\n" . $content . "\nCode: $returnCode",
                $returnCode === 0 ? 200 : 500,
                ['Content-Type' => 'text/plain']
            );
        } catch (\Exception $e) {
            return new Response(
                "Erreur: " . $e->getMessage(),
                500,
                ['Content-Type' => 'text/plain']
            );
        }
    }

    #[Route('/{token}/caci-retention', name: 'cron_caci_retention', methods: ['GET'])]
    public function caciRetention(string $token): Response
    {
        $this->validateToken($token);

        $input = new ArrayInput([]);
        $output = new BufferedOutput();

        try {
            $returnCode = $this->caciRetentionCommand->run($input, $output);
            $content = $output->fetch();

            return new Response(
                "=== CACI Retention ===\n" . $content . "\nCode: $returnCode",
                $returnCode === 0 ? 200 : 500,
                ['Content-Type' => 'text/plain']
            );
        } catch (\Exception $e) {
            return new Response(
                "Erreur: " . $e->getMessage(),
                500,
                ['Content-Type' => 'text/plain']
            );
        }
    }

    #[Route('/{token}/cache-clear', name: 'cron_cache_clear', methods: ['GET'])]
    public function cacheClear(string $token): Response
    {
        $this->validateToken($token);

        $cacheDir = $this->getParameter('kernel.cache_dir');

        // On ne peut pas vraiment clear le cache depuis une requête active
        // Mais on peut créer un flag pour le prochain déploiement
        return new Response(
            "Cache clear: utilisez plutot deploy.php\nCache dir: $cacheDir",
            200,
            ['Content-Type' => 'text/plain']
        );
    }

    private function validateToken(string $token): void
    {
        $expectedToken = $_ENV['CRON_SECRET_TOKEN'] ?? 'default_change_me';

        if (!hash_equals($expectedToken, $token)) {
            throw $this->createAccessDeniedException('Token invalide');
        }
    }
}
