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

	triSelect.click(function() {
		if(triSelect.val() == "Date (du + vieux au + récent)") {
			$.makeArray($(".date"));
		}
		console.log(triSelect.val());
	});

	langueSelect.click(function() {
		if(langueSelect.val() === "Les deux") {
			$(".avis").each(function() {
				$(this).show();
			});
		} else {
			$(".avis").each(function() {
				if($(this).hasClass(langueSelect.val()))
					$(this).show();
				else $(this).hide();
			});
		}
	});
});