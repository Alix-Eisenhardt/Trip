<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>Trip Advisor</title>
	<link rel="stylesheet" href="view/style.css" />
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.js"></script>
	<script type="text/javascript" src="view/easterEgg.js"></script>
</head>
<body>
	<header>
		<h1>TripAdvisor</h1>
		<ul>
			<a href="."><li>Accueil</li></a>
			<?php
				if(isset($_SESSION['abo'])) {
					echo "<a href=\"./?r=abonne/modifier\"><li>Mon compte</li></a>";
					echo "<a href=\"./?r=abonne/deconnexion\"><li>Deconnexion</li></a>";
				}
				elseif(isset($_SESSION['gerant'])){
					echo "<a href=\"./?r=location/createLocation\"><li>Ajouter location</li></a>";
					echo "<a href=\"./?r=gerant/mesLocations\"><li>Mes locations</li></a>";
					echo "<a href=\"./?r=gerant/deconnexion\"><li>Deconnexion</li></a>";
				}
				else {
					echo "<a href=\"./?r=abonne/inscription\"><li>Inscription</li></a>";
					echo "<a href=\"./?r=abonne/connecter\"><li>Connexion</li></a>"	;
				}
			?>			
		</ul>
</header>
<div id="main">
