<?php
class AbonneController extends Controller {

	public function inscription() {
		if (isset($_POST['inscription']) && $_POST['inscription'] == 'Inscription') {
			if (
					(isset($_POST['nom']) && !empty($_POST['nom'])) 
					&& (isset($_POST['prenom']) && !empty($_POST['prenom'])) 
					&& (isset($_POST['pseudo']) && !empty($_POST['pseudo'])) 
					&& (isset($_POST['pass']) && !empty($_POST['pass']))
					&& (isset($_POST['email']) && !empty($_POST['email']))  
					&& (isset($_POST['pass_confirm']) && !empty($_POST['pass_confirm']))
					&& (isset($_POST['adr1']) && !empty($_POST['adr1']))
					&& (isset($_POST['cp']) && !empty($_POST['cp']))
					&& (isset($_POST['ville']) && !empty($_POST['ville']))
					&& (isset($_POST['pay_id']) && !empty($_POST['pay_id']))
					&& (isset($_POST['indicatif']) && !empty($_POST['indicatif']))
					&& (isset($_POST['tel']) && !empty($_POST['tel']))) {
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

				if($verif_pseudo_dispo && $verif_mail_dispo && $verif_pass_corresp 
					&& $verif_email_valide) {

					//contruction de l'addresse postale : adresse, ville, pays
					$p = new Pays($_POST['pay_id']);
					$postalAddress = $_POST['adr1'];
					if (isset($_POST['adr2']) && !empty($_POST['adr2']))
						$postalAddress .= " ".$_POST['adr2'];
					$postalAddress .= ", ".$_POST['ville'].", ".$p->pay_nom;

					$coord = getCoord($postalAddress);
					list($latitude, $longitude) = explode("/",$coord);

					$param = array(
						"abo_pseudo"=> $_POST['pseudo'],
						"abo_motpasse"=> sha1($_POST['pass']),
						"abo_mel" => $_POST['email'],
						"abo_nom" => $_POST['nom'],
						"abo_prenom" => $_POST['prenom'],
						"abo_adrligne1" => $_POST['adr1'],
						"abo_adrligne2" => $_POST['adr2'],
						"abo_cp" => $_POST['cp'],
						"abo_ville" => $_POST['ville'],
						"abo_etat" => $_POST['etat'],
						"pay_id" => $_POST['pay_id'],
						"abo_latitude" => $latitude,
						"abo_longitude" => $longitude,
						"abo_indicatif" => $_POST['indicatif'],
						"abo_tel" => $_POST['tel'],
						"abo_aeroport" => $_POST['aeroport'] 
						);
					$abonne = new Abonne($param);
					$_SESSION['abo'] = $abonne;
					header("Location: .");
				}
			} else {
				$erreur = "l'un des champs n'est pas renseigné";
			}
		}
		//Faire le rendering du formulaire APRES le process, sinon le header Location ne peut pas fonctionner.
		$this->render("inscription");
	}

	public function modifier() {
		$erreur_indicatif = 'L\'indicatif n\'est pas valide';
		if (isset($_POST['modifier'])) {
			if (preg_match("#^[1-9]{1,3}$#", $_POST['abo_indicatif'])) {
				$verif_indicatif = true;
			} else {
				$verif_indicatif = false;
			}

			if($verif_indicatif) {

				foreach ($_POST as $key => $value) {
					if($key != 'modifier') {
						if ($_SESSION['abo']->$key != $_POST[$key]) {
							$_SESSION['abo']->$key = $_POST[$key];
						}
					}
				}
			}
		}
		$this->render("modifierCompte");
		if(isset($verif_indicatif)) {
			if($verif_indicatif)
				echo "Modifications validées !";
			else
				echo $erreur_indicatif;
		}	
	}

	public function connecter() {
		if (isset($_POST['connecter'])) {
			$login = strtolower($_POST['login']);
			$st = db()->prepare("SELECT * FROM t_e_abonne_abo WHERE LOWER(abo_mel) = '$login'");
			$st->execute();
			$row = $st->fetch(PDO::FETCH_ASSOC);

			if(($row['abo_motpasse'] == $_POST['password'])
					||($row['abo_motpasse'] == sha1($_POST['password']))) {
				$_SESSION['abo'] = new Abonne($row['abo_id']);
				header("Location: index.php");
			}
			else {
				$this->render("connexion");
				echo "Identifiant ou mot de passe incorrect.";
			}
		}
		$this->render("connexion");
	}

	public function deconnexion() {
		unset($_SESSION['abo']);
		header("Location: index.php");
	}

	public function showAbonne() {
        $abonne = new Abonne($_GET["id"]);
        $data = $abonne;
        $this->render("showAbonne", $data);
    }
}