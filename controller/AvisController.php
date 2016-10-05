<?php
class AvisController extends Controller {
	public function creation() {
		if (isset($_POST['envoyer']) && $_POST['envoyer'] == 'Envoyer') {
			if ((isset($_POST['vil']) && !empty($_POST['vil'])) 
				&&(isset($_POST['per']) && !empty($_POST['per']))
				&&(isset($_POST['lng']) && !empty($_POST['lng']))
				&&(isset($_POST['nom_occ']) && !empty($_POST['nom_occ']))
				&&(isset($_POST['titre']) && !empty($_POST['titre']))
				&&(isset($_POST['detail']) && !empty($_POST['detail']))
				&&(isset($_POST['note_glob']) && !empty($_POST['note_glob']))){
					if(!isset($_POST['recom'])) {
						$_POST['recom'] = "FALSE";
					} else {
						$_POST['recom'] = "TRUE";
					}

					$param = array(
							"abo_id"=> $_SESSION['abo']->abo_id,
							"loc_id"=> $_GET['loc_id'],
							"vil_id"=> $_POST['vil'],
							"per_id"=> $_POST['per'],
							"lng_id"=> $_POST['lng'],
							"avi_nomoccupant"=> $_POST['nom_occ'],
							"avi_titre"=> $_POST['titre'],
							"avi_detail"=> $_POST['detail'],
							"avi_noteglobale"=> $_POST['note_glob'],
							"avi_recommandationami"=> $_POST['recom'],
							);
						$avis = new Avis($param);
						$mail_to = $_SESSION['abo']->abo_mel;
						melConfirm($mail_to);
					$path = "index.php?r=location/showLocation&id=".$_GET['loc_id'];
					//header("Location: $path");
				} else 
					$erreur = "l'un des champs n'est pas renseigné"; 
			}
		if(isset($_SESSION['ouvert']))
			$this->render("creation");
		else
			$this->render("non_connecte");
		if(isset($erreur)) {
			echo $erreur;
			unset($erreur);
		}
	}
}   /*
	protected $_avi_reponseavis;
	*/