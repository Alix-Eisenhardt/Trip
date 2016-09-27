 <form action="index.php?r=abonne/modifier" method="post">
	<h1>Mon compte</h1>
	<p>
		<label for="abo_adrligne1">Adresse</label>
		<input type="text" id="abo_adrligne1" name="abo_adrligne1" required 
				value="<?php echo $_SESSION['abo']->abo_adrligne1; ?>">

	</p>
	<p>
		<label for="abo_adrligne2">Complement</label>
		<input type="text" id="abo_adrligne2" name="abo_adrligne2" 
				value="<?php echo $_SESSION['abo']->abo_adrligne2; ?>">
	</p>
	<p>
		<label for="abo_cp">Code postal</label>
		<input type="text" id="abo_cp" name="abo_cp" required 
				value="<?php echo $_SESSION['abo']->abo_cp; ?>">
	</p>
	<p>
		<label for="abo_ville">Ville</label>
		<input type="text" id="abo_ville" name="abo_ville" required 
				value="<?php echo $_SESSION['abo']->abo_ville; ?>">
	<p>
		<label for="abo_etat">Etat</label>
		<input type="text" id="abo_etat" name="abo_etat" 
				value="<?php echo $_SESSION['abo']->abo_etat; ?>">
	</p>
	<p>
		<label for="abo_pays">Pays</label>
		<select id="abo_pays" name="pay_id" required>
			<?php
       			foreach (Pays::findAll() as $k=>$v) {
       				$id = $v->pay_id;
       				if ($_SESSION['abo']->pay_obj->pay_id == $id)
       					echo "<option value=\"$id\" selected> $v </option>";
          			else
          				echo "<option value=\"$id\"> $v </option>";
        		}
      		?>
		</select>
	</p>
	<p>
		<label for="abo_indicatif">Indicatif</label>
		<input type="text" id="abo_indicatif" name="abo_indicatif" required 
				value="<?php echo $_SESSION['abo']->abo_indicatif; ?>">
	</p>
	<p>
		<label for="abo_tel">Telephone</label>
		<input type="text" id="abo_tel" name="abo_tel" required 
				value="<?php echo $_SESSION['abo']->abo_tel; ?>">
	</p>
	<p class="button">
		<button type="submit" name="modifier" value="modifier">Valider</button>
	</p>
</form>