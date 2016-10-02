<h2>Creer une Location</h2>
<p>Les champs suivis d'une * sont obligatoires</p>
<script type="text/javascript" src="control.js"></script>

<form action="?r=location/confirm" method="post"  onsubmit="return verifForm(this)">


  <p>
    <label for="name">Nom de la location *</label>
    <input type="text" id="name" name="loc_titre"
    value="<?php if (isset ($_POST['loc_titre'])) echo htmlentities(trim($_POST['loc_titre'])); ?>"
    onblur="verifChampText(this)">
  </p>

  <p>
    <label for="type">Type de la location *</label>
    <input type="text" id="type" name="loc_type"
    value ="<?php if (isset ($_POST['loc_type'])) echo htmlentities(trim($_POST['loc_type'])); ?>"
    onblur="verifChampText(this)">
  </p>

  <p>
    <label for="Description">Description de la location *</label>
    <textarea id="descr" name="loc_description" onblur="verifChampLongText(this)"></textarea>
  </p>

  <p>
    <label for="nbChambres">Nombre de Chambres *</label>
    <input type="number" id="nbroom" name="loc_nbchambres"
    value="<?php if (isset ($_POST['loc_nbchambres'])) echo htmlentities(trim($_POST['loc_nbchambres'])); ?>"
    onblur="verifChampNum(this)">
  </p>

  <p>
    <label for="nbCouchages">Nombre de Couchages *</label>
    <input type="number" id="nbcouchages" name="loc_nbcouchages"
    value="<?php if (isset ($_POST['loc_nbcouchages'])) echo htmlentities(trim($_POST['loc_nbcouchages'])); ?>"
    onblur="verifChampNum(this)">
  </p>

  <p>
    <label for="nbBathroom">Nombre de Salles de Bains *</label>
    <input type="number" id="nbbathroom" name="loc_nbsallesbain"
    value="<?php if (isset ($_POST['loc_nbsallesbain'])) echo htmlentities(trim($_POST['loc_nbsallesbain'])); ?>"
    onblur="verifChampNum(this)">
  </p>

  <p>
    <label for="nbOccupants">Nombre d'occupants Maximum *</label>
    <input type="number" id="nbOccupants" name="loc_nboccupants"
    value = "<?php if (isset ($_POST['loc_nboccupants'])) echo htmlentities(trim($_POST['loc_nboccupants'])); ?>"
    onblur="verifChampNum(this)">
  </p>

  <p>
    <label for="addr">Adresse *</label>
    <input type="text" id="addr" name="loc_adrligne1"
    value="<?php if (isset ($_POST['loc_adrligne1'])) echo htmlentities(trim($_POST['loc_adrligne1'])); ?>"
    onblur="verifChampText(this)">
  </p>

  <p>
    <label for="addr2">Complement d'adresse :</label>
    <input type="text" id="addr2" name="loc_adrligne2"
    value ="<?php if (isset ($_POST['loc_adrligne2'])) echo htmlentities(trim($_POST['loc_adrligne2'])); ?>">
  </p>

  <p>
    <label for="CP">Code Postal *</label>
    <input type="text" id="cp" name="loc_cp"
    value="<?php if (isset ($_POST['loc_cp'])) echo htmlentities(trim($_POST['loc_cp'])); ?>"
    onblur="verifChampText(this)">
  </p>

  <p>
    <label for="city">Ville *</label>
    <input type="text" id="addr" name="loc_ville"
    value ="<?php if (isset ($_POST['loc_ville'])) echo htmlentities(trim($_POST['loc_ville'])); ?>"
    onblur="verifChampText(this)"/>
  </p>

  <p>
    <label for="state">Etat</label>
    <input type="text" id="state" name="loc_etat"
    value="<?php if (isset ($_POST['loc_etat'])) echo htmlentities(trim($_POST['loc_etat'])); ?>">
  </p>
  <p>
    <label for="country">Pays :</label>
    <select id="pays" name="pay_id">
      <?php
       foreach (Pays::findAll() as $v) {
          echo "<option value = \"$v\"> $v </option>";
        }
      ?>
    </select>
  </p>


  <div class="button">
    <button type="submit">Creer la location</button>
  </div>
</form>
