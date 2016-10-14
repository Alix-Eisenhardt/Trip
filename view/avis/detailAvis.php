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

