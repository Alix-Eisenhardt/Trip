<?php
class Reponse extends Model {
	static $TABLE_NAME = "t_j_reponsequestionloc_rel";
	
	protected $_avi_id;
	protected $_qul_id;
	protected $_rel_reponse;

	protected $_qul_obj;
	protected $_avi_obj;


	public static function findReponsesBySelection($avi_id) {
		$table = Reponse::getTableName();
		$st = db()->prepare("SELECT * FROM $table WHERE avi_id = :avi_id");
		$st->bindValue(":avi_id", $avi_id);
		$st->execute();
		$list = array();

		while($row = $st->fetch(PDO::FETCH_ASSOC)) {
			$param = array(
				'avi_id' => $avi_id,
				'qul_id' => $row['qul_id']
				); 
			$list[] = new Reponse($param,true);
		}
		return $list;
	}

	protected $externalClasses = array(
		"rel" => "Reponse",
		"avi" => "Avis",
		"qul" => "Question"
	);

	public function __toString() {
		$s = "<div class='quest'>";
		$s .= $this->qul_obj->qul_question ." : ". $this->rel_reponse;
		$s .= "</div>";
		return $s;
	}
}
