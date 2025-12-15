<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

final class Version20251215190000 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Add notify_on_creation column to event_type table';
    }

    public function up(Schema $schema): void
    {
        $this->addSql('ALTER TABLE event_type ADD notify_on_creation TINYINT(1) DEFAULT 0 NOT NULL');
    }

    public function down(Schema $schema): void
    {
        $this->addSql('ALTER TABLE event_type DROP notify_on_creation');
    }
}
