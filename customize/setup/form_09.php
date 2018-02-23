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
 <h2>8. News, Business and Sports Headlines</h2><hr/>
 <span id="error">
<?php
// To show error of last form 
if (!empty($_SESSION['error_form_08'])) {
 echo $_SESSION['error_form_08'];
 unset($_SESSION['error_form_08']);
}

// Extract Array
 extract($_SESSION['post']); // Function to extract array.

// Set to '1' if checked else '0'
$cctv_whatsapp = (isset($_POST['cctv_whatsapp'])) ? 1 : 0;
$cctv_telegram = (isset($_POST['cctv_telegram'])) ? 1 : 0;
$cctv_email = (isset($_POST['cctv_email'])) ? 1 : 0;
$cctv_kodi = (isset($_POST['cctv_kodi'])) ? 1 : 0;
$cctv_osd = (isset($_POST['cctv_osd'])) ? 1 : 0;
$cctv_call = (isset($_POST['cctv_call'])) ? 1 : 0;
$cctv_lights = (isset($_POST['cctv_lights'])) ? 1 : 0;

// Add CCTV settings - Notifications
 $cctv_settings_file=".cctv-settings.txt";

 $file=fopen($cctv_settings_file,"w");
 fwrite($file,"CCTV_ALL=$cctv_all # Must be set to 1 if you want any alert below to work\nCCTV_WHATSAPP=$cctv_whatsapp\nCCTV_TELEGRAM=$cctv_telegram\nCCTV_EMAIL=$cctv_email\nCCTV_KODI=$cctv_kodi\nCCTV_OSD=$cctv_osd\nCCTV_CALL=$cctv_call\nCCTV_LIGHTS=$cctv_lights");
 fclose($file);
?>

 </span>
 <form action="form_10.php" method="post">

 <label>Choose the source(s) of political, business and sports news headlines that you want to use:</label>
<br>
 <br><input type="checkbox" name="newssource[]" value="bbc_world">BBC World 
 <br><input type="checkbox" name="newssource[]" value="daily_monitor_ug">Daily Monitor (Uganda)
 <br><input type="checkbox" name="newssource[]" value="observer_ug">The Observer (Uganda)
 <br><input type="checkbox" name="newssource[]" value="chimpreports_ug">Chimp Reports (Uganda)
 <br><input type="checkbox" name="newssource[]" value="allafrica">All Africa 
<p>
<hr>

 <h4></h4>
<hr/>

 <h4></h4>
<hr/>

 <input type="submit" value="Next" />
 </form>
 </div>
 </div>
 </body>
</html>
