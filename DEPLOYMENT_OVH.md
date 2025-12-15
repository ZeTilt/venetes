# Guide de Déploiement - OVH VPS

## Prérequis serveur

- VPS OVH (Ubuntu 22.04 LTS recommandé)
- Accès SSH root
- Nom de domaine pointant vers le VPS

## 1. Configuration initiale du serveur

```bash
# Connexion SSH
ssh root@IP_SERVEUR

# Mise à jour système
apt update && apt upgrade -y

# Installation des paquets essentiels
apt install -y git curl unzip nginx mysql-server php8.3-fpm \
  php8.3-mysql php8.3-xml php8.3-mbstring php8.3-zip php8.3-curl \
  php8.3-intl php8.3-gd php8.3-imagick certbot python3-certbot-nginx

# Si PHP 8.3 non disponible, ajouter le PPA :
add-apt-repository ppa:ondrej/php
apt update
apt install php8.3-fpm php8.3-mysql php8.3-xml php8.3-mbstring php8.3-zip php8.3-curl php8.3-intl php8.3-gd php8.3-imagick
```

## 2. Configuration MySQL

```bash
# Sécurisation MySQL
mysql_secure_installation

# Création de la base et de l'utilisateur
mysql -u root -p
```

```sql
CREATE DATABASE venetes_prod CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'venetes_user'@'localhost' IDENTIFIED BY 'MOT_DE_PASSE_SECURISE';
GRANT ALL PRIVILEGES ON venetes_prod.* TO 'venetes_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

## 3. Installation Composer

```bash
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
```

## 4. Clonage du projet

```bash
# Créer l'utilisateur web (si pas déjà fait)
useradd -m -s /bin/bash webuser
usermod -aG www-data webuser

# Cloner le repo
cd /var/www

# Pour la PROD (branche main)
git clone -b main https://github.com/ZeTilt/venetes.git venetes-prod

# Pour la BETA (branche release)
git clone -b release https://github.com/ZeTilt/venetes.git venetes-beta

chown -R webuser:www-data /var/www/venetes-*
```

## 5. Configuration de l'application

```bash
# Copier l'environnement de production
cp .env .env.local

# Éditer .env.local avec les vraies valeurs
nano .env.local
```

**Contenu complet de `.env.local` :**

```env
###> symfony/framework-bundle ###
APP_ENV=prod
APP_DEBUG=false
APP_SECRET=GENERER_64_CHARS_HEX
###< symfony/framework-bundle ###

###> doctrine/doctrine-bundle ###
# Option 1: BDD locale sur OVH
DATABASE_URL="mysql://venetes_user:MOT_DE_PASSE@localhost:3306/venetes_prod?serverVersion=8.0&charset=utf8mb4"

# Option 2: BDD distante O2Switch (voir section BDD distante)
# DATABASE_URL="mysql://USER:PASS@IP_O2SWITCH:3306/DATABASE?serverVersion=8.0&charset=utf8mb4"
###< doctrine/doctrine-bundle ###

###> symfony/mailer ###
# SMTP O2Switch
MAILER_DSN=smtp://EMAIL:PASSWORD@SERVEUR_SMTP:465?encryption=ssl&auth_mode=login
# Ou Brevo/Mailjet
# MAILER_DSN=smtp://api:KEY@smtp-relay.brevo.com:587
###< symfony/mailer ###

###> app/caci ###
# Clé de chiffrement CACI - OBLIGATOIRE (64 caractères hex)
CACI_ENCRYPTION_KEY=GENERER_64_CHARS_HEX
###< app/caci ###

###> app/push-notifications ###
# Clés VAPID pour les notifications push (optionnel)
# Générer avec: npx web-push generate-vapid-keys
VAPID_PUBLIC_KEY=
VAPID_PRIVATE_KEY=
VAPID_SUBJECT=mailto:contact@plongee-venetes.fr
###< app/push-notifications ###
```

**Générer les clés :**

```bash
# APP_SECRET (64 caractères hex)
php -r "echo bin2hex(random_bytes(32));"

# CACI_ENCRYPTION_KEY (64 caractères hex)
openssl rand -hex 32

