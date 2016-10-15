<?php
class Avis extends Model {
	static $TABLE_NAME = "t_e_avis_avi";
	//Attributs
	protected $_avi_id;
	protected $_abo_id;
	protected $_loc_id;
	protected $_vil_id;
	protected $_per_id;
	protected $_lng_id;
	protected $_avi_nomoccupant;
	protected $_avi_date;
	protected $_avi_titre;
	protected $_avi_detail;
	protected $_avi_noteglobale;
	protected $_avi_recommandationami;
	protected $_avi_reponseavis;

	//Objets
	protected $_abo_obj;
	protected $_loc_obj;
	protected $_vil_obj;
	protected $_per_obj;
	protected $_lng_obj;

	protected $externalClasses = array(
		"avi" => "Avis",
		"abo" => "Abonne",
		"loc" => "Location",
		"vil" => "TypeVisiteLocation",
		"per" => "PeriodeVisite",
		"lng" => "Langue"
	);

	public function __toString() {
		$s = "<div class=\"avis ".$this->lng_obj."\"><h3>".$this->avi_titre."</h3>";
		$s .= "<p>Note : <span class='note'>".$this->avi_noteglobale."</span>/5<br>";
		$s .= $this->avi_detail."<br>";
		$s .= "Le <span class='date'>".$this->avi_date."</span> par <a href=./?r=abonne/showAbonne&id=".$this->abo_id.">";
		$s .= $this->abo_obj->abo_pseudo."</a><br></p>";
		if(!isset($_SESSION['detailavis'])) {
			$path = "./?r=avis/detailAvis&avi_id=".$this->avi_id;
			$s .= "<a class='button' href='$path'>Detail avis</a><br>";
		}
		if(	   (isset($_SESSION['gerant']))
			&& ($this->loc_obj->grt_id == $_SESSION['gerant']->grt_id)
			&& (!isset($_GET['avi_id']))
			&& ($this->avi_reponseavis == "")
		) {
			$path = "./?r=avis/reponse&avi_id=".$this->avi_id;
			$s .= "<a class='button' href='$path'>Répondre</a>";
		}
		else if($this->avi_reponseavis != "") {
			$s .= "<b>Réponse du gérant :</b><br />";
			$s .= $this->avi_reponseavis."<br />";
		}
		$s .= "</div>";

		return $s;
	}
}
