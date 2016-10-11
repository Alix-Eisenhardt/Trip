$(document).ready(function() {
	var tri = $("<p/>");
	var triSelect = $("<select/>");
	tri.append("Trier par : ");
	tri.append(triSelect);
	triSelect.append("<option>Prix croissant</option>")
			 .append("<option>Prix décroissant</option>");
	console.log("test");

	tri.insertBefore("#locations");
});