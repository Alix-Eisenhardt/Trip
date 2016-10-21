var today = new Date();
today.setHours(0,0,0,0);
var msg = $("<p/>");
msg.attr("id", "erreur");

function checkDates() {
	var dateDebut = document.getElementById('date_debut');
	var dateFin = document.getElementById('date_fin');
	var dDebut = new Date(dateDebut.value);
	var dFin = new Date(dateFin.value);
	if(!dateDebut.value && dateFin.value ||
		dateDebut.value && !dateFin.value ||
		dDebut < today ||
		dFin < today ||
		dFin < dDebut
	) {
		if(!dateDebut.value && dateFin.value) {
			console.log("test dd vide");
			msg.text("Il faut rentrer une date de début");
			$("#dateDebut").append(msg);
		} else if(dateDebut.value && !dateFin.value) {
			console.log("test df vide");
			msg.text("Il faut rentrer une date de fin");
			$("#dateFin").append(msg);
		} else if(dDebut < today) {
			console.log("test");
			msg.text("La date de début doit être après aujourd'hui");
			$("#dateDebut").append(msg);
		} else if(dFin < today) {
			console.log("test");
			msg.text("La date de fin doit être après aujourd'hui");
			$("#dateFin").append(msg);
		} else {
			console.log("test");
			msg.text("La date de fin doit être après celle de début");
			$("#dateFin").append(msg);
		}
		return false;
	} else {
		return true;
	}
}
