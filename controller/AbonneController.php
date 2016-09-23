<?php
class AbonneController extends Controller {
	public function inscription() {
		$this->render("inscription");
	}
	public function inscrire() {
		if (isset($_POST['inscription']) && $_POST['inscription'] == 'Inscription') {
			if ((isset($_POST['nom']) && !empty($_POST['nom'])) && (isset($_POST['prenom']) && !empty($_POST['prenom'])) && (isset($_POST['pseudo']) && !empty($_POST['pseudo'])) && (isset($_POST['pass']) && !empty($_POST['pass'])) && (isset($_POST['pass_confirm']) && !empty($_POST['pass_confirm'])) && (isset($_POST['email'])) && !empty($_POST['email'])) {
				if (preg_match("#^[a-zA-Z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}$#", $_POST['email'])) {
					$verif_email_valide =0;
				} else {
					$verif_email_valide= 1;
					$erreur = 'l\'adresse mail n\'est pas valide';
				}
				if ($_POST['pass'] == $_POST['pass_confirm']) {
					$verif_pass_valide = 0;
				} else {
					$verif_pass_valide = 1;
					$erreur = 'Les 2 mots de passe sont différents.';
				}
				
			}
		}
	}
}