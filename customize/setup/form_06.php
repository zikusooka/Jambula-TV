<?php
session_start();
 // Fetching all values posted from second page and storing it in variable.
 foreach ($_POST as $key => $value) {
 $_SESSION['post'][$key] = $value;
 }
// Extract Array
 extract($_SESSION['post']); // Function to extract array.

// Add DVB-T2 settings - Whether to configure Live TV
 $dvbt_settings_file=".dvbt-settings.txt";

 $file=fopen($dvbt_settings_file,"w");
 fwrite($file,"TVH_DVBT_CONFIG_REQUESTED=\"$tvh_dvbt_config_requested\"\nTV_MARKET=\"$tv_market\"\nDVBT_TUNER_NAME=\"$dvbt_tuner_name\"");
 fclose($file);
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
 <h2>5. TV Series, Movies, Music, and Podcasts</h2><hr/>
 <span id="error">
<?php
// To show error of last form
if (!empty($_SESSION['error_form_02'])) {
 echo $_SESSION['error_form_02'];
 unset($_SESSION['error_form_02']);
}
?>
 </span>
 <form action="form_07.php" method="post">
 <h4>Content Download Schedule</h4>
 Please enter the most suitable time for downloading content from the Internet.  Please choose a time when you rarely use the Internet e.g. After work hours.   You must enter the time in 24 hour (military) format e.g. 23:30 which is equivalent to 11:30pm.
  <p>
 <label>TV Series :</label>
 <input name="schedule_tvseries" id="schedule_tvseries" type="text" value="23:30" size="15">
 <label>Podcasts :</label>
 <input name="schedule_podcasts" id="schedule_podcasts" type="text" value="0:45" size="15">
 <label>Movies :</label>
 <input name="schedule_movies" id="schedule_movies" type="text" value="2:00" size="15">

<hr></hr>

 <h4>Trakt.tv Account</h4>

Please <a href="https://trakt.tv/auth/join" "target=_blank"> SignUp</a> for a Trakt.tv account.

 <p>
 <label>Username :</label>
 <input name="traktv_username" id="schedule_tvseries" type="text" size="25">
 <label>Watchlist (Create one named JambulaTV) :</label>
 <input name="traktv_watchlist" id="schedule_podcasts" type="text" placeholder="JambulaTV" size="25">




  <p>

 <input type="submit" value="Next" />
 </form>
 </div>
 </div>
 </body>
</html>
