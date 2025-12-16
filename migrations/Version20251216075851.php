<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251216075851 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // Ajout du champ is_lifeguard sur users
        $this->addSql('ALTER TABLE users ADD is_lifeguard TINYINT(1) NOT NULL DEFAULT 0');
        // Note: notify_on_creation existe déjà en prod, on ne l'ajoute pas ici
    }

    public function down(Schema $schema): void
    {
        $this->addSql('ALTER TABLE users DROP is_lifeguard');
    }
}
