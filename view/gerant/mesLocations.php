<?php
global $data;
if(!isset($data[1]) || $data[1] == null) {
	echo "Aucune location.";
} else {?>
	<h1>Mes locations</h1>
	<?php
	foreach ($data[1] as $key => $value) {
		echo $value->shortVersion();
	};
}
?>