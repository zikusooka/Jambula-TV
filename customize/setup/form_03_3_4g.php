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
 <h2>3. Your 3G/4G Network Settings</h2><hr/>
 <form action="form_04.php" method="post">

<!-- <h4>Wireless Router (MiFi)</h4> -->

 <label>Access Point Name (APN) :</label><br />
 <input name="network_apn" id="network_apn" type="text" value="" required>
<hr/>

<b> Please connect your 3G/4G device now ... </b>
<br>

 <input type="submit" value="Next" />
 </form>
 </div>
 </div>
 </body>
</html>
