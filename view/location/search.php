<?php
global $data;
if($data[1] == null) {
	echo "Aucune location trouvée pour ces critères de recherche.";
} else {?>
	<h1>Locations près de <?php echo $data[0] ?></h1>
	<?php
	foreach ($data[1] as $key => $value) {
		echo $value->shortVersion();
	};
}
?>
