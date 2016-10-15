# TripAdvisor

Architecture des classes de modèle :  
```
class MaClasse extends Model {
	protected $TABLE_NAME = "t_machin_nomtable_truc";
	protected $_truc_id;
	...

	protected $_bidule_obj;
	...

	protected $externalClasses = array(
		"truc" => "MaClasse",
		"bidule" => "AutreClasse",
		...
	);
```

Il paraît qu'Andy Davidson et Hideo Kojima se sont rencontrés.
