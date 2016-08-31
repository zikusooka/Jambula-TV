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
 <br>
 <img src="images/jambula.png" alt="JambulaTV" style="width:100%">
 <br>
 <?php

 session_start();
 foreach ($_POST as $key => $value) {
 $_SESSION['post'][$key] = $value;
 } 
 extract($_SESSION['post']); // Function to extract array.

 // Initialize variables for pages that are skipped i.e. Internet device settings
 $network_apn = !empty($_POST['network_apn']) ? $_POST['network_apn'] : '';
 $mifi_ssid = !empty($_POST['mifi_ssid']) ? $_POST['mifi_ssid'] : '';
 $mifi_pass = !empty($_POST['mifi_pass']) ? $_POST['mifi_pass'] : '';
 $lan_ip_addr = !empty($_POST['lan_ip_addr']) ? $_POST['lan_ip_addr'] : '';
 $lan_ip_gate = !empty($_POST['lan_ip_gate']) ? $_POST['lan_ip_gate'] : '';
 $lan_dns_1 = !empty($_POST['lan_dns_1']) ? $_POST['lan_dns_1'] : '';
 $lan_dns_2 = !empty($_POST['lan_dns_2']) ? $_POST['lan_dns_2'] : '';

 // Connect to our MySQL Database
 $connection = mysql_connect("localhost", "JAMBULATV_SETUP_DB_USER", "JAMBULATV_SETUP_DB_PASS");
 $db = mysql_select_db("JAMBULATV_SETUP_DB_NAME", $connection); // Storing values in database.
 $query = mysql_query("insert into setup (contact_name, contact_email, contact_phone, contact_birthday, contact_address1, contact_address2, contact_city, contact_country, isp_name, internet_device, wifi_nickname_1, wifi_mac_1, wifi_nickname_2, wifi_mac_2, wifi_nickname_3, wifi_mac_3, wifi_nickname_4, wifi_mac_4, wifi_nickname_5, wifi_mac_5, network_apn, mifi_ssid, mifi_pass, lan_ip_addr, lan_ip_gate, lan_dns_1, lan_dns_2, schedule_tvseries, schedule_podcasts, schedule_movies, traktv_username, traktv_watchlist, telegram_bot_id, telegram_chat_id, telegram_username, whatsapp_no_recipient, whatsapp_no_sender, notification_email_address, gmail_address, gmail_password) values('$contact_name', '$contact_email', '$contact_phone', '$contact_birthday', '$contact_address1', '$contact_address2', '$contact_city', '$contact_country', '$isp_name', '$internet_device', '$wifi_nickname_1', '$wifi_mac_1', '$wifi_nickname_2', '$wifi_mac_2', '$wifi_nickname_3', '$wifi_mac_3', '$wifi_nickname_4', '$wifi_mac_4', '$wifi_nickname_5', '$wifi_mac_5', '$network_apn', '$mifi_ssid', '$mifi_pass', '$lan_ip_addr', '$lan_ip_gate', '$lan_dns_1', '$lan_dns_2', '$schedule_tvseries', '$schedule_podcasts', '$schedule_movies', '$traktv_username', '$traktv_watchlist', '$telegram_bot_id', '$telegram_chat_id', '$telegram_username', '$whatsapp_no_recipient', '$whatsapp_no_sender', '$notification_email_address', '$gmail_address', '$gmail_password')", $connection);

 if ($query) {
 // Create file to indicate setup was completed
 $fname=".initial-setup-completed";
 $file=fopen($fname,"w");
 fwrite($file,"Setup Done");
 fclose($file);
 // Post-Setup Links
 echo '<b>';
 echo '<p><span id="success">Thank you for completing setup!</span></p>';

 echo '<p>
   <table style="width: 100%;" border="0" cellpadding="5"><tbody>

     <tr>
       <td style="width: 25%;"><img style="width: 100%;" src="images/ebook.png" alt="Online Manual"></td>
       <td>Please read the <a href="jambulatv-manual.pdf" target="_blank">On-line Manual </a>to get started with your JambulaTV.</td>
     </tr>
   </tbody></table>
 </p>';


 echo '<p>
   <table style="width: 100%;" border="0" cellpadding="5"><tbody>

     <tr>
       <td style="width: 25%;"><img style="width: 100%;" src="images/remote.jpg" alt="Remote app"></td>
       <td>Download the Remote App and install it on your phone as follows:</td>
     </tr>
   </tbody></table>
 </p>';

 echo '<p>
   <table style="width: 100%;" border="0" cellpadding="5"><tbody>
     <tr>
       <td style="width: 25%;"><img style="width: 100%;" src="images/android.png" alt="Android"></td>
       <td><a href="https://play.google.com/store/apps/details?id=org.leetzone.android.yatsewidgetfree">Android</a></td>
     </tr>
     <tr>
       <td style="width: 25%;"><img style="width: 100%;" src="images/ios.png" alt="iOS"></td>
       <td><a href="https://itunes.apple.com/en/app/official-kodi-remote/id520480364?mt=8">iOS</a></td>
     </tr>
   </tbody></table>
</p>';
 

 echo '</b>';
 } else {
 echo '<p><span>Form Submission Failed..!! Please contact support immediately</span></p>';
 // Contact lines
 echo '<p></p>';
 echo '<a href=mailto:support@jambulatv.com>Email</a> | <a href=tel:+256776338000>Phone Call</a> | <a href=tel:+256776338000>WhatsApp</a>';
 echo '<br>';
 echo '<a href=tel:+256776338000>Telegram</a> | <a href=https://www.facebook.com/JambulaTV>Facebook</a> | <a href=http://support.jambulatv.com>Website</a>';
 } 
 unset($_SESSION['post']); // Destroying session.
 ?>
 </div>
 </div>
 </body>
</html>
