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
 <h2>7. CCTV Notifications (Optional)</h2><hr/>
 <span id="error">

<?php
// To show error of last form 
if (!empty($_SESSION['error_form_07'])) {
 echo $_SESSION['error_form_07'];
 unset($_SESSION['error_form_07']);
}
?>

 </span>
 <form action="form_09.php" method="post">

 <label>What method(s) should I use to notify you in the event motion is detected at your camera(s):</label>
<br>
 <br><input type="hidden" name="cctv_all" value="1">
 <br><input type="checkbox" name="cctv_whatsapp" value="1"> WhatsApp
 <br><input type="checkbox" name="cctv_telegram" value="1"> Telegram
 <br><input type="checkbox" name="cctv_email" value="1"> Email
 <br><input type="checkbox" name="cctv_kodi" value="1"> OSD (with picture)
 <br><input type="checkbox" name="cctv_osd" value="1"> OSD (text only)
 <br><input type="checkbox" name="cctv_call" value="1"> Phone Call*
 <br><input type="checkbox" name="cctv_lights" value="1"> Lights*
<p>
<hr>

<em>*Requires additional hardware</em>
 <h4></h4>
<hr/>



 <input type="submit" value="Next" />
 </form>
 </div>
 </div>
 </body>
</html>
