<?php

class TarifLocation extends Model {
	static $TABLE_NAME = "t_j_tariflocation_tar";
	protected $_loc_id;
	protected $_pet_id;
	protected $_sej_id;
	protected $_tar_prix;

	protected $_loc_obj;
	protected $_pet_obj;
	protected $_sej_obj;

	protected $externalClasses = array(
		"loc" => "Location",
		"pet" => "PeriodeTarif",
		"sej" => "TypeSejour",
		"tar" => "TarifLocation"
	);

	public static function findBySelection($loc_id, $pet_id) {
		$table = TarifLocation::getTableName();
		$st = db()->prepare("SELECT * FROM $table WHERE loc_id = :loc_id and pet_id = :pet_id");
		$st->bindValue(":loc_id", $loc_id);
		$st->bindValue(":pet_id", $pet_id);
		$st->execute();
		$list = array();

		while($row = $st->fetch(PDO::FETCH_ASSOC)) {
			$param = array(
				'loc_id' => $loc_id,
				'pet_id' => $pet_id,
				'sej_id' => $row['sej_id']
			);
			$list[] = new TarifLocation($param,true);
		}
		return $list;
	}

	public function __toString() {
		return $this->tar_prix;
	}
}
