* Champs obligatoires
<form action="#" method="post">
	<p>
	    <label for="vil">Type de visite* :</label>
	    <select required id="vil" name="vil">
	      <?php
	       foreach (TypeVisiteLocation::findAll() as $k => $v) {
	       		$id = $v->vil_id;
	          echo "<option value = \"$id\"> $v </option>";
	        }
	      ?>
	    </select>
	</p>
	<p>
	    <label for="per">Période de votre visite* :</label>
	    <select required id="per" name="per">
	      <?php
	       foreach (PeriodeVisite::findAll() as $k => $v) {
	       		$id = $v->per_id;
	          echo "<option value = \"$id\"> $v </option>";
	        }
	      ?>
	    </select>
	</p>
	<p>
	    <label for="lng">Langue de l'avis* :</label>
	    <select required id="lng" name="lng">
	      <?php
	       foreach (Langue::findAll() as $k => $v) {
	       		$id = $v->lng_id;
	          echo "<option value = \"$id\"> $v </option>";
	        }
	      ?>
	    </select>
	</p>
	<p>
		<label for="nom_occ">Nom de l'occupant* : </label>
		<input required type="text" id="nom_occ" name="nom_occ" size=25 value="<?php if (isset($_POST['nom_occ'])) echo htmlentities(trim($_POST['nom_occ'])); ?>">
	</p>	
	<br><br><br><br>
	<p>
		<label for="titre">Titre* : </label>
		<input required type="text" id="titre" name="titre" size=55 value="<?php if (isset($_POST['titre'])) echo htmlentities(trim($_POST['titre'])); ?>">
	</p>
	<p>
		<label for="detail">Detail* : </label>
		<textarea 
			required type="text" id="detail" name="detail" rows="8" cols="70">
			<?php if (isset($_POST['detail'])) echo htmlentities(trim($_POST['detail'])); ?>
		</textarea>
	</p>
	<br><br>
	<input type="checkbox" id="butt_q">
	<label for="butt_q">Questions facultatives
		<div id="questions_fac">
		<?php
		foreach (Question::findAll() as $k => $v) {
		    		$id = $v->qul_id;
		    		$name = "quest".$id;
		    		echo('<p><label for="$name"> '.$v.'* : </label>');
					echo('<input required type="text" id="'.$name.'" name="'.$name.'" size=55></p>');
					if (isset($_POST['$name'])) echo htmlentities(trim($_POST['$name']));
		    }
		?>
		</div>
	</label>
	<br><br>
	<p>
		Note Globale* : 
		<label for="note_glob_1">1</label>
		<input type="radio" id="note_glob_1" name="note_glob" value="1"> 
		<label for="note_glob_2">2</label>
  		<input type="radio" id="note_glob_2" name="note_glob" value="2"> 
		<label for="note_glob_3">3</label>
  		<input type="radio" id="note_glob_3" name="note_glob" value="3"> 
		<label for="note_glob_4">4</label>
  		<input type="radio" id="note_glob_4" name="note_glob" value="4"> 
		<label for="note_glob_5">5</label>
  		<input type="radio" id="note_glob_5" name="note_glob" value="5"> 
	</p>
	<p>
		<label for="recom">Recomanderiez vous ce lieu à un ami ?</label>
		<input type="checkbox" id="recom" name="recom" value="true">
	</p>
	<input type="submit" name="envoyer" value="Envoyer">
</form>
