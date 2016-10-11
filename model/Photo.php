<?php

class Photo extends Model {
	static $TABLE_NAME = "t_e_photo_pho";
	protected $_pho_id;
	protected $_loc_id;
	protected $_avi_id;
	protected $_pho_url;

	protected $externalClasses = array(
		"pho" => "Photo",
		"avi" => "Avis",
		"loc" => "Location"
	);
}