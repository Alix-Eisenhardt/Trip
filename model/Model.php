<?php

// Classe métier générique à accès BD automatique
// ToDo : non duplication des instances de classes liées
// ToDo : modèle hiérarchique

class Model {
	//attend une variable : Soit l'id pour instancier un objet
	// soit un tableau de paramètres pour l'insert dans la base
	public function __construct($param) {
		$class = get_called_class();
		$table = $class::getTableName();
		$tableId = substr($table, -3)."_id";

		if (is_array($param)) {
			$sql = "INSERT INTO $table (";
			$sqlCol="";
			$sqlVal="";
			//Classes de liaison : on test si l'id de la table est une propriété de la classe
			// sinon on modifie la composition de la requète en conséquences
			$property = "_".$tableId;
			if (property_exists(get_class($this), $property))
				$sqlCol .= $tableId;
			else {
				$flag1 = true;
				$flag2 = true;
			}
			foreach ($param as $key => $value) {
				if(isset($flag1)) {
					$sqlCol .= $key;
					$sqlVal .= ":".$key;
					unset($flag1);
				} else {
					$sqlCol .= ",".$key;
					$sqlVal .= ",:".$key;
				}
			}
			$sql .= $sqlCol.") VALUES (";
			if(!isset($flag2))
				$sql .= "DEFAULT";
			$sql .= $sqlVal.")";
			if(!isset($flag2))
				$sql .=" RETURNING $tableId;";
			else
				$sql .=";";
			$st = db()->prepare($sql);

			foreach ($param as $key => $value) {
				$st->bindValue(':'.$key,$value);
			}
			$st->execute();
			if(!isset($flag2)) {
				$row = $st->fetch();
				$this->$tableId = $row[$tableId];
				foreach ($param as $key => $value) {
					$this->$key = $value;
				}
			}
			echo $sql;
			print_r(db()->errorInfo());
		} else {
			$id = $param;
			$st = db()->prepare("select * from $table where $tableId=:id");
			$st->bindValue(":id", $id);
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

	public static function getTableName() {
		$class = get_called_class();
		$refClass = new ReflectionClass($class);
		$table = $refClass->getStaticPropertyValue('TABLE_NAME');
		return $table;
	}

	public static function findAll() {
		$class = get_called_class();
		$table = $class::getTableName();
		$tableId = substr($table, -3)."_id";
		$st = db()->prepare("select $tableId from $table order by $tableId");
		$st->execute();
		$list = array();
		while($row = $st->fetch(PDO::FETCH_ASSOC)) {
			$list[] = new $class($row[$tableId]);
		}
		return $list;
	}

	public function __get($fieldName) {
		$varName = "_".$fieldName;
		$className = get_class($this);
		if (property_exists($className, $varName))
			return $this->$varName;
		else if ($fieldName == "TABLE_NAME") {
			$refClass = new ReflectionClass($className);
			$table = $refClass->getStaticPropertyValue('TABLE_NAME');
			return $table;
		}
		else if ($fieldName != "externalClasses")
			throw new Exception("Unknown variable: ".$fieldName);
	}

	public function __set($fieldName, $value) {
		//echo "_set_".$fieldName."<br/>";
		$varName = "_".$fieldName;
		if ($value != null) {
			if (property_exists(get_class($this), $varName)) {
				$this->$varName = $value;
				$class = get_class($this);
				$table = $this->TABLE_NAME;
				$tableId = substr($table, -3)."_id";
				/*$id = "_id".$fieldName;
				if (isset($value->$id)) {
					$st = db()->prepare("update $table set id$fieldName=:val where $tableId=:id");
					$id = substr($id, 1);
					$st->bindValue(":val", $value->$id);
				} else {*/
				$st = db()->prepare("update $table set $fieldName=:val where $tableId=:id");
				$st->bindValue(":val", $value);
				//_}
				$id = $tableId;
				$st->bindValue(":id", $this->$id);
				$st->execute();
			} else {
				throw new Exception("Unknown variable: ".$fieldName);
			}
		}
	}

	public function __toString() {
		return get_class($this);
	}

	public static function getTypeOfColumn(){
		$class = get_called_class();
		$refClass = new ReflectionClass($class);
		$table = $refClass->getStaticPropertyValue('TABLE_NAME');

		$st = db()->prepare("SELECT column_name, udt_name
			from INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = :table ;");
		$st->bindValue(":table", $table);
		$st->execute();
		while($row = $st->fetch(PDO::FETCH_ASSOC)){
			$list[$row["column_name"]] = $row["udt_name"];
		}
		return $list;
	}
}
