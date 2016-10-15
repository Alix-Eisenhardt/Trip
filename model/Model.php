<?php

// Classe métier générique à accès BD automatique
// ToDo : non duplication des instances de classes liées
// ToDo : modèle hiérarchique

class Model {
	//attend une variable : Soit l'id pour instancier un objet
	// soit un tableau de paramètres pour l'insert dans la base
	//ou l'instanciation d'un objet d'une table de liaison
	//la différence se fait avec le boolean instance

	public function __construct($param,$instance=null) {
		$class = get_called_class();
		$table = $class::getTableName();
		$tableId = substr($table, -3)."_id";
		$property = "_".$tableId;

		if (is_array($param) && is_null($instance)) {
			$sql = "INSERT INTO $table (";
			$sqlCol="";
			$sqlVal="";
			//Tables de liaison : on test si l'id de la table est une propriété de la classe
			// sinon on modifie la composition de la requète en conséquences
			if (property_exists(get_class($this), $property))
				$sqlCol .= $tableId;
			else
				$noIdTable = true;
			foreach ($param as $key => $value) {
				if(isset($noIdTable) && $noIdTable == true) {
					$sqlCol .= $key;
					$sqlVal .= ":".$key;
					/*mis a false pour que cela n'affecte qu'une ligne du foreach
					  mais la variable sert pour d'autres tests*/
					$noIdTable = false;
				} else {
					$sqlCol .= ",".$key;
					$sqlVal .= ",:".$key;
				}
			}
			$sql .= $sqlCol.") VALUES (";
			if(!isset($noIdTable))
				$sql .= "DEFAULT";
			$sql .= $sqlVal.")";
			if(!isset($noIdTable))
				$sql .=" RETURNING $tableId;";
			else
				$sql .=";";
			$st = db()->prepare($sql);

			foreach ($param as $key => $value) {
				$st->bindValue(':'.$key,$value);
			}
			$st->execute();
			if(!isset($noIdTable)) {
				$row = $st->fetch();
				$this->$tableId = $row[$tableId];
				foreach ($param as $key => $value) {
					$this->$key = $value;
				}
			}
		} else {
			$property = "_".$tableId;
			//si la classe à un id propre
			if(property_exists(get_class($this), $property)) {
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
				//sinon on instancie un objet de Table de liaison
				//param doit alors contenir les composantes de la clé étrangère
			} else {
				$sql = "SELECT * FROM $table WHERE ";
				$last_key = key(array_slice($param,-1,1,TRUE));
				foreach ($param as $key => $value) {
					$sql .= "$key = :$key ";
					if(!($key == $last_key))
						$sql .= "AND ";
				}
				$st = db()->prepare($sql);
				$st->execute($param);
				$row = $st->fetch(PDO::FETCH_ASSOC);
				foreach ($row as $field => $value) {
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
		$varName = "_".$fieldName;
		if ($value != null) {
			if (property_exists(get_class($this), $varName)) {
				$this->$varName = $value;
				$class = get_class($this);
				$table = $this->TABLE_NAME;
				$tableId = substr($table, -3)."_id";
				$classId = "_".$tableId;
				//Si la Table n'as pas d'id propre il s'agit d'une table de liaison
				//on ne gere pas encore le cas ou il faudrait mettre a jour les données
				// dans ces tables
				if(property_exists(get_class($this), $classId)) {
					$st = db()->prepare("update $table set $fieldName=:val where $tableId=:id");
					$st->bindValue(":val", $value);
					$id = $tableId;
					$st->bindValue(":id", $this->$id);
					$st->execute();
				}
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
