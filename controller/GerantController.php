<?php
class GerantController extends Controller {

	public function connecter() {
		if (isset($_POST['connecter'])) {
			$login = strtolower($_POST['login']);
			$st = db()->prepare("SELECT * FROM t_e_gerant_grt WHERE LOWER(grt_mel) = '$login'");
			$st->execute();
			$row = $st->fetch(PDO::FETCH_ASSOC);

			if(strtolower($row['grt_mel']) == $login) {
				$_SESSION['gerant'] = new Gerant($row['grt_id']);
				header("Location: index.php");
			}
			else {
				$this->render("connexion");
				echo "Identifiant incorrect.";
			}
		}
		$this->render("connexion");
	}

	public function deconnexion() {
		unset($_SESSION['gerant']);
		header("Location: index.php");
	}
}