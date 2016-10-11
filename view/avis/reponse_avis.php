<?php
global $data;
echo $data;
?>

<form action=<?php echo "./?r=avis/reponse&avi_id=".$data->avi_id; ?> method="post">
	<p>
		<label for="reponse">Réponse : </label>
		<textarea required type="text" id="reponse" name="reponse" rows="8" cols="70"><?php 
			if (isset($_POST['reponse'])) echo htmlentities(trim($_POST['reponse']));
		?></textarea>
	</p>
	<input type="submit" name="envoyer" value="Envoyer">
</form>