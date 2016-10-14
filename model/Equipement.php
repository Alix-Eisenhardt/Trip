<?php

class Equipement extends Model {

  static $TABLE_NAME = "t_r_equipement_equ";
  protected $_equ_id;
  protected $_equ_libelle;
  
  protected $externalClasses = array("equ" => "Equipement");
}
