<!DOCTYPE HTML>
<html>
 <head>
 <title>JambulaTV Setup</title>
 <meta name="viewport" content="width=device-width, initial-scale=0.84">
 <link rel="stylesheet" href="style.css" />
 </head>
 <body>
 <div class="container">
 <div class="main">
 <h2>Setup completed</h2>
 <?php

 session_start();
 foreach ($_POST as $key => $value) {
 $_SESSION['post'][$key] = $value;
 } 

 echo '<p><span id="success">Thank you for completing setup.  Enjoy!</span></p>';
 echo '<p>Please download the Remote App as follows</p>';
 echo '<p><a href="https://play.google.com/store/apps/details?id=org.leetzone.android.yatsewidgetfree">Android</a></p>';
 echo '<p><a href="https://itunes.apple.com/en/app/official-kodi-remote/id520480364?mt=8">iOS</a></p>';

 ?>
 </div>
 </div>
 </body>
</html>
