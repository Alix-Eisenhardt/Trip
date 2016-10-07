<form action="index.php?r=abonne/connecter" method="post">
	<h1>Connexion</h1>

	<p>
		<a href="./?r=gerant/connecter">Se connecter en tant que gérant</a>
	</p>
	<p>
		<label for="login">Adresse mail</label>
		<input type="text" id="login" name="login" required 
			value="<?php if(isset($_POST['login'])) echo $_POST['login']; ?>">
	</p>
	<p>
		<label for="password">Mot de passe</label>
		<input type="password" id="password" name="password" required>
	</p>
	
	<p class="button">
		<button type="submit" name="connecter" value="connecter">Se connecter</button>
	</p>
</form>