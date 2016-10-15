<?php

class PeriodeTarif extends Model {
	static $TABLE_NAME = "t_r_periodetarif_pet";
	protected $_pet_id;
	protected $_pet_intitule;
	protected $_pet_datedeb;
	protected $_pet_datefin;

	protected $externalClasses = array(
		"pet" => "PeriodeTarif"
	);

	public static function findBySelection($date_deb, $date_fin) {
		if($date_deb == null)
			return array(new PeriodeTarif(1));
		$table = PeriodeTarif::getTableName();
		// Il peut y avoir des résultats entre plusieurs périodes.
		$st = db()->prepare("SELECT * FROM $table WHERE
							(pet_datedeb < :date_deb and pet_datefin > :date_deb)
							or (pet_datedeb < :date_fin and pet_datefin > :date_fin)
							");
		$st->bindValue(":date_deb", $date_deb);
		$st->bindValue(":date_fin", $date_fin);
		$st->execute();
		$list = array();

		while($row = $st->fetch(PDO::FETCH_ASSOC)) {
			$list[] = new PeriodeTarif($row['pet_id']);
		}
		return $list;
	}
}
