# TripAdvisor

Architecture des classes de modèle :  
```
class MaClasse extends Model {
  protected $TABLE_NAME = "t_machin_nomtable_truc";
  protected $_truc_id;
  ...
  protected $externalClasses = array("truc" => "MaClasse", ...);
```
