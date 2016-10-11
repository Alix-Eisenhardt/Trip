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
