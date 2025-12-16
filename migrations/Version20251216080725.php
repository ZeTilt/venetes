<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251216080725 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // Ajout du champ lifeguard sur event
        $this->addSql('ALTER TABLE event ADD lifeguard_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA7BE99BA8F FOREIGN KEY (lifeguard_id) REFERENCES users (id)');
        $this->addSql('CREATE INDEX IDX_3BAE0AA7BE99BA8F ON event (lifeguard_id)');
    }

    public function down(Schema $schema): void
    {
        $this->addSql('ALTER TABLE event DROP FOREIGN KEY FK_3BAE0AA7BE99BA8F');
        $this->addSql('DROP INDEX IDX_3BAE0AA7BE99BA8F ON event');
        $this->addSql('ALTER TABLE event DROP lifeguard_id');
    }
}
