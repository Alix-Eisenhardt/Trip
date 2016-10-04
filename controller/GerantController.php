<?php
class GerantController extends Controller {

	public function connecter() {
		if (isset($_POST['connecter'])) {
			$login = $_POST['login'];
			$st = db()->prepare("SELECT * FROM t_e_gerant_grt WHERE grt_mel = '$login'");
			$st->execute();
			$row = $st->fetch(PDO::FETCH_ASSOC);

			if(($row['grt_mel'] == $_POST['login'])) {
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