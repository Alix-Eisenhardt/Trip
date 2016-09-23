<form action="?r=location/confirm" method="post">
  <h1>Creer une Location</h1>

  <p>
    <label for="name">Nom de la location:</label>
    <input type="text" id="name" name="loc_name">
  </p>

  <p>
    <label for="mail">Type de la location</label>
    <input type="text" id="type" name="loc_type">
  </p>

  <p>
    <label for="Description">Description de la location</label>
    <textarea id="descr" name="loc_descr"></textarea>
  </p>

  <p>
    <label for="nbChambres">Nombre de Chambres</label>
    <input type="number" id="nbroom" name="loc_nbroom">
  </p>  

  <p>
    <label for="nbCouchages">Nombre de Couchages</label>
    <input type="number" id="nbcouchages" name="loc_nbcouchages">
  </p>  

  <p>
    <label for="nbBathroom">Nombre de Salles de Bains</label>
    <input type="number" id="nbbathroom" name="loc_nbbathroom">
  </p>  

  <p>
    <label for="nbOccupants">Nombre d'occupants Maximum</label>
    <input type="number" id="nbOccupants" name="loc_nbOccupants">
  </p>

  <p>
    <label for="addr">Adresse :</label>
    <input type="text" id="addr" name="loc_addr">
  </p>

  <p>
    <label for="addr2">Complement d'adresse :</label>
    <input type="text" id="addr2" name="loc_addr2">
  </p>

  <p>
    <label for="CP">Code Postal</label>
    <input type="text" id="cp" name="loc_cp">
  </p>

  <p>
    <label for="city">Ville</label>
    <input type="text" id="addr" name="loc_addr">
  </p>

  <p>
    <label for="state">Etat</label>
    <input type="text" id="state" name="loc_state">
  </p>

  <p>
    <label for="country">Pays :</label>
    <select>
      <?php 
/*        foreach (Pays::findAll() as $v) {
          echo "<option value = \"$v\"> $v </option>";
        }*/
      ?>
    </select>
  </p>


  <div class="button">
    <button type="submit">Creer la location</button>
  </div>
</form>