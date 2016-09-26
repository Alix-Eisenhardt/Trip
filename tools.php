<?php

public function pgTypeToPHPTestType($type, $value)
	if(substr($type,0,3) == "int" || $type == "numeric"){
		return is_integer($value);
	else if (substr($type,0,5) == "float")
		return is_double($value);
	else if ($type == "varchar")
		return true;
}

public function pgTypeToPHPTestType($type, $value)
	if(substr($type,0,3) == "int" || $type == "numeric" || substr($type,0,5) == "float")
		echo "number";
	else
		echo "text";
}

?>
