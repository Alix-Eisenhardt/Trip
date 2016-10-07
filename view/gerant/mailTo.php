<?php
global $data;
echo "Envoyer un mail à : ".$data->grt_nom;
?>

<form action="index.php?r=gerant/mailTo" method="post">
	<input type="hidden" name="grtId" value="<?php echo $data->grt_id; ?>">
	<p>
		<label for="nom">Nom</label>
		<input type="text" id="nom" name="nom" required
			value="<?php if(isset($_SEESION['abo'])) echo $_SESSION['abo']->abo_nom; ?>">
	</p>
	<p>
		<label for="prenom">Prenom</label>
		<input type="text" id="prenom" name="prenom" required
			value="<?php if(isset($_SEESION['abo'])) echo $_SESSION['abo']->abo_prenom; ?>">
	</p>
	<p>
		<label for="mel">Adresse mail</label>
		<input type="text" id="mel" name="mel" required 
			value="<?php  if(isset($_SEESION['abo'])) echo $_SESSION['abo']->abo_mel; ?>">
	</p>
	<p>
		<label for="objet">Objet</label>
		<input type="objet" id="objet" name="objet" required>
	</p>
	<p>
		<label for="message">Message</label>
		<textarea id="message" name="message" required></textarea>
	</p>
	<p class="button">
		<button type="submit" name="envoyer" value="envoyer">Envoyer</button>
	</p>
</form>