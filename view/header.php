<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>Trip Advisor</title>
	<link rel="stylesheet" href="view/style.css" />
</head>
<body>
	<header>
		<h1>TripAdvisor</h1>
		<ul>
			<a href="."><li>Accueil</li></a>
			<?php
			if(isset($_SESSION['ouvert']))
				echo "<a href=\"./?r=abonne/modifierCompte\"><li>Mon compte</li></a>";
			else
				echo "<a href=\"./?r=abonne/inscription\"><li>Inscription</li></a>";
			?>
			<a href="./?r=location/createLocation"><li>Ajouter location</li></a>
		</ul>
</header>
<div id="main">
