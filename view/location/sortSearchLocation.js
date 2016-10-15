$(document).ready(function() {
	var tri = $("<p/>");
	var triSelect = $("<select/>");
	tri.append("Trier par : ");
	tri.append(triSelect);
	triSelect.append("<option>Tout afficher</option>")
			 .append("<option>Prix croissant</option>")
			 .append("<option>Prix décroissant</option>");

	if($(".prix").length)
		tri.insertBefore("#locations");

	triSelect.click(function() {
		var loc = $(".location");
		if(triSelect.val() == "Tout afficher") {
			loc.each(function() {
				$(this).show();
			});
		} else {
			loc.each(function() {
				if(!$(this).find(".prix").length)
					$(this).hide();
			});
			if(triSelect.val() == "Prix croissant") {
				loc.sort(function(a, b) {
					return $(a).find(".prix").text() - $(b).find(".prix").text();
				});
			} else if(triSelect.val() == "Prix décroissant") {
				loc.sort(function(a, b) {
					return $(b).find(".prix").text() - $(a).find(".prix").text();
				});
			}
			$("#locaton").html(loc);
		}
	});
});
