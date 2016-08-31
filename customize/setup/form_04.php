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
    fwrite($file,"TYPE='$internet_device'\nISP_NAME='$isp_name'\nWIFI_SSID='$mifi_ssid'\nWIFI_SECURITY_KEY='$mifi_pass'");
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

    // LAN (STATIC)
    case "lan_static":
    $file=fopen($internet_settings_file,"w");
    fwrite($file,"TYPE='$internet_device'\nISP_NAME='$isp_name'\nNETWORK_IP_ADDRESS='$lan_ip_addr'\nNETWORK_GATEWAY_ADDRESS='$lan_ip_gate'\nNETWORK_DNS_1='$lan_dns_1'\nNETWORK_DNS_2='$lan_dns_2'");
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
