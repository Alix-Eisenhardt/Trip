<?php
//Le session_start() doit être situé après le chargement du modèle. -> autoload dans config.php
// Sinon les objets placés dans les variables de session ne sont pas générés depuis le modèle.
include_once "config.php";
session_start();

include_once "db.php";
include_once "tools.php";
include_once "controller/route.php";
