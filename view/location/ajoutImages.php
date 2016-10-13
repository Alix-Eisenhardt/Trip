Formulaire d'ajout d'une photo :
<?php
	$loc = new Location($_GET['loc_id']);
	echo "<br><br>Pour la location : ".$loc->loc_titre;
?>
<fieldset class="fdset_formimg">
<form action="#" method="post" enctype="multipart/form-data">
	<p>
		formats autorisés : .jpeg .jpg .gif ou .png<br>
		<input type="file" name="photo" />
	</p>
	<input type="submit" name="ajouter" value="Ajouter">
</form>
</fieldset>
<?php 
if(isset($erreur)) {
		echo "<span id='erreur'>".$erreur."</span>";
		unset($erreur);
	}
?>

