<?php

class LocationController extends Controller {
  public function __construct() {

  }

  public function index() {
    $location = new Location($_GET["id"]);
    $this->render("index", $location);
  }
}
