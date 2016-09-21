<?php
error_reporting(E_ALL | E_STRICT);
ini_set('display_errors', true);

function loadClass($class) {
		$dir = "model";
		if (strpos($class,"Controller") !== FALSE)
				$dir = "controller";
		include_once "$dir/$class.php";
}

spl_autoload_register('loadClass');
