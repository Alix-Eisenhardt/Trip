
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

echo "<a class='button' href=\"javascript:history.go(-1)\">Retour</a>";

?>