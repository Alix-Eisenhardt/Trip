<?php

class PaysController extends Controller {

	public function allCountry(){
		$data =  Pays::findAll();
	}
}

?>