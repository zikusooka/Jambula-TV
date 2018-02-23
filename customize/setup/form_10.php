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
 <h2>9. Service APIs (Optional)</h2><hr/>
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

 <h4>Google Youtube API</h4>
While optional, we recommend that you setup your very own Youtube API credentials, as this will prevent you from running into Usage limits when playing content from Youtube.  Its Free!  <p>To setup your own Youtube API, make sure you have a gmail account and then visit:  <a href="https://console.developers.google.com/apis/" target="_blank">Google APIs</a> 
<p>
 <label>Youtube API Key :</label><br />
 <input name="youtube_api_key" id="youtube_api_key" type="text" value="" >
 <label>Youtube Client ID :</label><br />
 <input name="youtube_client_id" id="youtube_client_id" type="text" value="" >
 <label>Youtube Client Secret :</label><br />
 <input name="youtube_client_secret" id="youtube_client_secret" type="text" value="" >

<hr/>

 <h4>Darksky Weather API</h4>
To setup a darksky.net API key for weather reports, please visit:  <a href="https://darksky.net" target="_blank">DarkSky</a> 
<p>
 <label>DarkSky API Key :</label><br />
 <input name="darksky_api_key" id="darksky_api_key" type="text" value="" >

<hr/>

 <input name="news_sources" type="hidden" value="<?php echo $news_sources?>">

 <input type="submit" value="Next" />
 </form>
 </div>
 </div>
 </body>
</html>
