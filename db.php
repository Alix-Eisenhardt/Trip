<?php
$db = new PDO("pgsql:host=localhost; dbname=info244", "info244", "qY1tgJ");

function db() {
		global $db;
		return $db;
}
