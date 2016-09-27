<?php

class PeriodeVisite extends Model {
	static $TABLE_NAME = "t_r_periodevisite_per";
	protected $_per_id;
	protected $_per_mois;
	protected $_per_annee;

	protected $externalClasses = array(
		"per" => "PeriodeVisite",
	);

	public function __toString() {
		return $this->per_mois."/".$this->per_annee;
	}
}