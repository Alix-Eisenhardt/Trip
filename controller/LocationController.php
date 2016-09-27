<?php

class LocationController extends Controller {
  public function __construct() {

  }

  public function showLocation() {
    try {
        $location = new Location($_GET["id"]);
        $listeAvis = Avis::findAll();
        $avisPourLocation = [];
        foreach ($listeAvis as $avis) {
          if($avis->loc_obj == $location)
            $avisPourLocation[] = $avis;
        }
        $data = array($location, $avisPourLocation);
    } catch(Exception $e) {
        $data = "Erreur : location non trouvée. N'essayez pas de rentrer";
        $data .= " des choses au hasard dans la barre d'adresse !";
    } finally {
        $this->render("showLocation", $data);
    }
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
    $list = Location::getTypeOfColumn();
    foreach ($list as $key => $value) {
      if(isset($_POST["$key"]) && !empty($_POST["$key"]))
        if(!pgTypeToPHPTestType($value,$_POST["$key"])){
          $flag = false;
          $erreur = $key;
          break;
          }
    }
    if(!$flag)
      echo "<div>Le champ $erreur est mal renseigné</div>";
    else{
      $loc = new Location();
      $classvars = get_class_vars("Location");
      foreach ($classvars as $v) {
      		$vAttrib = "_".$v;
          $attribute = substr($v,1);
        if(isset($_POST["$v"]))
          $loc->$vAttrib = $_POST["$v"];
      }
      $this->render("confirm", print_r($loc));
    }

	}
}
