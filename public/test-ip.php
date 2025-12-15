<?php
// Récupère l'IP sortante du serveur OVH
echo "IP sortante OVH: " . file_get_contents('https://api.ipify.org');
