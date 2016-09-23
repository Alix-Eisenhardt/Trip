<?php

class LocationController extends Controller {
  public function __construct() {

  }

  public function index() {
    $location = new Location($_GET["id"]);
    $this->render("index", $location);
  }

  public function search() {
  	$search = [];
  	if(isset($_POST["ville"]))
  		$search["ville"] = $_POST["ville"];
  	if(isset($_POST["date_debut"]))
  		$search["date_debut"] = $_POST["date_debut"];
  	if(isset($_POST["date_fin"]))
  		$search["date_fin"] = $_POST["date_fin"];

  	$this->render("search", Location::findAll());
  }
}
