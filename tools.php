<?php

function pgTypeToPHPTestType($type, $value){
	if(substr($type,0,3) == "int" || $type == "numeric")
		return is_integer($value);
	else if (substr($type,0,5) == "float")
		return is_double($value);
	else if ($type == "varchar")
		return true;
}

function pgTypeToHTMLFormValue($type, $value){
	if(substr($type,0,3) == "int" || $type == "numeric" || substr($type,0,5) == "float")
		echo "number";
	else
		echo "text";
}

function getLatLong($postalAddress) {

$urlWebServiceGoogle = 'http://maps.google.com/maps/api/geocode/json?address=%s&sensor=false&language=fr';
//$postalAddress = '55 Faubourg Saint-Honoré, Paris, France';
 
$url = vsprintf($urlWebServiceGoogle, urlencode($postalAddress));
$response = json_decode(file_get_contents($url));
     
if (empty($response->status)) throw new Exception();
if ($response->status != "OK") throw new Execption($response->status);
 
$latitude =  $response->results[0]->geometry->location->lat;
$longitude = $response->results[0]->geometry->location->lng;
 
echo 'Latitude: '.$latitude."\n";
echo 'Longitude: '.$longitude."\n";
}
?>
