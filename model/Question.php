<?php
class Question extends Model {
	static $TABLE_NAME = "t_r_questionlocation_qul";

	protected $_qul_id;
	protected $_qul_question;

	protected $externalClasses = array(
		"avi" => "Avis",
		"qul" => "Question"
	);

	function __tostring() {
		return $this->qul_question;
	}
}
