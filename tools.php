<?php

public function pgTypeToPHPTestType($type, $value)
	if(substr($type,0,2) == "int" || $type == "numeric"){
		return is_integer($value);
	else if (substr($type,0,4) == "float")
		return is_double($value);
	else if ($type == "varchar")
		return true;
}

?>