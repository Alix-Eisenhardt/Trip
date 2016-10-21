$(document).ready(function(){

	$("[id^=date_]").focus(function(){
       $(this).blur();
	});
	//On recupère la date du jour et on la split
	var d = new Date();
	var y = d.getFullYear();
	var m = d.getMonth()+1;
	var dd = d.getDate();
	console.log(y+"-"+m+"-"+dd);
	//Pour chaque id contenant la date, on affecte la couleur verte et une fonction permettant d'insérer la date dans un input box 
	//Traitement un peu particulier pour savoir s'il faut inserer la valeur dans le textbox de début ou de fin. 
	for(var i=0;i<day.length;i++){
		(function(i){
		var date = day[i].split("-");
		if(date[1] == m && date[2]<dd )
			console.log("x");
		else{
			$('#'+day[i]).css({"color":"green", "background-color":"#00fa00", "cursor":"pointer"});

			$("#"+day[i]).click(function(){
				//Si la date de début est vide, on la remplit
				if($('#date_debut_resa').val() == ''){
					$('#date_debut_resa').val(date[2]+"/"+date[1]+"/"+date[0]);
				}else{
					var dateDebut = $('#date_debut_resa').val().split("/");
					//Si la date est plus petite que la date de début, on remplace la date de début
					if(dateDebut[1]>= date[1] && dateDebut[0] >= date[2] && dateDebut[2] >= date[0])
						$('#date_debut_resa').val(date[2]+"/"+date[1]+"/"+date[0]);
					else{
						//on remplit la date de fin sinon.
						$('#date_fin_resa').val(date[2]+"/"+date[1]+"/"+date[0]);
					}
				}
			});
		}
	})(i);
	}
	//On affecte au bouton reset une fonction vidant les textbox des dates
	$('#reset').click(function(){
		$("[id^=date_]").val("");
	});
});
//Fonction de vérification du formulaire
function checkTxt(){
	var dateDebut = document.getElementById('date_debut_resa');
	var dateFin = document.getElementById('date_fin_resa');
	if(!dateDebut.value || !dateFin.value){
		window.alert("Remplissez les champs svp");
		return false;
	}else
		return true;

}