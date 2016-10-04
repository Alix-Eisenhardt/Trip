function surligne(champ, erreur)
{
   if(erreur)
      champ.style.borderColor = "red";
   else
      champ.style.borderColor = "green";
}

function verifChampText(champ)
{
   if(champ.value.length < 1 || champ.value.length > 100)
   {
      surligne(champ, true);
      return false;
   }
   else
   {
      surligne(champ, false);
      return true;
   }
}

function verifChampLongText(champ){
  if(champ.value.length < 1 || champ.value.length > 2000){
    surligne(champ, true);
    return false;
  }else {
    surligne(champ, false);
    return true;
  }
}


function verifChampNum(champ)
{
   var age = parseInt(champ.value);
   if(isNaN(age) || age < 0)
   {
      surligne(champ, true);
      return false;
   }
   else
   {
      surligne(champ, false);
      return true;
   }
}

function verifForm(f){
  var nameOk = verifChampText(f.loc_titre);
  var descrOk = verifChampLongText(f.loc_description);
  var chambreOk = verifChampNum(f.loc_nbchambres);
  var couchagesOk = verifChampNum(f.loc_nbcouchages);
  var sallebainOk = verifChampNum(f.loc_nbsallesbain);
  var occupantsOk = verifChampNum(f.loc_nboccupants);
  var adrOk = verifChampText(f.loc_adrligne1);
  var cpOK = verifChampText(f.loc_cp);
  var villeOk = verifChampText(f.loc_ville);


  if(nameOk && chambreOk && descrOk && couchagesOk && sallebainOk && occupantsOk && adrOk && cpOK && villeOk){
    return true;
  }else {
    alert("Veuillez remplir correctement les champs svp");
    return false;
  }
}
