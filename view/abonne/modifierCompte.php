 <form action="?r" method="post">
	<h1>Mon compte</h1>

	<p>
		<label for="adresse1">Adresse</label>
		<input type="text" id="adrligne1" name="abo_adrligne1" 
			value="<?php if (isset($_POST['abo_adrligne1'])) echo htmlentities(trim($_POST['abo_adrligne1'])); ?>">
	</p>
	<p>
		<label for="adresse2">Complement</label>
		<input type="text" id="adrligne2" name="abo_adrligne2" 
			value="<?php if (isset($_POST['abo_adrligne2'])) echo htmlentities(trim($_POST['abo_adrligne2'])); ?>">
	</p>
	<p>
		<label for="cp">Code postal</label>
		<input type="text" id="cp" name="abo_cp" 
			value="<?php if (isset($_POST['abo_cp'])) echo htmlentities(trim($_POST['abo_cp'])); ?>">
	</p>
	<p>
		<label for="ville">Ville</label>
		<input type="text" id="ville" name="abo_ville" 
			value="<?php if (isset($_POST['abo_ville'])) echo htmlentities(trim($_POST['abo_ville'])); ?>">
	</p>
	<p>
		<label for="etat">Etat</label>
		<input type="text" id="etat" name="abo_etat" 
			value="<?php if (isset($_POST['abo_etat'])) echo htmlentities(trim($_POST['abo_etat'])); ?>">
	</p>
	<p>
		<label for="pays">Pays</label>
		<select id="pays" name="pay_id">
			
		</select>
	</p>
	<p>
		<label for="indicatif">Indicatif</label>
		<input type="text" id="indicatif" name="abo_indicatif" 
			value="<?php if (isset($_POST['abo_indicatif'])) echo htmlentities(trim($_POST['abo_indicatif'])); ?>">
	</p>
	<p>
		<label for="telephone">Telephone</label>
		<input type="text" id="telephone" name="abo_tel"
			value="<?php if (isset($_POST['abo_tel'])) echo htmlentities(trim($_POST['abo_tel'])); ?>">
	</p>

	<p class="button">
		<button type="submit">Valider</button>
	</p>
</form>