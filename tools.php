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

function draw_calendar($month,$year){


	$calendar = '<table cellpadding="0" cellspacing="0" class="calendar">';

	$headings = array('L  ','Ma ','Me ','J  ','V  ','S  ','D  ');
	$calendar.= '<tr class="calendar-row"><td class="calendar-day-head">'.implode('</td><td class="calendar-day-head">',$headings).'</td></tr>';


	$running_day = date('w',mktime(0,0,0,$month,1,$year))-1;
	if($running_day<0)
		$running_day=6;
	$days_in_month = date('t',mktime(0,0,0,$month,1,$year));
	$days_in_this_week = 1;
	$day_counter = 0;
	$dates_array = array();

	$calendar.= '<tr class="calendar-row">';

	for($x = 0; $x < $running_day; $x++){
		$calendar.= '<td class="calendar-day-np"> </td>';
		$days_in_this_week++;
	}

	for($list_day = 1; $list_day <= $days_in_month; $list_day++){
		$m = $month;
		if($m<10)
			$id = $year."-0".$m."-";
		else
			$id = $year."-".$m."-";
		if($list_day<10)
			$id .= "0".$list_day;
		else
			$id .= $list_day;
		$calendar.= "<td class='calendar-day' id='$id'>";
		
		$calendar.= '<div class="day-number">'.$list_day.'</div>';

		$calendar.= str_repeat('<p> </p>',2);
		
		$calendar.= '</td>';
		if($running_day == 6){
			$calendar.= '</tr>';
			if(($day_counter+1) != $days_in_month){
				$calendar.= '<tr class="calendar-row">';
			}
			$running_day = -1;
			$days_in_this_week = 0;
		}
		$days_in_this_week++; $running_day++; $day_counter++;
	}

	if($days_in_this_week < 8){
		for($x = 1; $x <= (8 - $days_in_this_week); $x++){
			$calendar.= '<td class="calendar-day-np"> </td>';
		}
	}

	$calendar.= '</tr>';


	$calendar.= '</table>';
	

	return $calendar;
}
//type ajout prend les valeurs loc_id ou avi_id
function ajoutImage($type_ajout,$val_type) {
	if(!empty($_FILES['photo']['name'])) {
          //1mo 1048576
          //500ko = 524288
		$maxsize = 524288;

          //test ext
		$extensions_valides = array( 'jpg' , 'jpeg' , 'gif' , 'png' );
		$extension_upload = strtolower(  substr(  strrchr($_FILES['photo']['name'], '.')  ,1)  );
		if ( in_array($extension_upload,$extensions_valides) ) {
            //test err
			if ($_FILES['photo']['error'] == 0) {
              //test taille
				if ($_FILES['photo']['size'] < $maxsize) {
					$uploaddir = './images/';
					$nom = "img";
                //on récupère le nombre de champs dans la base pour créer un identifiant unique à toutes les images
                //on ajoute 15, car les images déja présentes commencent à 15...
					$id = Photo::Count() + 15;
					$nom .= $id;
					$nom .= ".".$extension_upload;
					$uploadfile = $uploaddir . $nom;

                //on déplace l'image
					$res = move_uploaded_file($_FILES['photo']['tmp_name'], $uploadfile);
                //si ça a marché on insère en base
					if ($res) {
						$param = array(
							"loc_id"=> $_GET['loc_id'],
							"pho_url"=> substr($uploadfile,2)
							);
						$photo = new Photo($param);

						$path = "index.php?r=location/showLocation&id=".$_GET['loc_id'];
						header("Location: $path");
					} else {
						$erreur = "Erreur lors du transfert";
					}
				} else {
					$erreur = "Le fichier est trop gros, taille limite : 500ko";
				}
			} else {
				$erreur = "Erreur lors du transfert, problème du serveur<br>Nous nous excusons pour le désagrément";
			}
		} else {
			$erreur = "Type de fichier non valide, types autorisés : .jpeg, .jpg, .gif, .png";
		}
	} else {
		$erreur = "Veuillez insérer une image";
	}
	if(isset($erreur))
		return $erreur;
}
?>
