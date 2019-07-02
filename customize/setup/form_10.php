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
 <h2>9. On-line Services</h2><hr/>
 <span id="error">

<?php
// To show error of last form 
if (!empty($_SESSION['error_form_09'])) {
 echo $_SESSION['error_form_09'];
 unset($_SESSION['error_form_09']);
}

// extract($_SESSION['post']); // Function to extract array.

// Choose what news sources checkbox user selected
 foreach ($_POST['newssource'] as $_newssourceValue)
     {
         $checksub[] = $_newssourceValue;
     }   $news_sources = implode(',', $checksub);

?>

 </span>
 <form action="form_50.php" method="post">

 <h4>Youtube</h4>
While optional, we recommend that you setup your very own Youtube API credentials, as this will prevent you from running into Usage limits when playing content from Youtube.  Its Free!  <p>To setup your own Youtube API, make sure you have a gmail account and then visit:  <br><a href="https://console.developers.google.com/apis/api/youtube/" target="_blank">Google APIs</a> 
<p>
 <label>Youtube API Key :</label><br />
 <input name="youtube_api_key" id="youtube_api_key" type="text" value="" >
 <label>Youtube Client ID :</label><br />
 <input name="youtube_client_id" id="youtube_client_id" type="text" value="" >
 <label>Youtube Client Secret :</label><br />
 <input name="youtube_client_secret" id="youtube_client_secret" type="text" value="" >

<hr/>

 <h4>Weather</h4>
In order for JambulaTV to generate weather forecast reports for you, please add the following API keys: 

<p>
 <label><a href="https://www.wunderground.com/weather/api" target="_blank">Weather Underground</a> API Key :</label><br />
 <input name="wunderground_api_key" id="wunderground_api_key" type="text" value="" >

 <label><a href="https://openweathermap.org/api" target="_blank">OpenWeatherMap</a> API Key :</label><br />
 <input name="openweathermap_api_key" id="openweathermap_api_key" type="text" value="" >

<hr/>

 <h4>Location</h4>
For precise and reliable weather forecasts, please add your geolocation.  You can easily lookup your town's coordinates using:  <br><a href="https://gps-coordinates.org/my-location.php" target="_blank">GPS Coordinates</a> 
<p>

 <label>Latitude :</label>
 <input name="latitude_home" id="latitude_home" type="text" size="25" required>
 <label>Longitude :</label>
 <input name="longitude_home" id="longitude_home" type="text" size="25" required>

<hr/>

 <h4>Text to Speech (Optional)</h4>
In order to use the text-to-speech services provided by JambulaTV, please register and create one or more API keys with the following providers:
<br>
<br><a href="https://www.ispeech.org/developers" target="_blank">iSpeech TTS</a>
<br><a href="https://console.cloud.google.com/apis/api/texttospeech.googleapis.com" target="_blank">Google TTS</a>
<br><a href="https://cloud.ibm.com/registration" target="_blank">IBM Watson TTS</a>
<p>
 <label>iSpeech TTS | API Key:</label><br />
 <input name="ispeech_tts_api_key" id="ispeech_tts_api_key" type="text" value="" >
 <label>Google TTS | API Key:</label><br />
 <input name="google_tts_api_key" id="google_tts_api_key" type="text" value="" >
 <label>IBM Watson TTS | API Key:</label><br />
 <input name="watson_tts_api_key" id="watson_tts_api_key" type="text" value="" >



<hr/>


 <input name="news_sources" type="hidden" value="<?php echo $news_sources?>">

 <input type="submit" value="Next" />
 </form>
 </div>
 </div>
 </body>
</html>
