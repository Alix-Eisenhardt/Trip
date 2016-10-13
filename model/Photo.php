<?php

class Photo extends Model {
	static $TABLE_NAME = "t_e_photo_pho";
	protected $_pho_id;
	protected $_loc_id;
	protected $_avi_id;
	protected $_pho_url;

	protected $_loc_obj;
	protected $_avi_obj;

	protected $externalClasses = array(
		"pho" => "Photo",
		"avi" => "Avis",
		"loc" => "Location"
	);

	public static function count() {
			$class = get_called_class();
			$table = $class::getTableName();
			$tableId = substr($table, -3)."_ID";
			$st = db()->prepare("select ".$tableId." from $table");
			$st->execute();
			return $st->rowCount();
	}
}