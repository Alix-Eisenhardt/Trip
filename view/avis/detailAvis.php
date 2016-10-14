<?php
global $data;
echo $data['avis'];
if(!empty($data['questions']))
{
	echo "<h4>Reponses aux questions facultatives </h4>";
	foreach ($data['questions'] as $key => $value) {
		echo $value;
	}
}

echo "<script type=\"text/javascript\" src='view/location/showImages.js'></script>";

$photos = Photo::findByAvi_id($data['avis']->avi_id);

foreach ($photos as $photo) {
		echo "<div class='photo'>";
		echo "<img src='".$photo->pho_url."'></img>";
		echo "</div>";
}


