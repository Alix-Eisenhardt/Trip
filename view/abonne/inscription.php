<form action="index.php?r=abonne/inscrire" method="post">
	<p>
	<label for="nom">Nom : </label>
	<input type="text" id="nom" name="nom" size=35 value="<?php if (isset($_POST['nom'])) echo htmlentities(trim($_POST['nom'])); ?>">
	</p>
	<p>
	<label for="pseudo">Prénom : </label>
	<input type="text" id="prenom" name="prenom" size=35 value="<?php if (isset($_POST['prenom'])) echo htmlentities(trim($_POST['prenom'])); ?>">
	</p>
	<p>
	<label for="pseudo">Pseudo : </label>
	<input type="text" id="pseudo" name="pseudo" size=35 value="<?php if (isset($_POST['pseudo'])) echo htmlentities(trim($_POST['pseudo'])); ?>">
	</p>
	<p>
	<label for="email">e-mail : </label>
	<input type="email" id="email" name="email" size=35 value="<?php if (isset ($_POST['email'])) echo htmlentities(trim($_POST['email'])); ?>">
	</p>
	<p>
	<label for="pass">Mot de passe : </label>
	<input type="password" id="pass" name="pass" size=35 value="<?php if (isset($_POST['pass'])) echo htmlentities(trim($_POST['pass'])); ?>">
	</p>
	<p>
	<label for="pass_confirm">Confirmation du mot de passe : </label>
	<input type="password" id="pass_confirm" name="pass_confirm" size=35 value="<?php if (isset($_POST['pass_confirm'])) echo htmlentities(trim($_POST['pass_confirm'])); ?>">
	</p>
	<p>
	<label for="adr1">Adresse : </label>
	<input type="text" id="adr1" name="adr1" size=35 value="<?php if (isset($_POST['adr1'])) echo htmlentities(trim($_POST['adr1'])); ?>">
	</p>
	<p>
	<label for="adr2">Complément d'adresse : </label>
	<input type="text" id="adr2" name="adr2" size=35 value="<?php if (isset($_POST['adr2'])) echo htmlentities(trim($_POST['adr2'])); ?>">
	</p>
	<p>
	<label for="cp">Code postal : </label>
	<input type="text" id="cp" name="cp" size=35 value="<?php if (isset($_POST['pc'])) echo htmlentities(trim($_POST['pc'])); ?>">
	</p>
	<p>
	<label for="cp">Code postal : </label>
	<input type="text" id="cp" name="cp" size=35 value="<?php if (isset($_POST['pc'])) echo htmlentities(trim($_POST['pc'])); ?>">
	</p>
	<p>
	<label for="cp">Code postal : </label>
	<input type="text" id="cp" name="cp" size=35 value="<?php if (isset($_POST['pc'])) echo htmlentities(trim($_POST['pc'])); ?>">
	</p>



	<input type="submit" name="inscription" value="Inscription">
</form>


/*ABO_ID               SERIAL               not null,
   ABO_PSEUDO           VARCHAR(20)          not null,
   ABO_MOTPASSE         VARCHAR(128)         not null,
   ABO_MEL              VARCHAR(80)          not null,
   ABO_NOM              VARCHAR(50)          not null,
   ABO_PRENOM           VARCHAR(50)          not null,
   ABO_ADRLIGNE1        VARCHAR(100)         not null,
   ABO_ADRLIGNE2        VARCHAR(100)         null,
   ABO_CP               VARCHAR(10)          not null,
   ABO_VILLE            VARCHAR(50)          not null,
   ABO_ETAT             VARCHAR(50)          null,
   PAY_ID               INT4                 not null,
   ABO_LATITUDE         FLOAT8               not null,
   ABO_LONGITUDE        FLOAT8               not null,
   ABO_INDICATIF        NUMERIC(4)           not null,
   ABO_TEL              VARCHAR(15)          not null,
   ABO_AEROPORT         VARCHAR(50)          null,*/