# VAPID Keys (notifications push)
npx web-push generate-vapid-keys
```

**Variables obligatoires :**
| Variable | Description |
|----------|-------------|
| `APP_ENV` | `prod` pour production |
| `APP_SECRET` | Clé secrète Symfony (64 hex) |
| `DATABASE_URL` | URL de connexion MySQL |
| `MAILER_DSN` | Configuration SMTP |
| `CACI_ENCRYPTION_KEY` | Clé chiffrement certificats médicaux (64 hex) |

**Variables optionnelles :**
| Variable | Description |
|----------|-------------|
| `VAPID_PUBLIC_KEY` | Clé publique push notifications |
| `VAPID_PRIVATE_KEY` | Clé privée push notifications |
| `VAPID_SUBJECT` | Email contact pour push |

## 5b. BDD distante O2Switch (optionnel)

**Oui, tu peux brancher une BDD O2Switch sur une app OVH**, mais avec des précautions :

### Avantages
- Pas besoin de gérer MySQL sur OVH
- Backups O2Switch inclus
- Tu gardes tes données existantes

### Inconvénients
- **Latence** : +10-30ms par requête (réseau)
- **Sécurité** : trafic sur Internet (même chiffré SSL)
- **Dépendance** : si O2Switch down = site down

### Configuration O2Switch

1. **Autoriser l'IP OVH** dans phpMyAdmin O2Switch :
   - Accès distant > Ajouter l'IP de ton VPS OVH

2. **Trouver l'IP du serveur MySQL O2Switch** :
   ```bash
   # Depuis ta machine locale
   host mysql-TONCOMPTE.o2switch.net
   # Exemple: 109.234.165.62
   ```

3. **DATABASE_URL pour O2Switch** :
   ```env
   DATABASE_URL="mysql://COMPTE_FTP:MOT_DE_PASSE@IP_MYSQL_O2SWITCH:3306/NOM_BDD?serverVersion=8.0&charset=utf8mb4"
   ```

### Recommandation

Pour la **production** : BDD locale sur OVH (performances optimales)
Pour la **beta** : BDD O2Switch acceptable (tests, moins critique)

```
PROD (plongee-venetes.fr)
├── App: OVH VPS
└── BDD: MySQL local OVH (recommandé)

BETA (beta.plongee-venetes.fr)
├── App: OVH VPS
└── BDD: MySQL O2Switch (acceptable)
```

## 6. Installation des dépendances

```bash
# Pour chaque instance (prod et beta)
for ENV in venetes-prod venetes-beta; do
    cd /var/www/$ENV

    # Installation prod (sans dev)
    composer install --no-dev --optimize-autoloader

    # Cache et assets
    php bin/console cache:clear --env=prod
    php bin/console assets:install --env=prod

    # Migrations base de données
    php bin/console doctrine:migrations:migrate --no-interaction --env=prod
done
```

## 7. Permissions

```bash
# Permissions pour les deux instances
for ENV in venetes-prod venetes-beta; do
    chown -R webuser:www-data /var/www/$ENV
    chmod -R 755 /var/www/$ENV
    chmod -R 775 /var/www/$ENV/var
    chmod -R 775 /var/www/$ENV/public/uploads

    # Dossier CACI (stockage chiffré)
    mkdir -p /var/www/$ENV/var/caci_storage
    chmod 700 /var/www/$ENV/var/caci_storage
    chown webuser:www-data /var/www/$ENV/var/caci_storage
done
```

## 8. Configuration Nginx

### 8.1 PROD - plongee-venetes.fr

```bash
nano /etc/nginx/sites-available/venetes-prod
```

```nginx
server {
    listen 80;
    server_name plongee-venetes.fr www.plongee-venetes.fr;
    return 301 https://plongee-venetes.fr$request_uri;
}

