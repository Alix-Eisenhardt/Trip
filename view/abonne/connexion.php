 <form action="index.php?r=abonne/connecter" method="post">
	<h1>Connexion</h1>
	<?php
		print_r($_SESSION['abo']);
	?>
	<p>
		<label for="login">Adresse mail</label>
		<input type="text" id="login" name="login" required>
	</p>
	<p>
		<label for="password">Mot de passe</label>
		<input type="password" id="password" name="password" required>
	</p>
	
	<p class="button">
		<button type="submit" name="connecter" value="connecter">Se connecter</button>
	</p>
</form>