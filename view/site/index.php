<form action="?r=location/search" method="post"  onsubmit="return checkDates()">
	<p>
	<label for="ville">Ville : </label>
	<input type="text" id="ville" name="ville" required/>
	</p>
	<p>
	<label for="date_debut">Date début : </label>
	<input type="date" id="date_debut" name="date_debut"/>
	</p>
	<label for="date_fin">Date fin : </label>
	<input type="date" id="date_fin" name="date_fin"/>
	<p>
	<button type="submit" id="button">Chercher</button>
	</p>
</form>
<script type="text/javascript" src='view/tools.js'></script>
