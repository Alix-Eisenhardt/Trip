<?php
global $data;
// Affichage de la location
echo $data[0];

$path = "./?r=avis/creation&loc_id=".$data[0]->loc_id;
echo "<a class='button' href='$path'>Ecrire un Avis</a>";

// Affichage des avis
foreach ($data[1] as $key => $value) {
	echo $value;
}
?>
