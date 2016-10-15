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
      $data = "Erreur : location non trouvée. N'essayez pas de rentrer";
      $data .= " des choses au hasard dans la barre d'adresse !";
    } finally {
      $this->render("showLocation", $data);
    }
  }
  public function search() {
    // C'est pas propre :(
    $locations = Location::findAll();
    $search = [$_POST["ville"]];
    foreach ($locations as $key => $value) {
      if(strtolower($_POST["ville"]) == strtolower($value->loc_ville))
        $search[1][] = $value;
    }
    if(isset($_POST["date_debut"]) && $_POST["date_debut"] != null) {
      $search[0] .= "<br>entre le ";
      $search[0] .= "<span id='date_deb' class='".$_POST["date_debut"]."'>".date("j M Y",strtotime($_POST["date_debut"]))."</span>";
      $search[0] .= " et le ";
      $search[0] .= "<span id='date_fin' class='".$_POST["date_fin"]."'>".date("j M Y",strtotime($_POST["date_fin"]))."</span>";
      $ids = PlanningLocation::findAvailable($_POST["date_debut"], $_POST["date_fin"]);
      $bool = true;
      foreach ($search[1] as $key => $value) {
        if(!in_array($value->loc_id, $ids))
          unset($search[1][$key]);
      }
    }
    if(isset($_POST['check'])) {
      $equipementsLocation = EquipementLocation::findAll();
      $data[0] = $search[0];
      foreach($search[1] as $key => $value) {
        $good = false;
        $id = $value->loc_id;
        $data[1][$id] = $value;
        $equList = array();
        foreach($equipementsLocation as $eql) {
          if(($eql->loc_id == $value->loc_id)) {
            $good = true;
            $equList[] = $eql->equ_id;
          }
        }
        foreach($_POST['check'] as $v){
          if(!in_array($v, $equList)) {
            $good = false;
          }
        }
        if(!$good)
          unset($data[1][$id]);
      }
      $search = $data;
    }
    $this->render("search", $search);
  }
  public function createLocation(){
    $this->render("createLocation");
  }
  public function confirm(){
    $p = new Pays($_POST['pay_id']);
    $postalAddress = $_POST['loc_adrligne1'];
    if (isset($_POST['loc_adrligne2']) && !empty($_POST['loc_adrligne2']))
      $postalAddress .= " ".$_POST['loc_adrligne2'];
    $postalAddress .= ", ".$_POST['loc_ville'].", ".$p->pay_nom;
    $coord = getCoord($postalAddress);
    list($latitude, $longitude) = explode("/",$coord);
    $_POST["loc_latitude"] =  $latitude;
    $_POST["loc_longitude"] =  $longitude;
    if(isset($_SESSION['gerant']))
      $_POST["grt_id"]=$_SESSION['gerant']->grt_id;
    $_POST["loc_codereservationtrip"] = 1;
    $list = Location::getTypeOfColumn();
    foreach ($list as $key => $v) {
      if(isset($_POST["$key"]) && !empty($_POST["$key"]))
        $attribute["$key"] = $_POST["$key"];
    }
    $loc = new Location($attribute);
    $this->render("confirm", $loc->loc_id);
  }

  public function dispo(){
    $list = array();
    $list = PlanningLocation::findDispoLocation($_GET['loc_id']);
    $this->render("dispoLocation", $list);
  }

  public function ajoutPhoto() {
    $loc = new Location($_GET['loc_id']);
    global $erreur;
    if(isset($_SESSION['gerant']) && $_SESSION['gerant']->grt_id == $loc->grt_id) {
      if(isset($_POST['ajouter']) && $_POST['ajouter'] == 'Ajouter') {
        $retour = Photo::ajoutImage("loc_id",$_GET['loc_id']);
        if($retour == true) {
          $path = "index.php?r=location/showLocation&id=".$_GET['loc_id'];
          header("Location: $path");
        } else {
          $erreur = $retour;
        }
      }
      $this->render("ajoutImages");
    } else {
      $this->render("../notFound");
    }
  }
}
