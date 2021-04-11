<?php

/**
 * Configurations des serveurs
 */
$i = 1;

/**
 * Il est nécessaire pour l'authentification basée sur les cookies pour crypter le mot de passe dans le cookie. 
 * Doit avoir une longueur de 32 caractères.
 */
$cfg['blowfish_secret'] = '3Q0PzfZ4DMUj7]3e4rGnEH-eE1XA/AO0'; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */


/* Type d'authentication */
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['port'] = '3306';
/* Utilisateur utiliser pour manipuler le stockage */
$cfg['Servers'][$i]['controluser'] = 'root';
$cfg['Servers'][$i]['controlpass'] = 'toor';
/* Parametre du server */
$cfg['Servers'][$i]['host'] = 'mysql-svc';

/**
 * Répertoires pour l'enregistrement/le chargement de fichiers à partir du serveur
 */
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';