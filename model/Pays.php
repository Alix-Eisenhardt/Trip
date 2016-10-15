<?php
class Pays extends Model {
	static $TABLE_NAME = "t_r_pays_pay";
	protected $_pay_id;
	protected $_pay_nom;

	protected $externalClasses = array(
		"pay" => "Pays"
	);

	public function __toString() {
		return $this->pay_nom;
	}
}
