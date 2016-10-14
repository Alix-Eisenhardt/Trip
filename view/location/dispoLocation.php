
<h2>Disponibilités</h2>

<?php
 global $data;

 echo "<script>";
 echo "var day = [";
 foreach ($data as $key => $value) {
 	if($value==1)
 		echo "'$key',";
 }
 echo "];";
 echo "</script>";
 echo "<script type='text/javascript' src='view/location/dispo.js'></script>";

$nb_month =6;
$actual_month = date('m') -1;
$month_array = array("Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Aout","Septembre","Octobre","Novembre","Decembre");
$actual_year = date('Y');
echo "<div class='dispo'>";
for($x=0;$x<$nb_month;$x++){
	$drawn_month = ($actual_month+$x)%12;
	if($drawn_month==0)
		$actual_year++; 
	echo "<div class='month'>".$month_array[$drawn_month]." ".$actual_year;
	echo draw_calendar($drawn_month+1,$actual_year);
	echo "</div>";
}
echo "</div>";

?>
<div>
	<form action="?r=location/reserver?=loc_id" method="post" onsubmit= "return checkTxt()">
	<p>Cliquez sur une date dans le calendrier </p>
	<p>
	<label for="date_debut_resa">Date début : </label>
	<input id="date_debut_resa" name="date_debut_resa" readonly/>
	</p>
	<label for="date_fin_resa">Date fin : </label>
	<input  id="date_fin_resa" name="date_fin_resa" readonly/>
	<p>
		<a class = 'button' id='reset'>Reset</a>
	</p>
	<p>
	<button type="submit" id="button">Reserver</button>
	</p>
	</form>
</div>
<?php

echo "<a class='button' href=\"javascript:history.go(-1)\">Retour</a>";

?>

