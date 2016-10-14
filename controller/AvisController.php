<?php
class AvisController extends Controller {
	public function creation() {
		global $erreur;
		if (isset($_POST['envoyer']) && $_POST['envoyer'] == 'Envoyer') {
			if ((isset($_POST['vil']) && !empty($_POST['vil'])) 
				&&(isset($_POST['per']) && !empty($_POST['per']))
				&&(isset($_POST['lng']) && !empty($_POST['lng']))
				&&(isset($_POST['nom_occ']) && !empty($_POST['nom_occ']))
				&&(isset($_POST['titre']) && !empty($_POST['titre']))
				&&(isset($_POST['detail']) && !empty($_POST['detail']))
				&&(isset($_POST['note_glob']) && !empty($_POST['note_glob']))){

				if(!isset($_POST['recom']))
					$_POST['recom'] = "FALSE";
				else
					$_POST['recom'] = "TRUE";

					//tri des reponses facultatives
				foreach ($_POST as $key => $value) {
					if(preg_match('/^quest/',$key) && !empty($value))
						$questions_facultatives[substr($key,5)] = $value;
				}
				if(isset($questions_facultatives)) {
					if(count($questions_facultatives) != $_POST['count_questions'])
						$erreur = "Vous n'avez pas rempli toutes les questions facultatives";
				}
					//abonne
				if(!isset($erreur)) {
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
					//insertion des reponses
					if(isset($questions_facultatives) && !empty($questions_facultatives)) {
						foreach ($questions_facultatives as $key => $value) {
							$param = array(
								'avi_id' => $avis->avi_id,
								'qul_id' => $key,
								'rel_reponse' => $value 
								);
							$rel = new Reponse($param);
						}
					}
					//redirection
					$path = "index.php?r=location/showLocation&id=".$_GET['loc_id'];
					header("Location: $path");
				}
			} else 
			$erreur = "l'un des champs n'est pas renseigné"; 
		}
		if(isset($_SESSION['abo']))
			$this->render("creation");
		else
			$this->render("non_connecte");
	}


	public function reponse() {
		if(isset($_POST['envoyer'])) {
			$avis = new Avis($_GET['avi_id']);
			$avis->avi_reponseavis = $_POST['reponse'];
			echo '<script type="text/javascript">window.alert("Réponse enregistree");</script>';
			$path = "index.php?r=location/showLocation&id=".$avis->loc_id;
			header("Location: $path");
		}
		else {
			$avis = new Avis($_GET['avi_id']);
			$data = $avis;
			$this->render("reponse_avis", $data);
		}
	}

}   
