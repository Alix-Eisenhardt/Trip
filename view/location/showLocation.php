<?php
global $data;
// Affichage de la location
echo $data[0];

// Affichage des avis
foreach ($data[1] as $key => $value) {
	echo $value;
}
?>
