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
      $search[0] .= " entre le ".date("j M Y",strtotime($_POST["date_debut"]))." et le ".date("j M Y",strtotime($_POST["date_fin"]));
      $ids = PlanningLocation::findAvailable($_POST["date_debut"], $_POST["date_fin"]);
      $bool = true;
      foreach ($search[1] as $key => $value) {
        if(!in_array($value->loc_id, $ids))
          unset($search[1][$key]);
      }
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
    global $erreur;
    if(isset($_SESSION['gerant']) && $_SESSION['gerant']->grt_id == $_GET['loc_id']) {
      if(isset($_POST['ajouter']) && $_POST['ajouter'] == 'Ajouter') {
        if(!empty($_FILES['photo']['name'])) {
          //1mo 1048576
          //500ko = 524288
          $maxsize = 524288;

          //test ext
          $extensions_valides = array( 'jpg' , 'jpeg' , 'gif' , 'png' );
          $extension_upload = strtolower(  substr(  strrchr($_FILES['photo']['name'], '.')  ,1)  );
          if ( in_array($extension_upload,$extensions_valides) ) {
            //test err
            if ($_FILES['photo']['error'] == 0) {
              //test taille
              if ($_FILES['photo']['size'] < $maxsize) {
                $uploaddir = './images/';
                $nom = "img";
                //on récupère le nombre de champs dans la base pour créer un identifiant unique à toutes les images
                //on ajoute 15, car les images déja présentes commencent à 15...
                $id = Photo::Count() + 15;
                $nom .= $id;
                $nom .= ".".$extension_upload;
                $uploadfile = $uploaddir . $nom;

                //on déplace l'image
                $res = move_uploaded_file($_FILES['photo']['tmp_name'], $uploadfile);
                //si ça a marché on insère en base
                if ($res) {
                  $param = array(
                    "loc_id"=> $_GET['loc_id'],
                    "pho_url"=> substr($uploadfile,2)
                  );
                  $photo = new Photo($param);

                  $path = "index.php?r=location/showLocation&id=".$_GET['loc_id'];
                  header("Location: $path");
                } else {
                  $erreur = "Erreur lors du transfert";
                }
              } else {
                echo("1");
                $erreur = "Le fichier est trop gros, taille limite : 500ko";
              }
            } else {
              $erreur = "Erreur lors du transfert, problème du serveur<br>Nous nous excusons pour le désagrément";
            }
          } else {
            $erreur = "Type de fichier non valide, types autorisés : .jpeg, .jpg, .gif, .png";
          }
        } else {
          $erreur = "Veuillez insérer une image";
        }
      }
      $this->render("ajoutImages");
    } else {
      $this->render("notFound");
    }
  }
}

