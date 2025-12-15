# Guide de Déploiement - OVH Hébergement Mutualisé

Ce guide est spécifique au déploiement sur hébergement mutualisé OVH (Web Hosting).
Pour un déploiement sur VPS, voir `DEPLOYMENT_OVH.md`.

## Architecture

```
OVH Mutualisé (cluster007.ovh.net)
├── plongee-venetes.fr/        # PROD (branche main)
│   ├── .env.local
│   ├── .ovhconfig (PHP 8.3)
│   └── public/
└── beta.plongee-venetes.fr/   # BETA (branche release)
    ├── .env.local
    ├── .ovhconfig (PHP 8.3)
    └── public/

Base de données: O2Switch (externe)
├── empo8897_venetes_prod     # PROD
└── empo8897_venetes_preprod  # BETA
```

## 1. Configuration Git sur OVH

### 1.1 Dans le Manager OVH

1. Connexion [Manager OVH](https://www.ovh.com/manager/)
2. **Web Cloud** > **Hébergements** > `plongee-venetes.fr`
3. **Multisite** > Sélectionner le sous-domaine (ex: `beta`)
4. **Modifier** > Section **Déploiement Git**

### 1.2 Configuration du dépôt

| Champ | Valeur BETA | Valeur PROD |
|-------|-------------|-------------|
| Dépôt | `https://github.com/ZeTilt/venetes.git` | `https://github.com/ZeTilt/venetes.git` |
| Branche | `release` | `main` |
| Répertoire | `beta` | (racine) |

### 1.3 Configuration du Webhook GitHub

1. Aller sur **GitHub** > **ZeTilt/venetes** > **Settings** > **Webhooks**
2. Cliquer **Add webhook**
3. Configurer :

| Champ | Valeur |
|-------|--------|
| Payload URL | (URL fournie par OVH) |
| Content type | `application/json` |
| Secret | (laisser vide) |
| Events | ☑ Just the push event |
| Active | ☑ |

4. Cliquer **Add webhook**

**URL Webhook BETA :**
```
https://webhooks-webhosting.eu.ovhapis.com/1.0/vcs/github/push/eyJhbGciOiJFZERTQSIsImtpZCI6IjEiLCJ0eXAiOiJKV1QifQ.eyJzdWIiOiJnaXRodWIvaG04NTAzNS1vdmgiLCJleHAiOjI1MjQ2MDc5OTksImp0aSI6IjM4NDc4ODhlMDA1MDcxOWY0OTBkYTEyOTFlMWU4MTViZDA3NGZiMDAiLCJ2ZXJzaW9uIjoxLCJuYW1lIjoicGxvbmdlZS12ZW5ldGVzLmZyIiwicGF0aCI6ImJldGEiLCJjb3VudGVyIjowfQ.eDi9eGPEpPpR4MAHybGwfpsmZoEEIsjiXCogDhS-WfxI8j4-HuHuVr9H6gI0SywncgbtP745lTSMqUFnCa2yAw
```

## 2. Configuration PHP (.ovhconfig)

Le fichier `.ovhconfig` à la racine configure PHP :

```ini
app.engine=php
app.engine.version=8.3
http.firewall=none
environment=production
container.image=stable64
```

Ce fichier est déjà inclus dans le repo et sera déployé automatiquement.

## 3. Variables d'environnement (.env.local)

### 3.1 Créer le fichier via FTP

Connexion FTP :
- **Hôte** : `ftp.cluster007.hosting.ovh.net`
- **Port** : `21`
- **Utilisateur** : (voir Manager OVH > FTP-SSH)
- **Mot de passe** : (voir Manager OVH > FTP-SSH)

Créer le fichier `.env.local` dans le répertoire du site (ex: `/beta/.env.local`).

### 3.2 Contenu du .env.local

```env
###> symfony/framework-bundle ###
APP_ENV=prod
APP_DEBUG=false
APP_SECRET=VOTRE_CLE_64_CHARS
###< symfony/framework-bundle ###

###> doctrine/doctrine-bundle ###
# Base de données O2Switch
DATABASE_URL="mysql://UTILISATEUR:MOT_DE_PASSE@IP_O2SWITCH:3306/NOM_BDD?serverVersion=8.0&charset=utf8mb4"
###< doctrine/doctrine-bundle ###

###> symfony/mailer ###
# SMTP O2Switch ou autre
MAILER_DSN=smtp://EMAIL:PASSWORD@smtp.server.com:465?encryption=ssl&auth_mode=login
###< symfony/mailer ###

###> app/caci ###
CACI_ENCRYPTION_KEY=VOTRE_CLE_64_CHARS_HEX
###< app/caci ###

###> app/cron ###
CRON_SECRET_TOKEN=VOTRE_TOKEN_32_CHARS
###< app/cron ###

###> app/push-notifications (optionnel) ###
VAPID_PUBLIC_KEY=
VAPID_PRIVATE_KEY=
VAPID_SUBJECT=mailto:contact@plongee-venetes.fr
###< app/push-notifications ###
```

### 3.3 Générer les clés

```bash
# APP_SECRET (64 caractères hex)
php -r "echo bin2hex(random_bytes(32));"

# CACI_ENCRYPTION_KEY (64 caractères hex)
openssl rand -hex 32

# CRON_SECRET_TOKEN (32 caractères hex)
php -r "echo bin2hex(random_bytes(16));"

# VAPID Keys (optionnel, pour push notifications)
npx web-push generate-vapid-keys
```

### 3.4 Configuration O2Switch pour accès distant

1. Connexion [cPanel O2Switch](https://cpanel.o2switch.net)
2. **Bases de données MySQL** > **MySQL distant**
3. Ajouter l'IP du serveur OVH : `213.186.33.18`
4. Trouver l'IP MySQL O2Switch : `host mysql-VOTRECOMPTE.o2switch.net`

## 4. Déploiement

### 4.1 Flux de déploiement

```
git push origin release
        │
        ▼
GitHub Webhook ──────► OVH Git Pull
                              │
                              ▼
                    Appeler deploy.php
                              │
                              ▼
                    ✅ Site mis à jour
```

### 4.2 Script de déploiement post-push

Après chaque `git push`, appeler dans le navigateur :

**BETA :**
```
https://beta.plongee-venetes.fr/deploy.php?token=VOTRE_DEPLOY_TOKEN
```

**PROD :**
```
https://plongee-venetes.fr/deploy.php?token=VOTRE_DEPLOY_TOKEN
```

Le token par défaut est : `CHANGE_ME_` + md5(`venetes2025`)
```
CHANGE_ME_ed7e6f8b9a0c1d2e3f4a5b6c7d8e9f0a
```

**⚠️ IMPORTANT : Changer ce token en production !**

Modifier dans `public/deploy.php` :
```php
$secretToken = 'VOTRE_NOUVEAU_TOKEN_SECRET';
```

### 4.3 Ce que fait deploy.php

1. `composer install --no-dev --optimize-autoloader`
2. `php bin/console cache:clear --env=prod`
3. `php bin/console cache:warmup --env=prod`
4. `php bin/console assets:install --env=prod`
5. `php bin/console doctrine:migrations:migrate --no-interaction --env=prod`

### 4.4 Workflow Git recommandé

```bash
# 1. Développer sur une feature branch
git checkout release
git checkout -b feature/ma-feature
# ... développement ...
git commit -m "feat: ma feature"
git push origin feature/ma-feature

# 2. Merger dans release (BETA)
git checkout release
git merge feature/ma-feature
git push origin release
# => OVH pull automatique
# => Appeler deploy.php?token=XXX sur BETA

# 3. Tester sur beta.plongee-venetes.fr

# 4. Si OK, merger dans main (PROD)
git checkout main
git merge release
git push origin main
# => OVH pull automatique
# => Appeler deploy.php?token=XXX sur PROD
```

## 5. Tâches planifiées (Cron HTTP)

Sur hébergement mutualisé, pas de vrai cron. On utilise des services externes.

### 5.1 Endpoints disponibles

| Tâche | URL | Fréquence |
|-------|-----|-----------|
| Status | `/cron/{token}/status` | Test |
| CACI Reminder | `/cron/{token}/caci-reminder` | Lundi 9h |
| CACI Retention | `/cron/{token}/caci-retention` | Tous les jours 3h |

### 5.2 Configuration cron-job.org (gratuit)

1. Créer un compte sur [cron-job.org](https://cron-job.org)
2. Ajouter les tâches :

**CACI Reminder (PROD uniquement) :**
- URL : `https://plongee-venetes.fr/cron/VOTRE_TOKEN/caci-reminder`
- Schedule : `0 9 * * 1` (Lundi 9h)
- Request method : GET

**CACI Retention (PROD uniquement) :**
- URL : `https://plongee-venetes.fr/cron/VOTRE_TOKEN/caci-retention`
- Schedule : `0 3 * * *` (Tous les jours 3h)
- Request method : GET

### 5.3 Alternatives à cron-job.org

- [EasyCron](https://www.easycron.com/) - Gratuit (1 job)
- [Cronitor](https://cronitor.io/) - Gratuit (5 jobs)
- Raspberry Pi / serveur personnel avec cron

## 6. Accès FTP/SSH

### 6.1 Credentials FTP

Voir dans Manager OVH > Hébergements > FTP-SSH

| Paramètre | Valeur |
|-----------|--------|
| Serveur | `ftp.cluster007.hosting.ovh.net` |
| Port | `21` |
| Utilisateur | `hmXXXXX-ovh` |
| Mot de passe | (défini dans Manager) |

### 6.2 Activer SSH (optionnel)

1. Manager OVH > Hébergements > FTP-SSH
2. Modifier le login
3. Activer "Accès SSH"
4. Attendre ~15 minutes

Connexion :
```bash
ssh hmXXXXX-ovh@ssh.cluster007.hosting.ovh.net
```

**Note :** SSH sur mutualisé = pas d'accès root, juste votre espace.

## 7. Structure des fichiers sur OVH

```
/home/hmXXXXX-ovh/
├── www/                          # Site principal (PROD)
│   ├── .env.local               # ⚠️ À créer manuellement
│   ├── .ovhconfig
│   ├── public/
│   │   ├── index.php
│   │   ├── deploy.php
│   │   └── ...
│   ├── src/
│   ├── var/
│   │   ├── cache/
│   │   ├── log/
│   │   └── caci_storage/        # Certificats chiffrés
│   └── vendor/
│
└── beta/                         # Sous-domaine BETA
    ├── .env.local               # ⚠️ À créer manuellement
    ├── .ovhconfig
    └── ...
```

## 8. Dépannage

### Le déploiement Git ne fonctionne pas

1. Vérifier que le répertoire cible est vide avant le premier déploiement
2. Vérifier le webhook dans GitHub > Settings > Webhooks (voir "Recent Deliveries")
3. Vérifier les logs OVH dans Manager > Hébergements > Logs

### Erreur 500 après déploiement

1. Vérifier que `.env.local` existe
2. Appeler `deploy.php` pour installer les dépendances
3. Vérifier les logs : `/var/log/prod.log` (via FTP)

### "Class not found" ou erreur autoload

```
https://DOMAINE/deploy.php?token=XXX
```
Cela relance `composer install`.

### Permissions sur var/

Si erreur de permissions sur `var/cache` ou `var/log` :
- Via FTP, mettre les droits `755` sur le dossier `var/`
- OVH gère normalement les permissions automatiquement

### Base de données inaccessible

1. Vérifier que l'IP OVH (`213.186.33.18`) est autorisée dans O2Switch
2. Vérifier l'URL dans `.env.local`
3. Tester la connexion : créer un fichier `test-db.php` temporaire

## 9. Checklist déploiement initial

### BETA

- [ ] Webhook GitHub configuré pour branche `release`
- [ ] `.env.local` créé via FTP dans `/beta/`
- [ ] IP OVH autorisée dans O2Switch
- [ ] Premier `git push origin release`
- [ ] Appel `deploy.php?token=XXX`
- [ ] Test https://beta.plongee-venetes.fr
- [ ] Connexion admin fonctionne

### PROD

- [ ] Webhook GitHub configuré pour branche `main`
- [ ] `.env.local` créé via FTP dans `/www/`
- [ ] Premier `git push origin main`
- [ ] Appel `deploy.php?token=XXX`
- [ ] Test https://plongee-venetes.fr
- [ ] Connexion admin fonctionne
- [ ] Cron jobs configurés sur cron-job.org
- [ ] Token deploy.php changé (pas le défaut)
- [ ] CRON_SECRET_TOKEN changé

## 10. Commandes utiles (si SSH activé)

```bash
# Connexion SSH
ssh hmXXXXX-ovh@ssh.cluster007.hosting.ovh.net

# Aller dans le site
cd www  # ou cd beta

# Vider le cache manuellement
php bin/console cache:clear --env=prod

# Voir les logs
tail -f var/log/prod.log

# Lancer une migration
php bin/console doctrine:migrations:migrate --env=prod

# Créer un admin
php bin/console app:create-admin email@example.com MotDePasse --env=prod
```

## Résumé

| Action | Commande/URL |
|--------|--------------|
| Déployer BETA | `git push origin release` puis `deploy.php?token=XXX` |
| Déployer PROD | `git push origin main` puis `deploy.php?token=XXX` |
| Cron CACI Reminder | cron-job.org → `/cron/TOKEN/caci-reminder` |
| Cron CACI Retention | cron-job.org → `/cron/TOKEN/caci-retention` |
| Logs | FTP → `/var/log/prod.log` |
| Config | FTP → `.env.local` |
