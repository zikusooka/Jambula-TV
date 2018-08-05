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

<!-- Check to see if passwords match-->
 <script src="jquery.min.js"></script>
 <script>
$(document).ready(function () {
   $("#txtConfirmPassword").keyup(checkPasswordMatch);
});
function checkPasswordMatch() {
    var password = $("#txtNewPassword").val();
    var confirmPassword = $("#txtConfirmPassword").val();

    if (password != confirmPassword)
        $("#divCheckPasswordMatch").html("Passwords do not match!");
    else
        $("#divCheckPasswordMatch").html("Passwords match.");
}
 </script>
 </head>

 <body>
 <div class="container">
 <div class="main">
 <h2>3. Your Wireless Router (MiFi) Settings</h2><hr/>
 <form action="form_04.php" method="post">

<!-- <h4>Wireless Router (MiFi)</h4> -->

 <label>WiFi SSID Name :</label><br />
 <input name="mifi_ssid" id="mifi_ssid" type="text" value="" required>
 <label>WiFi Password :</label><br />
 <input name="mifi_pass" id="txtNewPassword" type="password" placeholder="Enter Password" required/>
 <input name="mifi_pass" id="txtConfirmPassword" type="password" onkeyup="checkPasswordMatch();" placeholder="Confirm Password" required/>
 <div class="registrationFormAlert" id="divCheckPasswordMatch">
 </div>

<hr/>

 <h4>Router Web Management Access</h4>
 Please enter the IP Address, Admin username, and password of your wireless router.
These credentials will be used to login and query your MiFi for battery levels, data balances, and perform several other tasks.
  <p>

 <label>IP Address :</label><br />
 <input name="mifi_ip_address" id="mifi_ip_address" type="text" value="" required>
 <label>Admin Username :</label><br />
 <input name="mifi_admin_user" id="mifi_admin_user" type="text" value="" required>
 <label>Admin Password :</label><br />
 <input name="mifi_admin_pass" id="txtNewPassword" type="password" placeholder="Enter Password" required/>
 <input name="mifi_admin_pass" id="txtConfirmPassword" type="password" onkeyup="checkPasswordMatch();" placeholder="Confirm Password" required/>
 <div class="registrationFormAlert" id="divCheckPasswordMatch">
 </div>

<hr/>

<b> Please turn on your MiFi device now ... </b>
<br>

 <input type="submit" value="Next" />
 </form>
 </div>
 </div>
 </body>
</html>
