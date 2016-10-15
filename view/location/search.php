<?php
global $data;
if(!isset($data[1]) || $data[1] == null) {
	echo "Aucune location trouvée pour ces critères de recherche.";
} else {
	echo "<script type=\"text/javascript\" src='view/location/sortSearchLocation.js'></script>";
	?>
	<h1>Locations près de <?php echo $data[0] ?></h1>
	<div id='locations'>
	<?php
	if(isset($_POST["date_debut"])) {
		foreach ($data[1] as $key => $value) {
			echo $value->shortVersion($_POST["date_debut"],$_POST["date_fin"]);
		};
	} else {
		foreach ($data[1] as $key => $value) {
			echo $value->shortVersion();
		};
	}
	echo "</div>";
}
?>
