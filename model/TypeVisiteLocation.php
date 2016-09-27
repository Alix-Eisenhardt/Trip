<?php

class TypeVisiteLocation extends Model {
	static $TABLE_NAME = "t_r_typevisitelocation_vil";
	protected $_vil_id;
	protected $_vil_libelle;

	protected $externalClasses = array(
		"vil" => "TypeVisiteLocation",
	);

	public function __toString() {
		return $this->vil_libelle;
	}
}