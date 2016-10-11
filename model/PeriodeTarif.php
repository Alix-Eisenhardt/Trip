<?php

class PeriodeTarif extends Model {
	static $TABLE_NAME = "t_r_periodetarif_pet";
	protected $_pet_id;
	protected $_pet_intitule;
	protected $_pet_datedeb;
	protected $_pet_datefin;

	protected $externalClasses = array(
		"pet" => "PeriodeTarif"
	);
}