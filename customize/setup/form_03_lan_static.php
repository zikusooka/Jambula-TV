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
 <h2>3. Your Local Area Network (Static) Settings</h2><hr/>
 <form action="form_04.php" method="post">

 <label>IP Address :</label><br />
 <input name="lan_ip_addr" id="lan_ip_addr" type="text" value="" >
 <label>IP Gateway :</label><br />
 <input name="lan_ip_gate" id="lan_ip_gate" type="text" value="" >
 <label>DNS Server 1 :</label><br />
 <input name="lan_dns_1" id="lan_dns_1" type="text" value="" >
 <label>DNS Server 2 :</label><br />
 <input name="lan_dns_2" id="lan_dns_2" type="text" value="" >

<p>
<b> Please connect your network cable and ensure that your router is turned on. </b>

<br>

 <input type="submit" value="Next" />
 </form>
 </div>
 </div>
 </body>
</html>
