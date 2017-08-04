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
 <h2>7. News, Business and Sports Headlines</h2><hr/>
 <span id="error">
<?php
// To show error of last form 
if (!empty($_SESSION['error_form_04'])) {
 echo $_SESSION['error_form_04'];
 unset($_SESSION['error_form_04']);
}
?>
 </span>
 <form action="form_50.php" method="post">

 <label>Choose the source(s) of political, business and sports news headlines that you want to use:</label>
<br>
 <br><input type="checkbox" name="newssource[]" value="bbc_world">BBC World 
 <br><input type="checkbox" name="newssource[]" value="daily_monitor_ug">Daily Monitor (Uganda)
 <br><input type="checkbox" name="newssource[]" value="observer_ug">The Observer (Uganda)
 <br><input type="checkbox" name="newssource[]" value="chimpreports_ug">Chimp Reports (Uganda)
 <br><input type="checkbox" name="newssource[]" value="allafrica">All Africa 
<p>
<hr>

 <h4></h4>
<hr/>

 <h4></h4>
<hr/>

 <input type="submit" value="Next" />
 </form>
 </div>
 </div>
 </body>
</html>
