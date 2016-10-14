Joindre une photo à votre avis
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