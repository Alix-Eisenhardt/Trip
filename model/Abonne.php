<?php
class Abonne extends Model {
	static $TABLE_NAME = "t_e_abonne_abo";
	//Attributs
	protected $_abo_id;
	protected $_abo_pseudo;
	protected $_abo_motpasse;
	protected $_abo_mel;
	protected $_abo_nom;
	protected $_abo_prenom;
	protected $_abo_adrligne1;
	protected $_abo_adrligne2;
	protected $_abo_cp;
	protected $_abo_ville;
	protected $_abo_etat;
	protected $_pay_id;
	protected $_abo_latitude;
	protected $_abo_longitude;
	protected $_abo_indicatif;
	protected $_abo_tel;
	protected $_abo_aeroport;

	//Objets
	protected $_pay_obj;

	protected $externalClasses = array(
		"abo" => "Abonne",
		"pay"=>"Pays"
	);

	//teste si l'attribut passée en paramètre existe déja dans la table
	public static function avaiable($field,$fieldName) {
		$class = get_called_class();
		$table = $class::getTableName();
		$st = db()->prepare("SELECT * FROM $table WHERE $fieldName = :field");
		$st->execute(array(
			':field' =>$field
		));
		$rowsCpt = $st->rowCount();
		return ($rowsCpt == 0);
	}

	public function __toString() {
		$s = "<div class=\"showAbonne\"><h3>".$this->abo_pseudo."</h3>";
		$s .= $this->abo_nom." ";
		$s .= $this->abo_prenom."<br/>";
		$s .= $this->abo_mel."<br/>";
		$s .= $this->abo_adrligne1."<br/>";
		if (isset($this->abo_adrligne2))
			$s .= $this->abo_adrligne2."<br/>";
		$s .= $this->abo_cp." ";
		$s .= $this->abo_ville."<br/>";
		if (isset($this->abo_etat))
			$s .= $this->abo_etat."<br/>";
		$s .= $this->pay_obj."<br/>";
		$s .= "+".$this->abo_indicatif."";
		$s .= $this->abo_tel."<br/>";
		if (isset($this->abo_aeroport))
			$s .= $this->abo_aeroport."</div>";
		return $s;
	}
}
