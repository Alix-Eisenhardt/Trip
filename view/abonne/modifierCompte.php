 <form action="index.php?r=abonne/modifier" method="post">
	<h1>Mon compte</h1>

	<p>
		<label for="abo_adrligne1">Adresse</label>
		<input type="text" id="abo_adrligne1" name="abo_adrligne1" required>
	</p>
	<p>
		<label for="abo_adrligne2">Complement</label>
		<input type="text" id="abo_adrligne2" name="abo_adrligne2">
	</p>
	<p>
		<label for="abo_cp">Code postal</label>
		<input type="text" id="abo_cp" name="abo_cp" required>
	</p>
	<p>
		<label for="abo_ville">Ville</label>
		<input type="text" id="abo_ville" name="abo_ville" required>
	<p>
		<label for="abo_etat">Etat</label>
		<input type="text" id="abo_etat" name="abo_etat">
	</p>
	<p>
		<label for="abo_pays">Pays</label>
		<select id="abo_pays" name="pay_id" required>
			<?php
       			foreach (Pays::findAll() as $k=>$v) {
       				$id = $v->pay_id;
       				if ($->pay_id == $id)
       					echo "<option value=\"$id\" selected> $v </option>"
       				else
          				echo "<option value=\"$id\"> $v </option>";
        		}
      		?>
		</select>
	</p>
	<p>
		<label for="abo_indicatif">Indicatif</label>
		<input type="text" id="abo_indicatif" name="abo_indicatif" required>
	</p>
	<p>
		<label for="abo_tel">Telephone</label>
		<input type="text" id="abo_tel" name="abo_tel" required>
	</p>
	<p class="button">
		<button type="submit" name="modifier" value="modifier">Valider</button>
	</p>
</form>