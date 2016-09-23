<form action="index.php?r=abonne/inscrire" method="post">
	<label for="nom">Nom : </label>
	<input type="text" id="nom" name="nom" size=35 value="<?php if (isset($_POST['nom'])) echo htmlentities(trim($_POST['nom'])); ?>"><br />
	<br>
	<label for="pseudo">Prénom : </label>
	<input type="text" id="prenom" name="prenom" size=35 value="<?php if (isset($_POST['prenom'])) echo htmlentities(trim($_POST['prenom'])); ?>"><br />
	<br>
	<label for="pseudo">Pseudo : </label>
	<input type="text" id="pseudo" name="pseudo" size=35 value="<?php if (isset($_POST['pseudo'])) echo htmlentities(trim($_POST['pseudo'])); ?>"><br />
	<br>
	<label for="email">e-mail : </label>
	<input type="email" id="email" name="email" size=35 value="<?php if (isset ($_POST['email'])) echo htmlentities(trim($_POST['email'])); ?>"><br />
	<br>
	<label for="pass">Mot de passe : </label>
	<input type="password" id="pass" name="pass" size=35 value="<?php if (isset($_POST['pass'])) echo htmlentities(trim($_POST['pass'])); ?>"><br />
	<br>
	<label for="pass_confirm">Confirmation du mot de passe : </label>
	<input type="password" id="pass_confirm" name="pass_confirm" size=35 value="<?php if (isset($_POST['pass_confirm'])) echo htmlentities(trim($_POST['pass_confirm'])); ?>"><br />
	
	<input type="submit" name="inscription" value="Inscription">
</form>