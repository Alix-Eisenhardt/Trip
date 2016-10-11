<?php

class TypeSejour extends Model {
	static $TABLE_NAME = "t_r_typesejour_sej";
	protected $_sej_id;
	protected $_sej_libelle;

	protected $externalClasses = array(
		"sej" => "TypeSejour"
	);
}