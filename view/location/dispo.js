$(document).ready(function(){

	$("[id^=date_]").focus(function(){
       $(this).blur();
	});

	var d = new Date();
	var y = d.getFullYear();
	var m = d.getMonth()+1;
	var dd = d.getDate();
	console.log(y+"-"+m+"-"+dd);
	for(var i=0;i<day.length;i++){
		(function(i){
		var date = day[i].split("-");
		if(date[1] == m && date[2]<dd )
			console.log("x");
		else{
			$('#'+day[i]).css({"color":"green", "background-color":"#00fa00", "cursor":"pointer"});

			$("#"+day[i]).click(function(){

				if($('#date_debut_resa').val() == ''){
					console.log(day[i]);
					$('#date_debut_resa').val(date[2]+"/"+date[1]+"/"+date[0]);
				}else{
					var dateDebut = $('#date_debut_resa').val().split("/");
					console.log(dd);
					if(dateDebut[1]>= date[1] && dateDebut[0] >= date[2] && dateDebut[2] >= date[0])
						$('#date_debut_resa').val(date[2]+"/"+date[1]+"/"+date[0]);
					else{
						console.log("fin");
						$('#date_fin_resa').val(date[2]+"/"+date[1]+"/"+date[0]);
					}
				}
			});
		}
	})(i);
	}

	$('#reset').click(function(){
		$("[id^=date_]").val("");
	});

	function checkTxt(){
		return false;
	}
});

function checkTxt(){
	var dateDebut = document.getElementById('date_debut_resa');
	var dateFin = document.getElementById('date_fin_resa');
	if(!dateDebut.value || !dateFin.value){
		window.alert("Remplissez les champs svp");
		return false;
	}else
		return true;

}