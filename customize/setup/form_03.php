<?php
session_start();
// Fetching all values posted from second page and storing it in variable.
 foreach ($_POST as $key => $value) {
 $_SESSION['post'][$key] = $value;
 }

 // Extract Array
 extract($_SESSION['post']); // Function to extract array.

 // Create WiFi devices file 
 $wifi_devices_file='.wifi_devices.txt';
 $file=fopen($wifi_devices_file,"w");
 fwrite($file,"$mac_addresses");
 fclose($file);

 // Redirect to Internet connection configuration page based on device selected
 switch ($internet_device) {

    // 3G/4G Dongle
    case "3_4g_dongle":
    header("location: form_03_3_4g.php");
        break;

    // MiFi Router
    case "mifi_router":
    header("location: form_03_mifi_router.php");
        break;

    // LAN (DHCP)
    case "lan_dhcp":
    header("location: form_03_lan_dhcp.php");
        break;

    // LAN (DHCP)
    case "lan_static":
    header("location: form_03_lan_static.php");
        break;

    // Default
    //default:
    //header("location: form_03_a.php");
    //    break;
}
?>
