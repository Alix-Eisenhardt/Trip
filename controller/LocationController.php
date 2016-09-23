<?php

class LocationController extends Controller {
  public function __construct() {

  }

  public function index() {
    $location = new Location($_GET["id"]);
    $this->render("index", $location);
  }

  public function search() {
    $locations = Location::findAll();
  	$search = [];
  	foreach ($locations as $key => $value) {
  		if(isset($_POST["ville"])) {
  			if(strtolower($_POST["ville"]) == strtolower($value->loc_ville))
  				$search[] = $value;
  		} else break;
  	}
  	/*if(isset($_POST["date_debut"]))
  		$search["date_debut"] = $_POST["date_debut"];
  	if(isset($_POST["date_fin"]))
  		$search["date_fin"] = $_POST["date_fin"];*/

  	$this->render("search", $search);
  }

	public function createLocation(){
		$this->render("createLocation");
	}

	public function confirm(){
		$list = Location::GetTypeOfColumn();
		$this->render("confirm", $list);
	}
}
