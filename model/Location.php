<?php
class Location extends Model {
  static $TABLE_NAME = "t_e_location_loc";
  protected $_loc_id;
  protected $_grt_id;
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
  protected $_loc_latitude;
  protected $_loc_longitude;

  public function __toString() {
    $s = "";
    foreach (get_object_vars($this) as $key => $value) {
      $s .= $key." = ".$value."<br>";
    }
    return $s."<br>";
  }

}
