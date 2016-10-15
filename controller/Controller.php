<?php

$data = NULL;

class Controller {
	public function render($view, $d=null) {
		global $data;
		global $erreur;
		include_once "view/header.php";
		$controller = get_class($this);
		$model = substr($controller, 0, strpos($controller, "Controller"));
		$data = $d;
		include_once "view/".strtolower($model)."/".$view.".php";
		include_once "view/footer.php";
	}
}
