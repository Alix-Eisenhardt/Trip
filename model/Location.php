<?php
class Location extends Model {
  static $TABLE_NAME = "t_e_location_loc";
  protected $_loc_id;
  protected $_grt_id;
  protected $_grt_obj;
  protected $_loc_titre;
  protected $_loc_type;
  protected $_loc_description;
  protected $_loc_nbchambres;
  protected $_loc_nbcouchages;
  protected $_loc_nbsallesbain;
  protected $_loc_nboccupants;
  protected $_loc_codereservationtrip;
  protected $_loc_adrligne1;
  protected $_loc_adrligne2;
  protected $_loc_cp;
  protected $_loc_ville;
  protected $_loc_etat;
  protected $_pay_id;
  protected $_pay_obj;
  protected $_loc_latitude;
  protected $_loc_longitude;

  protected $externalClasses = array("loc" => "Location", "grt" => "Gerant", "pay" => "Pays");

  public function __toString() {
    $s = "<h3>".$this->loc_titre."</h3>";
    $s .= "Type : ".$this->loc_type."<br>";
    $s .= "Gérant : ".$this->grt_obj."<br>";
    $s .= "Description : ".$this->loc_description."<br>";
    $s .= $this->loc_nbchambres." chambres, ";
    $s .= $this->loc_nbcouchages." couchages, ";
    $s .= $this->loc_nbsallesbain." salle(s) de bain, ";
    $s .= $this->loc_nboccupants." occupants.<br>";
    if(isset($this->loc_codereservationtrip))
        $s .= "codereservationtrip : ".$this->loc_codereservationtrip."<br>";
    $s .= "Adresse : ".$this->loc_adrligne1."<br>";
    if(isset($this->loc_adrligne2))
        $s .= $this->loc_adrligne2."<br>";
    $s .= $this->loc_cp." ".$this->loc_ville."<br>";
    if(isset($this->loc_etat))
        $s .= "etat : ".$this->loc_etat."<br>";
    $s .= $this->pay_obj;
    return $s."<br>";
  }

  public function shortVersion() {
    $s = "<h3>".$this->loc_titre."</h3>";
    $s .= "Type : ".$this->loc_type."<br>";
    $s .= $this->loc_nbchambres." chambres, ";
    $s .= $this->loc_nbcouchages." couchages, ";
    $s .= $this->loc_nbsallesbain." salle(s) de bain, ";
    $s .= $this->loc_nboccupants." occupants.<br>";
    if(isset($this->loc_codereservationtrip))
        $s .= "codereservationtrip : ".$this->loc_codereservationtrip."<br>";
    $s .= "Adresse : ".$this->loc_adrligne1."<br>";
    if(isset($this->loc_adrligne2))
        $s .= $this->loc_adrligne2."<br>";
    $s .= $this->loc_cp." ".$this->loc_ville."<br>";
    if(isset($this->loc_etat))
        $s .= "etat : ".$this->loc_etat."<br>";
    $s .= "<a href=./?r=location/showLocation&id=".$this->loc_id.">Voir plus de détails</a>";
    return $s."<br>";
  }

}