server {
    listen 443 ssl http2;
    server_name plongee-venetes.fr www.plongee-venetes.fr;

    root /var/www/venetes-prod/public;
    index index.php;

    # Logs
    access_log /var/log/nginx/venetes-prod-access.log;
    error_log /var/log/nginx/venetes-prod-error.log;

    # Gzip
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml;

    # Cache static assets
    location ~* \.(css|js|jpg|jpeg|png|gif|ico|svg|webp|woff|woff2)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    location / {
        try_files $uri /index.php$is_args$args;
    }

    location ~ ^/index\.php(/|$) {
        fastcgi_pass unix:/var/run/php/php8.3-fpm.sock;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $realpath_root;
        internal;
    }

    location ~ \.php$ {
        return 404;
    }

    location ~ /\. {
        deny all;
    }
    location ~ ^/(var|config|vendor)/ {
        deny all;
    }
}
```

### 8.2 BETA - beta.plongee-venetes.fr

```bash
nano /etc/nginx/sites-available/venetes-beta
```

```nginx
server {
    listen 80;
    server_name beta.plongee-venetes.fr;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name beta.plongee-venetes.fr;

    root /var/www/venetes-beta/public;
    index index.php;

    # Logs
    access_log /var/log/nginx/venetes-beta-access.log;
    error_log /var/log/nginx/venetes-beta-error.log;

    # Gzip
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml;

    location ~* \.(css|js|jpg|jpeg|png|gif|ico|svg|webp|woff|woff2)$ {
        expires 7d;
        add_header Cache-Control "public";
    }

    location / {
        try_files $uri /index.php$is_args$args;
    }

    location ~ ^/index\.php(/|$) {
        fastcgi_pass unix:/var/run/php/php8.3-fpm.sock;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $realpath_root;
        internal;
    }

    location ~ \.php$ {
        return 404;
    }

    # Sécurité
    location ~ /\. {
        deny all;
    }
    location ~ ^/(var|config|vendor)/ {
        deny all;
    }
}
```

```bash
# Activer les sites
ln -s /etc/nginx/sites-available/venetes-prod /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/venetes-beta /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx
```

## 9. SSL avec Let's Encrypt

```bash
# PROD
certbot --nginx -d plongee-venetes.fr -d www.plongee-venetes.fr

# BETA
certbot --nginx -d beta.plongee-venetes.fr
```

## 10. Cron Jobs

```bash
crontab -e
```

Ajouter (uniquement pour PROD) :

```cron
# Rappels CACI (tous les lundis à 9h) - PROD uniquement
0 9 * * 1 cd /var/www/venetes-prod && php bin/console app:caci:reminder --env=prod >> /var/log/caci-reminder.log 2>&1

# Rétention CACI - suppression certificats expirés (tous les jours à 3h) - PROD uniquement
0 3 * * * cd /var/www/venetes-prod && php bin/console app:caci:retention --env=prod >> /var/log/caci-retention.log 2>&1

# Nettoyage cache Symfony (tous les dimanches à 4h)
0 4 * * 0 cd /var/www/venetes-prod && php bin/console cache:clear --env=prod >> /var/log/symfony-cache-prod.log 2>&1
0 5 * * 0 cd /var/www/venetes-beta && php bin/console cache:clear --env=prod >> /var/log/symfony-cache-beta.log 2>&1
```

## 11. Scripts de déploiement

### 11.1 Script PROD

```bash
nano /var/www/venetes-prod/deploy.sh
chmod +x /var/www/venetes-prod/deploy.sh
```

```bash
#!/bin/bash
# deploy.sh - Script de déploiement PROD

set -e
cd /var/www/venetes-prod

echo "=== Déploiement PROD ==="
echo "Date: $(date)"

git pull origin main
composer install --no-dev --optimize-autoloader
php bin/console doctrine:migrations:migrate --no-interaction --env=prod
php bin/console cache:clear --env=prod
php bin/console assets:install --env=prod

echo "=== PROD déployé ==="
```

### 11.2 Script BETA

```bash
nano /var/www/venetes-beta/deploy.sh
chmod +x /var/www/venetes-beta/deploy.sh
```

```bash
#!/bin/bash
# deploy.sh - Script de déploiement BETA

set -e
cd /var/www/venetes-beta

echo "=== Déploiement BETA ==="
echo "Date: $(date)"

