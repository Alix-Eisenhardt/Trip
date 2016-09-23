<?php
class Abonne extends Model {
	static $TABLE_NAME = "t_e_abonne_abo";
	//Attributs
	protected $_abo_id;
	protected $_abo_pseudo;
	protected $_abo_motdepasse;
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
	protected $_pays;

	//teste si l'attribut' passée en paramètre existe déja dans la table
	public function exists($field,$fieldName) {
		$st = $db()->prepare("SELECT x FROM $TABLE_NAME WHERE $fieldName = :field");
		$st->execute(array())

		$count_pseudo = $query->rowCount();
	}
}