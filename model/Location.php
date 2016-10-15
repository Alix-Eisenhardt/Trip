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

	protected $_grt_obj;
	protected $_pay_obj;

	protected $externalClasses = array(
		"loc" => "Location",
		"grt" => "Gerant",
		"pay" => "Pays"
	);

	public function __toString() {
		$s = "<h3>".$this->loc_titre."</h3>";
		if(isset($_SESSION['gerant']) && $_SESSION['gerant']->grt_id == $this->grt_id) {
			$path = "./?r=location/ajoutPhoto&loc_id=".$this->loc_id;
			$s .= "<a class='button' href='$path'>Ajouter une Photo</a><br><br>";
		}
		$s .= "Type : ".$this->loc_type."<br>";
		$s .= "Description : ".$this->loc_description."<br>";
		$s .= $this->loc_nbchambres." chambres, ";
		$s .= $this->loc_nbcouchages." couchages, ";
		$s .= $this->loc_nbsallesbain." salle(s) de bain, ";
		$s .= $this->loc_nboccupants." occupants.<br>";
		if(isset($this->loc_codereservationtrip))
			$s .= "codereservationtrip : ".$this->loc_codereservationtrip."<br>";
		$s .= "<div class=\"adresse\">Adresse : ".$this->loc_adrligne1."<br>";
		if(isset($this->loc_adrligne2))
			$s .= $this->loc_adrligne2."<br>";
		$s .= $this->loc_cp." ".$this->loc_ville."<br>";
		if(isset($this->loc_etat))
			$s .= "etat : ".$this->loc_etat."<br>";
		$s .= $this->pay_obj."</div>";
		$s .= "<div class=\"gerant\"><p>À propos du propriétaire, ";
		$s .= "<a href=./?r=gerant/sendMail&id=".$this->grt_id.">".$this->grt_obj->grt_nom."</a> :<br>";
		$s .= $this->grt_obj."</p></div>";
		return $s;
	}

	public function shortVersion($date_deb=null, $date_fin=null) {
		$periode = PeriodeTarif::findBySelection($date_deb, $date_fin);
		$prix = TarifLocation::findBySelection($this->loc_id, $periode[0]->pet_id);

		$s = "<div class='location'>";
		$s .= "<h3>".$this->loc_titre."</h3>";
		if(isset($prix) && $prix != null)
			$s .= "Prix : <span class='prix'>".$prix[0]."</span>€ la nuit<br>";
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
		return $s."</div>";
	}

}
