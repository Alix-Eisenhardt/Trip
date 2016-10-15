<?php
class Langue extends Model {
	static $TABLE_NAME = "t_r_langue_lng";
	protected $_lng_id;
	protected $_lng_libelle;

	protected $externalClasses = array(
		"lng" => "Langue"
	);

	public function __toString() {
		return $this->lng_libelle;
	}
}
