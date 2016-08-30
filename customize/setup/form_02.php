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
 <h2>2. Setup Internet Access for your JambulaTV</h2><hr/>
 <span id="error">
<?php
// To show error of last form
if (!empty($_SESSION['error_form_02'])) {
 echo $_SESSION['error_form_02'];
 unset($_SESSION['error_form_02']);
}
?>
 </span>
 <form action="form_03.php" method="post">
 <label>Name of Internet Service Provider :<span>*</span></label>
 <input name="isp_name" id="isp_name" type="text" value="" required>

 <label>Type of Internet Connection Device :<span>*</span></label>
 <select name="internet_device" required>
 <option value="">----Select----</options>
 <option value="3_4g_dongle" value="">3G or 4G Dongle </options>
 <option value="mifi_router" value="">Wireless Router (MiFi) </options>
 <option value="lan_dhcp" value="">Local Area Network (DHCP) </options>
 <option value="lan_static" value="">Local Area Network (Static) </options>
 </select>

<hr></hr>
<p>

 <label>Enter device Nickname and MAC Addresses of your Wireless devices :</label>
 
   <table style="width: 100%;" border="0"><tbody>
<!-- Row 1 -->
     <tr>
       <td style="width: 25%;"><input name="wifi_nickname_1" id="wifi_nickname_1" type="text" placeholder="e.g. Jenny"></td>
       <td><input name="wifi_mac_1" id="wifi_mac_1" type="text" placeholder="e.g. 00:23:GD:YY:98:11"></td>
     </tr>
<!-- Row 2 -->
     <tr>
       <td style="width: 25%;"><input name="wifi_nickname_2" id="wifi_nickname_2" type="text" placeholder="e.g. Jenny"></td>
       <td><input name="wifi_mac_2" id="wifi_mac_2" type="text" placeholder="e.g. 00:23:GD:YY:98:11"></td>
     </tr>
<!-- Row 3 -->
     <tr>
       <td style="width: 25%;"><input name="wifi_nickname_3" id="wifi_nickname_3" type="text" placeholder="e.g. Jenny"></td>
       <td><input name="wifi_mac_3" id="wifi_mac_3" type="text" placeholder="e.g. 00:23:GD:YY:98:11"></td>
     </tr>
<!-- Row 4 -->
     <tr>
       <td style="width: 25%;"><input name="wifi_nickname_4" id="wifi_nickname_4" type="text" placeholder="e.g. Jenny"></td>
       <td><input name="wifi_mac_4" id="wifi_mac_4" type="text" placeholder="e.g. 00:23:GD:YY:98:11"></td>
     </tr>
<!-- Row 5 -->
     <tr>
       <td style="width: 25%;"><input name="wifi_nickname_5" id="wifi_nickname_5" type="text" placeholder="e.g. Jenny"></td>
       <td><input name="wifi_mac_5" id="wifi_mac_5" type="text" placeholder="e.g. 00:23:GD:YY:98:11"></td>
     </tr>
   </tbody></table>

   <p>

 <input type="submit" value="Next" />
 </form>
 </div>
 </div>
 </body>
</html>
