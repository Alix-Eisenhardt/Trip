<?php
class Reponse extends Model {
	static $TABLE_NAME = "t_j_reponsequestionloc_rel";
	
	protected $_avi_id;
	protected $_qul_id;
	protected $_rel_reponse;

	protected $externalClasses = array(
		"rel" => "Reponse",
		"avi" => "Avis",
		"qul" => "Question"
	);
}
