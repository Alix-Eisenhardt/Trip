<?php
global $data;
// Affichage de la location
echo $data[0];

$photos = Photo::findAll();

echo "<script type=\"text/javascript\" src='view/location/showImages.js'></script>";

foreach ($photos as $photo) {
	if($photo->loc_id == $data[0]->loc_id) {
		echo "<div class='photo'>";
		echo "<img src='../upload/".$photo->pho_url."'></img>";
		echo "</div>";
	}
}

$path = "./?r=avis/creation&loc_id=".$data[0]->loc_id;
echo "<a class='button' href='$path'>Ecrire un Avis</a>";

$path = "./?r=location/dispo&loc_id=".$data[0]->loc_id;
echo "<a class='button' href='$path'>Voir les disponibilités</a>";

$path = "./?r=location/dispo&loc_id=".$data[0]->loc_id;
echo "<a class='button' href='$path'>Reserver</a>";



// Affichage des avis
if($data[1] != null) {
	echo "<script type=\"text/javascript\" src='view/location/avisLocation.js'></script>";
	echo "<div id='avis'>";
	foreach ($data[1] as $key => $value) {
		echo $value;
	}
	echo "</div>";
}
?>
