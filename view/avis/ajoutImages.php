Joindre une photo à votre avis
<?php
$av = new Avis($_GET['avi_id']);
echo "<br><h4>Titre de l'avis : ".$av->avi_titre."</h4>";
?>

<fieldset class="fdset_formimg">
<form action="#" method="post" enctype="multipart/form-data">
	<p>
		formats autorisés : .jpeg .jpg .gif ou .png<br>
		<input type="file" name="photo" />
	</p>
	<input type="submit" name="joindre" value="Joindre">
</form>
</fieldset>
<?php 
if(isset($erreur)) {
		echo "<span id='erreur'>".$erreur."</span>";
		unset($erreur);
	}
?>