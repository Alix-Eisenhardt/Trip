<?php

// Classe métier générique à accès BD automatique
// ToDo : non duplication des instances de classes liées
// ToDo : modèle hiérarchique

class Model {
	public function __construct($id=null) {
		$class = get_class($this);
		$table = $this->TABLE_NAME;
		if ($id == null) {
			$st = db()->prepare("insert into $table default values returning $tableId");
			$st->execute();
			$row = $st->fetch();
			$field = substr($table, -3)."_id";
			$this->$field = $row[$field];
		} else {
			$tableId = substr($table, -3)."_ID";
			$st = db()->prepare("select * from $table where $tableId=:id");
			$st->bindValue(":id", $id);
			$st->execute();
			if ($st->rowCount() != 1) {
				throw new Exception("Not in table: ".$table." id: ".$id );
			} else {
				$row = $st->fetch(PDO::FETCH_ASSOC);
				foreach($row as $field=>$value) {
					if (substr($field, 0,2) == "id") {
						/*$linkedField = substr($field, 2);
						$linkedClass = ucfirst($linkedField);
						if ($linkedClass != get_class($this))
							$this->$linkedField = new $linkedClass($value);
						else
							$this->$field = $value;*/
					} else
						$this->$field = $value;
				}
			}
		}
	}

	public static function findAll() {
		$class = get_called_class();
		$refClass = new ReflectionClass($class);
		$table = $refClass->getStaticPropertyValue('TABLE_NAME');
		$tableId = substr($table, -3)."_id";
		$st = db()->prepare("select $tableId from $table");
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
		else
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
		return get_class($this).": ".$this->name;
	}
}
