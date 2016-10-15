<?php
class PlanningLocation extends Model {
	static $TABLE_NAME = "t_j_planninglocation_plo";
	protected $_loc_id;
	protected $_plo_datelocation;
	protected $_plo_disponibilite;

	protected $externalClasses = array(
		"plo" => "PlanningLocation",
		"loc" => "Location"
	);

	public static function findAvailable($dateDebut, $dateFin) {
		$st = db()->prepare(
			"select distinct(loc_id)
			from t_j_planninglocation_plo
			where plo_datelocation between '$dateDebut' and '$dateFin'
			and loc_id not in (
				select distinct(loc_id) from t_j_planninglocation_plo
				where plo_disponibilite = false and
				plo_datelocation between '$dateDebut' and '$dateFin'
			);"
		);
		$st->execute();
		$list = array();
		while($row = $st->fetch(PDO::FETCH_ASSOC)) {
			$list[] = $row['loc_id'];
		}
		return $list;
	}

	public static function findDispoLocation($id){
		$st = db()->prepare("select plo_datelocation, plo_disponibilite from t_j_planninglocation_plo where loc_id = :id");
		$st->bindValue(':id',$id);
		$st->execute();
		$list = array();
		while($row = $st->fetch(PDO::FETCH_ASSOC)) {
			$list[$row['plo_datelocation']] = $row['plo_disponibilite'];
		}
		return $list;
	}

}
