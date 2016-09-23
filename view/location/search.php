<?php
global $data;
if($data == null) {
	echo "Aucune location trouvée pour ces critères de recherche.";
} else {?>
	<h1>Locations près de <?php echo $data[0]->loc_ville ?></h1>
	<?php
	foreach ($data as $key => $value) {
		echo $value;
	};
}
?>