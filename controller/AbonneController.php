<?php
class AbonneController extends Controller {
	public function inscription() {
		$this->render("inscription");
	}

	public function modifierCompte() {
		$this->render("modifierCompte");
	}

	public function connexion() {
		$this->render("connexion");
	}

	public function inscrire() {
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
				echo "pop";
				if (preg_match("#^[a-zA-Z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}$#", $_POST['email'])) {
					$verif_email_valide =true;
				} else {
					$verif_email_valide= false;
					$_SESSION['erreur'] = 'l\'adresse mail n\'est pas valide';
				}
				if ($_POST['pass'] == $_POST['pass_confirm']) {
					$verif_pass_corresp = true;
				} else {
					$verif_pass_corresp = false;
					$_SESSION['erreur'] = 'Les 2 mots de passe sont différents.';
				}
				$verif_mail_dispo = Abonne::avaiable($_POST['email'],"ABO_Mel");
				$verif_pseudo_dispo = Abonne::avaiable($_POST['pseudo'],"ABO_Pseudo");

				if(!$verif_mail_dispo)
					$_SESSION['erreur'] = 'Cette adresse email est déjà prise';
				if(!$verif_pseudo_dispo)
					$_SESSION['erreur'] = 'Ce pseudo est déjà pris';

				if($verif_pseudo_dispo && $verif_mail_dispo 
						&& $verif_pass_corresp && $verif_email_valide) {

					$param = array(
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
					//$_SESSION['abonne'] = $abonne->abo_id;
					header('Location: index.php');
					exit();
				}
			} else {
				$_SESSION['erreur'] = "l'un des champs n'est pas renseigné";
			}
		}
	}

	public function modifier() {
		if (isset($_POST['modifier'])) {
			if (isset($_POST['abo_adrligne1']) && isset($_POST['abo_cp'])
					&& isset($_POST['abo_ville']) && isset($_POST['abo_pays'])
					&& isset($_POST['abo_indicatif']) && isset($_POST['abo_tel'])) {

				if (preg_match("#^[1-9]{1-3}$#", $_POST['abo_indicatif'])) {
					$verif_indicatif = true;
				} else {
					$verif_indicatif = false;
					$erreur = 'l\'indicatif n\'est pas valide';
					echo $erreur;
				}

				if($verif_indicatif) {

					foreach ($_POST as $key => $value) {
						if ($_SESSION['abonne']->$key != $_POST[$key]) {
							$_SESSION['abonne']->$key = $_POST[$key];
						}
					}

					header('Location: index.php');
					exit();
				}
			}
			else {
				$erreur = 'l\'un des champs n\'est pas renseigné';
			}
		}
	}

	public function connecter() {
		if (isset($_POST['connecter'])) {
			$login = $_POST['login'];
			$class = get_called_class();
			$table = $class::getTableName();
			$tableMel = substr($table, -3)."_mel";
			$tablePass = substr($table, -3)."_motpasse";
			$st = db()->prepare("SELECT $tablePass from $table where $login = $tableMel");
			$st->execute();
			while($row = $st->fetch(PDO::FETCH_ASSOC)) {
				if (sha1($_POST['password']) == $row[$tablePass])
					echo "c'est bon";
				else
					echo "c'est pas bon...";
			}
		}
	}
}