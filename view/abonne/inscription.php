* Champs obligatoires
<form action="index.php?r=abonne/inscrire" method="post">
	<p>
	<label for="nom">Nom* : </label>
	<input type="text" id="nom" name="nom" size=35 value="<?php if (isset($_POST['nom'])) echo htmlentities(trim($_POST['nom'])); ?>">
	</p>
	<p>
	<label for="pseudo">Prénom* : </label>
	<input type="text" id="prenom" name="prenom" size=35 value="<?php if (isset($_POST['prenom'])) echo htmlentities(trim($_POST['prenom'])); ?>">
	</p>
	<p>
	<label for="pseudo">Pseudo* : </label>
	<input type="text" id="pseudo" name="pseudo" size=35 value="<?php if (isset($_POST['pseudo'])) echo htmlentities(trim($_POST['pseudo'])); ?>">
	</p>
	<p>
	<label for="email">e-mail* : </label>
	<input type="email" id="email" name="email" size=35 value="<?php if (isset ($_POST['email'])) echo htmlentities(trim($_POST['email'])); ?>">
	</p>
	<p>
	<label for="pass">Mot de passe* : </label>
	<input type="password" id="pass" name="pass" size=35 value="<?php if (isset($_POST['pass'])) echo htmlentities(trim($_POST['pass'])); ?>">
	</p>
	<p>
	<label for="pass_confirm">Confirmation du mot de passe* : </label>
	<input type="password" id="pass_confirm" name="pass_confirm" size=35 value="<?php if (isset($_POST['pass_confirm'])) echo htmlentities(trim($_POST['pass_confirm'])); ?>">
	</p>
	<p>
	<label for="adr1">Adresse* : </label>
	<input type="text" id="adr1" name="adr1" size=35 value="<?php if (isset($_POST['adr1'])) echo htmlentities(trim($_POST['adr1'])); ?>">
	</p>
	<p>
	<label for="adr2">Complément d'adresse : </label>
	<input type="text" id="adr2" name="adr2" size=35 value="<?php if (isset($_POST['adr2'])) echo htmlentities(trim($_POST['adr2'])); ?>">
	</p>
	<p>
	<label for="cp">Code postal* : </label>
	<input type="text" id="cp" name="cp" size=35 value="<?php if (isset($_POST['pc'])) echo htmlentities(trim($_POST['pc'])); ?>">
	</p>
	<p>
	<label for="ville">Ville* : </label>
	<input type="text" id="ville" name="ville" size=35 value="<?php if (isset($_POST['ville'])) echo htmlentities(trim($_POST['ville'])); ?>">
	</p>
	<p>
	<label for="etat">Etat : </label>
	<input type="text" id="etat" name="etat" size=35 value="<?php if (isset($_POST['etat'])) echo htmlentities(trim($_POST['etat'])); ?>">
	</p>
	<p>
    <label for="country">Pays* :</label>
    <select id="pays" name="pay_id">
      <?php
       foreach (Pays::findAll() as $v) {
          echo "<option value = \"$v\"> $v </option>";
        }
      ?>
    </select>
	</p>
	<p>
	<label for="indicatif">Indicatif* : </label>
	<input type="text" id="indicatif" name="indicatif" size=35 value="<?php if (isset($_POST['indicatif'])) echo htmlentities(trim($_POST['indicatif'])); ?>">
	</p>
	<p>
	<label for="tel">Numéro de téléphone* : </label>
	<input type="text" id="tel" name="tel" size=35 value="<?php if (isset($_POST['tel'])) echo htmlentities(trim($_POST['tel'])); ?>">
	</p>
	<p>
	<label for="aeroport">Aéroport : </label>
	<input type="text" id="aeroport" name="aeroport" size=35 value="<?php if (isset($_POST['aeroport'])) echo htmlentities(trim($_POST['aeroport'])); ?>">
	</p>
	<input type="submit" name="inscription" value="Inscription">
</form>