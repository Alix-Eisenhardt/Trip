<?php
class EquipementLocation extends Model {
	static $TABLE_NAME = "t_j_equipementlocation_eql";
	protected $_loc_id;
	protected $_equ_id;
	protected $_eql_nombre;

	//Objets
	protected $_loc_obj;
	protected $_equ_obj;

	protected $externalClasses = array(
		"eql" => "EquipementLocation",
		"loc" => "Location",
		"equ" => "Equipement"
	);


  public static function findAll() {
		$class = get_called_class();
		$table = $class::getTableName();
		$st = db()->prepare("select * from $table");
		$st->execute();
		$list = array();
		while($row = $st->fetch(PDO::FETCH_ASSOC)) {
			$list[] = new $class($row['loc_id'],$row['equ_id']);
		}
		return $list;
	}

	public function __construct($loc,$equ) {
		$locId = $loc;
		$equId = $equ;
		$class = get_called_class();
		$table = $class::getTableName();
		$st = db()->prepare("select * from $table where loc_id=:locId and equ_id=:equId");
		$st->bindValue(":equId", $equId);
		$st->bindValue(":locId", $locId);
		$st->execute();
		if ($st->rowCount() != 1) {
			throw new Exception("Not in table: ".$table." id: ".$id );
		} else {
			$row = $st->fetch(PDO::FETCH_ASSOC);
			foreach($row as $field=>$value) {
				if($value != NULL) {
					if (substr($field, -2,2) == "id") {
						$linkedField = substr($field, 0,3);
						$linkedClass = $this->externalClasses[$linkedField];
						if ($linkedClass != get_class($this)) {
							$linkedObj = "_".$linkedField."_obj";
							$this->$linkedObj = new $linkedClass($value);
						}
						$field = "_".$field;
						$this->$field = $value;

					} else {
						$field = "_".$field;
						$this->$field = $value;
					}
				}
			}
		}
	}

}
