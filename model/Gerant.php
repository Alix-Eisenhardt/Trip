<?php
class Gerant extends Model {
	static $TABLE_NAME = "t_e_gerant_grt";
	protected $_grt_id;
	protected $_grt_nom;
	protected $_grt_tauxreponse;
	protected $_grt_delaireponse;
	protected $_grt_dateinscription;
	protected $_grt_mel;

	protected $externalClasses = array(
		"grt" => "Gerant"
	);

	public function __toString() {
		$s = "Taux de réponse : ".$this->grt_tauxreponse."%<br>";
		$s .= "Délai de réponse : ".$this->grt_delaireponse."<br>";
		$s .= "Date d'inscription : ".$this->grt_dateinscription."<br>";
		return $s;
	}
}
