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

function getCoord($postalAddress) {
	$urlWebServiceGoogle = 'http://maps.google.com/maps/api/geocode/json?address=%s&sensor=false&language=fr';
	$url = vsprintf($urlWebServiceGoogle, urlencode($postalAddress));
	$response = json_decode(file_get_contents($url));
	if (empty($response->status)) throw new Exception();
	if ($response->status != "OK") throw new Execption($response->status);
	$latitude =  $response->results[0]->geometry->location->lat;
	$longitude = $response->results[0]->geometry->location->lng;
	return $latitude."/".$longitude;
}

function melConfirm($mail) {
	if (!preg_match("#^[a-z0-9._-]+@(hotmail|live|msn).[a-z]{2,4}$#", $mail)) {
		$passage_ligne = "\r\n";
	} else {
		$passage_ligne = "\n";
	}

	$message_txt = "Votre commentaire à bien été posté";
	$message_html = "<html><head></head><body> $message_txt </body></html>";
	 
	//=====Création de la boundary
	$boundary = "-----=".md5(rand());
	//==========
	 
	//=====Définition du sujet.
	$sujet = "Avis posté sur TripAdvisor";
	//=========
	 
	//=====Création du header de l'e-mail.
	$header = "From: \"TripAdvisor noreply\"<confirm-noreply@TripAdvisor.com>".$passage_ligne;
	$header.= "MIME-Version: 1.0".$passage_ligne;
	$header.= "Content-Type: multipart/alternative;".$passage_ligne." boundary=\"$boundary\"".$passage_ligne;
	//==========
	 
	//=====Création du message.
	$message = $passage_ligne."--".$boundary.$passage_ligne;
	//=====Ajout du message au format texte.
	$message.= "Content-Type: text/plain; charset=\"ISO-8859-1\"".$passage_ligne;
	$message.= "Content-Transfer-Encoding: 8bit".$passage_ligne;
	$message.= $passage_ligne.$message_txt.$passage_ligne;
	//==========
	$message.= $passage_ligne."--".$boundary.$passage_ligne;
	//=====Ajout du message au format HTML
	$message.= "Content-Type: text/html; charset=\"ISO-8859-1\"".$passage_ligne;
	$message.= "Content-Transfer-Encoding: 8bit".$passage_ligne;
	$message.= $passage_ligne.$message_html.$passage_ligne;
	//==========
	$message.= $passage_ligne."--".$boundary."--".$passage_ligne;
	$message.= $passage_ligne."--".$boundary."--".$passage_ligne;
	//==========
	 
	//=====Envoi de l'e-mail.
	mail($mail,$sujet,$message,$header);
	//==========
	}
?>
