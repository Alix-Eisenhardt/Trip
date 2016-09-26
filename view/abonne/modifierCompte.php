 <form action="index.php?r=abonne/modifier" method="post">
	<h1>Mon compte</h1>

	<p>
		<label for="abo_adresse1">Adresse</label>
		<input type="text" id="abo_adrligne1" name="abo_adrligne1">
	</p>
	<p>
		<label for="abo_adresse2">Complement</label>
		<input type="text" id="abo_adrligne2" name="abo_adrligne2">
	</p>
	<p>
		<label for="abo_cp">Code postal</label>
		<input type="text" id="abo_cp" name="abo_cp">
	</p>
	<p>
		<label for="abo_ville">Ville</label>
		<input type="text" id="abo_ville" name="abo_ville">
	<p>
		<label for="abo_etat">Etat</label>
		<input type="text" id="abo_etat" name="abo_etat">
	</p>
	<p>
		<label for="abo_pays">Pays</label>
		<select id="abo_pays" name="pay_id">
			<?php
       			foreach (Pays::findAll() as $v) {
          			echo "<option value = \"$v\"> $v </option>";
        		}
      		?>
		</select>
	</p>
	<p>
		<label for="abo_indicatif">Indicatif</label>
		<input type="text" id="abo_indicatif" name="abo_indicatif">
	</p>
	<p>
		<label for="abo_telephone">Telephone</label>
		<input type="text" id="abo_telephone" name="abo_tel">

	<p class="button">
		<button type="submit" name="modifier">Valider</button>
	</p>
</form>