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
 <h2>6. Messaging clients used for your Notifications</h2><hr/>
 <span id="error">
<?php
// To show error of last form 
if (!empty($_SESSION['error_form_06'])) {
 echo $_SESSION['error_form_06'];
 unset($_SESSION['error_form_06']);
}
?>
 </span>
 <form action="form_08.php" method="post">

 <label>What client(s) should I use to notify you :</label>
 <br><input type="radio" name="telegram" value="telegram">Telegram
 <br><input type="radio" name="whatsapp" value="whatsapp">WhatsApp
 <br><input type="radio" name="email" value="email">Email

<hr/>

 <h4>Telegram</h4>
To setup your telegram bot, please start <a href="tg://resolve?domain=botfather" target="_blank">Botfather</a> 
<p>
 <label>Telegram API Bot ID :</label><br />
 <input name="telegram_bot_id" id="telegram_bot_id" type="text" value="" >
 <label>Telegram API Chat ID :</label><br />
 <input name="telegram_chat_id" id="telegram_chat_id" type="text" value="" >
 <label>Telegram API Username (Optional) :</label><br />
 <input name="telegram_username" id="telegram_username" type="text" value="" >

<hr/>

 <h4>WhatsApp</h4>

 <label>WhatsApp Number for Receiving :</label><br />
 <input name="whatsapp_no_recipient" id="whatsapp_no_recipient" type="text" value="" >
 <label>WhatsApp Number for Sending :</label><br />
 <input name="whatsapp_no_sender" id="whatsapp_no_sender" type="text" value="" >

<hr/>

 <h4>Email</h4>

 <label>Email Address :</label><br />
 <input name="notification_email_address" id="notification_email_address" type="text" value="" >

</hr>
 <p><b>IMPORTANT:</b>In order for email to work, you will need a Google services account.  This can be another GMail account different from your primary one.  For this purpose, it is recommended that you <a href="https://accounts.google.com/SignUp?service=mail" target="_blank">create a new account</a></p>
 <label>GMail Address :</label><br />
 <input name="gmail_address" id="gmail_address" type="text" value="" >
 <label>GMail Password :</label><br />
 <input name="gmail_password" id="txtNewPassword" type="password" placeholder="Enter Password" required/>
 <input name="gmail_password" id="txtConfirmPassword" type="password" onkeyup="checkPasswordMatch();" placeholder="Confirm Password" required/>
 <div class="registrationFormAlert" id="divCheckPasswordMatch">
 </div>

<hr/>

 <input type="submit" value="Next" />
 </form>
 </div>
 </div>
 </body>
</html>