git pull origin release
composer install --no-dev --optimize-autoloader
php bin/console doctrine:migrations:migrate --no-interaction --env=prod
php bin/console cache:clear --env=prod
php bin/console assets:install --env=prod

echo "=== BETA déployé ==="
```

**Utilisation :**

```bash
# Déployer PROD
/var/www/venetes-prod/deploy.sh

# Déployer BETA
/var/www/venetes-beta/deploy.sh
```

## 12. Monitoring et logs

```bash
# Logs Symfony PROD
tail -f /var/www/venetes-prod/var/log/prod.log

# Logs Symfony BETA
tail -f /var/www/venetes-beta/var/log/prod.log

# Logs Nginx
tail -f /var/log/nginx/venetes-prod-error.log
tail -f /var/log/nginx/venetes-beta-error.log

# Logs PHP-FPM
tail -f /var/log/php8.3-fpm.log
```

## 13. Checklist post-déploiement

### PROD (plongee-venetes.fr)
- [ ] Le site répond sur https://plongee-venetes.fr
- [ ] Redirect www → sans www fonctionne
- [ ] Connexion admin fonctionne
- [ ] Upload d'images fonctionne
- [ ] Envoi d'emails fonctionne (tester via contact)
- [ ] Certificat SSL valide
- [ ] Cron jobs configurés

### BETA (beta.plongee-venetes.fr)
- [ ] Le site répond sur https://beta.plongee-venetes.fr
- [ ] Connexion admin fonctionne
- [ ] Certificat SSL valide

## 14. Backups automatiques (PROD uniquement)

```bash
nano /root/backup-venetes.sh
chmod +x /root/backup-venetes.sh
```

```bash
#!/bin/bash
# backup-venetes.sh - Backup PROD uniquement

BACKUP_DIR="/root/backups"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

# Backup BDD PROD
mysqldump -u venetes_user -p'MOT_DE_PASSE' venetes_prod | gzip > $BACKUP_DIR/db_prod_$DATE.sql.gz

# Backup uploads PROD
tar -czf $BACKUP_DIR/uploads_prod_$DATE.tar.gz /var/www/venetes-prod/public/uploads

# Backup CACI (chiffré) PROD
tar -czf $BACKUP_DIR/caci_prod_$DATE.tar.gz /var/www/venetes-prod/var/caci_storage

# Garder seulement les 7 derniers backups
find $BACKUP_DIR -name "*.gz" -mtime +7 -delete

echo "Backup PROD terminé: $DATE"
```

```bash
# Cron backup quotidien à 2h
crontab -e
# Ajouter:
0 2 * * * /root/backup-venetes.sh >> /var/log/backup-venetes.log 2>&1
```

## 15. Workflow Git

```
main (prod)          release (beta)
    │                     │
    │   ┌─────────────────┤
    │   │ feature/xxx     │
    │   │     │           │
    │   │     └───────────┼──► Merge dans release
    │   │                 │    (test sur beta)
    │   │                 │
    │   └─────────────────┼──► Si OK, merge dans main
    │                     │    (déploiement prod)
    ▼                     ▼
```

**Commandes :**

```bash
# Développer une feature
git checkout release
git checkout -b feature/ma-feature
# ... développement ...
git push origin feature/ma-feature

# Merger dans release (beta)
git checkout release
git merge feature/ma-feature
git push origin release
# => Déployer beta: /var/www/venetes-beta/deploy.sh

# Après validation, merger dans main (prod)
git checkout main
git merge release
git push origin main
# => Déployer prod: /var/www/venetes-prod/deploy.sh
```

## Résumé des commandes

```bash
# Déploiement PROD
/var/www/venetes-prod/deploy.sh

# Déploiement BETA
/var/www/venetes-beta/deploy.sh

# Voir les logs PROD
tail -f /var/www/venetes-prod/var/log/prod.log

# Vider le cache PROD
cd /var/www/venetes-prod && php bin/console cache:clear --env=prod

# Créer un admin PROD
cd /var/www/venetes-prod && php bin/console app:create-admin email@example.com MotDePasse --env=prod
```
