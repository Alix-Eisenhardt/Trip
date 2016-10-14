<?php

class Photo extends Model {
	static $TABLE_NAME = "t_e_photo_pho";
	protected $_pho_id;
	protected $_loc_id;
	protected $_avi_id;
	protected $_pho_url;

	protected $_loc_obj;
	protected $_avi_obj;

	protected $externalClasses = array(
		"pho" => "Photo",
		"avi" => "Avis",
		"loc" => "Location"
		);

	public static function Photo_Seq_Nextval() {
		$st = db()->prepare("SELECT last_value from  t_e_photo_pho_pho_id_seq");
		$st->execute();
		$row = $st->fetch(PDO::FETCH_ASSOC);
		return $row['last_value'];
	}

	public static function findByAvi_id($avi_id) {
		$table = Photo::getTableName();

		$st = db()->prepare("SELECT * FROM $table WHERE avi_id = :avi_id");
		$st->bindValue(":avi_id", $avi_id);
		$st->execute();

		$list = array();

		while($row = $st->fetch(PDO::FETCH_ASSOC)) {
			$list[] = new Photo($row['pho_id']);
		}
		return $list;
	}

	//type ajout prend les valeurs loc_id ou avi_id
	public static function ajoutImage($type_ajout,$val_type) {
		if(!empty($_FILES['photo']['name'])) {
          //1mo 1048576
          //500ko = 524288
			$maxsize = 524288;

          //test ext
			$extensions_valides = array( 'jpg' , 'jpeg' , 'gif' , 'png' );
			$extension_upload = strtolower(  substr(  strrchr($_FILES['photo']['name'], '.')  ,1)  );
			if ( in_array($extension_upload,$extensions_valides) ) {
            //test err
				if ($_FILES['photo']['error'] == 0) {
              //test taille
					if ($_FILES['photo']['size'] < $maxsize) {
						$uploaddir = './images/';
						$nom = "img";
                //on récupère le numéro suivant de la séquence de la table photo pour créer un identifiant a la photo
						$id = Photo::Photo_Seq_Nextval() + 1;
						$nom .= $id;
						$nom .= ".".$extension_upload;
						$uploadfile = $uploaddir . $nom;

                //on déplace l'image
						$res = move_uploaded_file($_FILES['photo']['tmp_name'], $uploadfile);
                //si ça a marché on insère en base
						if ($res) {
							$param = array(
								$type_ajout => $val_type,
								"pho_url"=> substr($uploadfile,2)
								);
							$photo = new Photo($param);
						} else {
							$erreur = "Erreur lors du transfert";
						}
					} else {
						$erreur = "Le fichier est trop gros, taille limite : 500ko";
					}
				} else {
					$erreur = "Erreur lors du transfert, problème du serveur<br>Nous nous excusons pour le désagrément";
				}
			} else {
				$erreur = "Type de fichier non valide, types autorisés : .jpeg, .jpg, .gif, .png";
			}
		} else {
			$erreur = "Veuillez insérer une image";
		}
		if(isset($erreur))
			return $erreur;
		else
			return true;
	}
}