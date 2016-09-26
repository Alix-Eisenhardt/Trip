<?php
class AbonneController extends Controller {
	public function inscription() {
		$this->render("inscription");
	}

	public function modifierCompte() {
		$this->render("modifierCompte");
	}

	public function inscrire() {
		if (isset($_POST['inscription']) && $_POST['inscription'] == 'Inscription') {
			if (
					(isset($_POST['nom']) && !empty($_POST['nom'])) 
					&& (isset($_POST['prenom']) && !empty($_POST['prenom'])) 
					&& (isset($_POST['pseudo']) && !empty($_POST['pseudo'])) 
					&& (isset($_POST['pass']) && !empty($_POST['pass'])) 
					&& (isset($_POST['pass_confirm']) && !empty($_POST['pass_confirm']))
					&& (isset($_POST['adr1']) && !empty($_POST['adr1']))
					&& (isset($_POST['cp']) && !empty($_POST['cp']))
					&& (isset($_POST['ville']) && !empty($_POST['ville']))
					&& (isset($_POST['pay_id']) && !empty($_POST['pay_id']))
					&& (isset($_POST['indicatif']) && !empty($_POST['indicatif']))
					&& (isset($_POST['tel']) && !empty($_POST['tel']))
					) {
				if (preg_match("#^[a-zA-Z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}$#", $_POST['email'])) {
					$verif_email_valide =true;
				} else {
					$verif_email_valide= false;
					$erreur = 'l\'adresse mail n\'est pas valide';
				}
				if ($_POST['pass'] == $_POST['pass_confirm']) {
					$verif_pass_corresp = true;
				} else {
					$verif_pass_corresp = false;
					$erreur = 'Les 2 mots de passe sont différents.';
				}
				$verif_mail_dispo = Abonne::avaiable($_POST['email'],"ABO_Mel");
				$verif_pseudo_dispo = Abonne::avaiable($_POST['pseudo'],"ABO_Pseudo");

				if(!$verif_mail_dispo)
					$erreur = 'Cette adresse email est déjà prise';
				if(!$verif_pseudo_dispo)
					$erreur = 'Ce pseudo est déjà pris';

				if($verif_pseudo_dispo && $verif_mail_dispo 
						&& $verif_pass_corresp && $verif_email_valide) {

					$param = array(
						"abo_id"=> "default",
						"abo_pseudo"=> $_POST['pseudo'],
						"abo_motdepasse"=> sha1($_POST['pass']),
						"abo_mel" => $_POST['email'],
						"abo_nom" => $_POST['nom'],
						"abo_prenom" => $_POST['prenom'],
						"abo_adrligne1" => $_POST['adr1'],
						"abo_adrligne2" => $_POST['adr2'],
						"abo_cp" => $_POST['cp'],
						"abo_ville" => $_POST['ville'],
						"abo_etat" => $_POST['etat'],
						"pay_id" => $_POST['pay_id'],
						"abo_latitude" => 2,
						"abo_longitude" => 2,
						"abo_indicatif" => $_POST['indicatif'],
						"abo_tel" => $_POST['tel'],
						"abo_aeroport" => $_POST['aeroport'] 
						);

					$abonne = new Abonne($param);

					$_SESSION['ouvert'] = true;
					$_SESSION['abonne'] = $abonne;

					//header('Location: index.php');
					exit();
				}
			}
			else {
				$erreur = 'l\'un des champs n\'est pas renseigné';
			}
		}
	}

	public function modifier() {
		if (isset($_POST['modifier'])) {
			if ((isset($_POST['abo_adrligne1']) && !empty($_POST['abo_adrligne1']))  
					&& (isset($_POST['abo_cp']) && !empty($_POST['abo_cp'])) 
					&& (isset($_POST['abo_ville']) && !empty($_POST['abo_ville'])) 
					&& (isset($_POST['abo_pays']) && !empty($_POST['abo_pays'])) 
					&& (isset($_POST['abo_indicatif']) && !empty($_POST['abo_indicatif']))
					&& (isset($_POST['abo_telephone'])) && !empty($_POST['abo_telephone'])) {

				if (preg_match("#^[1-9]{4}$#", $_POST['abo_indicatif'])) {
					$verif_indicatif = true;
				} else {
					$verif_indicatif = false;
					$erreur = 'l\'indicatif n\'est pas valide';
				}

				if($verif_indicatif) {

					foreach ($_POST as $key => $value) {
						if ($this->$key != $_POST[$key]) {
							$this->$key = $_POST[$key];
						}
					}

					//$_SESSION['abonne'] = $this;

					header('Location: index.php');
					exit();
				}
			}
			else {
				$erreur = 'l\'un des champs n\'est pas renseigné';
				header('Location: index.php?r=abonne/modifierCompte');
			}
		}
	}
}