<?php

class TarifLocation extends Model {
	static $TABLE_NAME = "t_j_tariflocation_tar";
	protected $_loc_id;
	protected $_pet_id;
	protected $_sej_id;
	protected $_tar_prix;

	protected $externalClasses = array(
		"loc" => "Location",
		"pet" => "PeriodeTarif",
		"sej" => "TypeSejour",
		"tar" => "TarifLocation"
	);
}