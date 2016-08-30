<?php
session_start();
 // Fetching all values posted from second page and storing it in variable.
 foreach ($_POST as $key => $value) {
 $_SESSION['post'][$key] = $value;
 }
 // Extract Array
 extract($_SESSION['post']); // Function to extract array.

// Add ISP settings so we can connect to Internet based on device selected
 $internet_settings_file=".internet-settings.txt";
 switch ($internet_device) {

    // 3G/4G Dongle
    case "3_4g_dongle":
    $file=fopen($internet_settings_file,"w");
    fwrite($file,"TYPE='$internet_device'\nISP_NAME='$isp_name'\nUSERNAME=none\nPASSWORD=none\nAPN='$network_apn'");
    fclose($file);
    header("location: form_05.php");
        break;

    // MiFi Router
    case "mifi_router":
    $file=fopen($internet_settings_file,"w");
    fwrite($file,"TYPE='$internet_device'\nISP_NAME='$isp_name'\nSSID='$mifi_ssid'\nSECURITY_KEY='$mifi_pass'");
    fclose($file);
     header("location: form_05.php");
        break;

    // LAN (DHCP)
    case "lan_dhcp":
    $file=fopen($internet_settings_file,"w");
    fwrite($file,"TYPE='$internet_device'\nISP_NAME='$isp_name'");
    fclose($file);
    header("location: form_05.php");
        break;

    // LAN (DHCP)
    case "lan_static":
    $file=fopen($internet_settings_file,"w");
    fwrite($file,"TYPE='$internet_device'\nISP_NAME='$isp_name'");
    fclose($file);
    header("location: form_05.php");
        break;

    // Default
    //default:
    //$file=fopen($internet_settings_file,"w");
    //fwrite($file,"TYPE='$internet_device'\nISP_NAME='$isp_name'");
    //fclose($file);
    //header("location: form_05.php");
    //    break;
}
?>
