<?php
session_start();
// Fetching all values posted from second page and storing it in variable.
 foreach ($_POST as $key => $value) {
 $_SESSION['post'][$key] = $value;
 }
?>

<!DOCTYPE HTML>
<html>
 <head>
 <title>JambulaTV Setup</title>
 <meta name="viewport" content="width=device-width, initial-scale=0.84">
 <link rel="stylesheet" href="css/style.css" />
 </head>
 <body>
 <div class="container">
 <div class="main">
 <h2>4. Free to Air Digital TV</h2><hr/>
 <span id="error">
<?php
// To show error of last form 
if (!empty($_SESSION['error_form_04'])) {
 echo $_SESSION['error_form_04'];
 unset($_SESSION['error_form_04']);
}
?>
 </span>
 <form action="form_06.php" method="post">

 <label>Do you want to setup Live TV Now?</label>
<p>
IMPORTANT: If Yes, please ensure that your JambulaTV comes with a DVB-T tuner pre-installed. Then you must connect the TV Antenna before proceeding!

<br>
 <select name="tvh_dvbt_config_requested" >
 <option value="UG-Kampala">----Select----</options>
 <option value="y">Yes </options>
 <option value="n">No </options>
 </select>

<br>

<hr/>

 <label>TV Market Area :<span>*</span></label>
 <select name="tv_market" >
 <option value="UG-Kampala">----Select----</options>
 <option value="UG-Kampala">Uganda - Kampala </options>
 <option value="KE-Nairobi">Kenya - Nairobi </options>
 </select>

 <label>TV Tuner Name :<span></span></label>
 <select name="dvbt_tuner_name" >
 <option value="Silicon Labs Si2168">----Select----</options>
 <option value="Silicon Labs Si2168">Silicon Labs Si2168 </options>
 <option value="Sony CXD2820R">Sony CXD2820R </options>
 </select>

<hr/>

 <input type="submit" value="Next" />
 </form>
 </div>
 </div>
 </body>
</html>
