 <form action="index.php?r=gerant/connecter" method="post">
	<h1>Connexion</h1>

	<p>
		<label for="login">Adresse mail</label>
		<input type="text" id="login" name="login" required 
			value="<?php if(isset($_POST['login'])) echo $_POST['login']; ?>">
	</p>
	
	<p class="button">
		<button type="submit" name="connecter" value="connecter">Se connecter</button>
	</p>
</form>