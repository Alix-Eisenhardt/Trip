<?php
$db = new PDO("pgsql:host=srv-prj; dbname=info244", "info244", "qY1tgJ");

function db() {
	global $db;
	return $db;
}
