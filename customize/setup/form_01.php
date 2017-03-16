<?php
session_start();
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
 <h2>1. Register your JambulaTV!</h2>
 <span id="error">
 <!---- Initializing Session for errors --->
 <?php
 if (!empty($_SESSION['error'])) {
 echo $_SESSION['error'];
 unset($_SESSION['error']);
 }
 ?>
 </span>

 <form action="form_02.php" method="post">
 <label>Full Names :<span>*</span></label>
 <input name="contact_name" type="text" placeholder="e.g James Waliggo" required>
 <label>Email Address :<span>*</span></label>
 <input name="contact_email" type="email" placeholder="e.g. jwaliggo@gmail.com" required>
 <label>Phone Number :<span>*</span></label>
 <input name="contact_phone" type="text" placeholder="e.g. 256772234567" required>
 <label>Birthday :</label>
 <input name="contact_birthday" type="text" placeholder="e.g. 26 May" >
 <label>Address Line1 :<span>*</span></label>
 <input name="contact_address1" id="address1" type="text" size="30" required>
 <label>Address Line2 :</label>
 <input name="contact_address2" id="address2" type="text" size="50">
 <label>City :<span>*</span></label>
 <input name="contact_city" id="city" type="text" size="25" required>
 <label>Country :<span>*</span></label>
 <input name="contact_country" id="country" type="text" size="25" required>

 <hr/>
 <label>System Password: <span>*</span></label>
 <br>
 <br>Please choose a secure password for your JambulaTV
 <input name="system_password" id="txtNewPassword" type="password" placeholder="Enter Password" required/>
 <input name="system_password" id="txtConfirmPassword" type="password" onkeyup="checkPasswordMatch();" placeholder="Confirm Password" required/>
 <div class="registrationFormAlert" id="divCheckPasswordMatch">
 </div>

 <p>

 <input type="submit" value="Next" />
 </form>
 </div>
 </div>

 </body>
</html>
