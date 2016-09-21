<?php
$db = new PDO("pgsql:host=localhost; dbname=vacances", "vacances");

function db() {
		global $db;
		return $db;
}
