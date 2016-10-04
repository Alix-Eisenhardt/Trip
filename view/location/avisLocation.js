$(document).ready(function() {
	var tri = $("<p/>");
	var triSelect = $("<select/>");
	tri.append("Trier par : ");
	tri.append(triSelect);
	triSelect.append("<option>Date (du + vieux au + récent)</option>")
			 .append("<option>Date (du + récent au + vieux)</option>")
			 .append("<option>Avis (du moins bon au meilleur)</option>")
			 .append("<option>Avis (du meilleur au moins bon)</option>");

	var langue = $("<p/>");
	var langueSelect = $("<select/>");
	langue.append("Langue : ");
	langue.append(langueSelect);
	langueSelect.append("<option>Les deux</option>")
				.append("<option>Français</option>")
				.append("<option>English</option>");

	$('#avis').prepend(tri);
	$('#avis').prepend(langue);

	tri.click(function() {
		console.log(tri.val());
	});
	langue.click(function() {
		console.log(langue.val());
	});
});