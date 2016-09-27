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
  	$search = [$_POST["ville"]];
  	foreach ($locations as $key => $value) {
			if(strtolower($_POST["ville"]) == strtolower($value->loc_ville))
				$search[1][] = $value;
  	}
  	if(isset($_POST["date_debut"])) {
      $search[0] .= " entre le ".date("j F Y",strtotime($_POST["date_debut"]))." et le ".date("j F Y",strtotime($_POST["date_fin"]));
  		$ids = PlanningLocation::findNonAvailable($_POST["date_debut"], $_POST["date_fin"]);
      $bool = true;
      foreach ($search[1] as $key => $value) {
        if(in_array($value->loc_id, $ids))
          unset($search[1][$key]);
      }
    }

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
