<form action="?r=location/search" method="post"  onsubmit="return checkDates()">
	<p>
	<label for="ville">Ville : </label>
	<input type="text" id="ville" name="ville" required/>
	</p>
	<p>
	<label for="date_debut">Date début : </label>
	<input type="date" id="date_debut" name="date_debut"/>
	</p>
	<p>
	<label for="date_fin">Date fin : </label>
	<input type="date" id="date_fin" name="date_fin"/>
	</p>
	<p>Equipements optionnels :</p>
	<div id="equipement">
		<?php
		foreach (Equipement::findAll() as $k => $v) {
			$id = $v->equ_id;
		    echo('<span class="equ_child"><label for="check"> • '.$v->equ_libelle.' : </label>');
			echo('<input type="checkbox" id="check" name="check[]" value="'.$id.'"> </span>');
		}
		?>
	</div>
	<p>
	<button type="submit" id="button">Chercher</button>
	</p>
</form>
<script type="text/javascript" src='view/tools.js'></script>
