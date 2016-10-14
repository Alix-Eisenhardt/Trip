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
<script type="text/javascript">
	var today = new Date();
	today.setHours(0,0,0,0);

	function checkDates() {
		var dateDebut = document.getElementById('date_debut');
		var dateFin = document.getElementById('date_fin');
		var dDebut = new Date(dateDebut.value);
		var dFin = new Date(dateFin.value);
		if(!dateDebut.value && dateFin.value ||
			dateDebut.value && !dateFin.value ||
			dDebut < today || dFin < today || dFin < dDebut) {
			return false;
		} else {
			return true;
		}
	}

</script>
