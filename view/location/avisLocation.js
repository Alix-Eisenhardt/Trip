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

	$(tri).insertBefore('#avis');
	$(langue).insertBefore('#avis');

	triSelect.click(function() {
		var avis = $(".avis");
		if(triSelect.val() == "Date (du + vieux au + récent)") {
			avis.sort(function(a, b) {
				return new Date($(a).find(".date").text()) - new Date($(b).find(".date").text());
			});
		} else if(triSelect.val() == "Date (du + récent au + vieux)") {
			avis.sort(function(a, b) {
				return new Date($(b).find(".date").text()) - new Date($(a).find(".date").text());
			});
		} else if(triSelect.val() == "Avis (du moins bon au meilleur)") {
			avis.sort(function(a, b) {
				return $(a).find(".note").text() - $(b).find(".note").text();
			});
		} else if(triSelect.val() == "Avis (du meilleur au moins bon)") {
			avis.sort(function(a, b) {
				return $(b).find(".note").text() - $(a).find(".note").text();
			});
		}
		$("#avis").html(avis);
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