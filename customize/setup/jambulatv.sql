-- -----------------------------------
-- Host: localhost Database: jambulatv
-- -----------------------------------
DROP TABLE IF EXISTS setup;
CREATE TABLE setup (
id INT(3) NOT NULL AUTO_INCREMENT,
contact_name VARCHAR(255) NOT NULL,
contact_email VARCHAR(255) NOT NULL,
contact_phone BIGINT(15) NOT NULL,
contact_birthday VARCHAR(255) NOT NULL,
contact_address1 VARCHAR(255) NOT NULL,
contact_address2 VARCHAR(255) NOT NULL,
contact_city VARCHAR(255) NOT NULL,
contact_country VARCHAR(255) NOT NULL,
system_password VARCHAR(255) NOT NULL,
isp_name VARCHAR(255) NOT NULL,
internet_device VARCHAR(255) NOT NULL,
wifi_nickname_1 VARCHAR(255) NOT NULL,
wifi_mac_1 VARCHAR(255) NOT NULL,
wifi_nickname_2 VARCHAR(255) NOT NULL,
wifi_mac_2 VARCHAR(255) NOT NULL,
wifi_nickname_3 VARCHAR(255) NOT NULL,
wifi_mac_3 VARCHAR(255) NOT NULL,
wifi_nickname_4 VARCHAR(255) NOT NULL,
wifi_mac_4 VARCHAR(255) NOT NULL,
wifi_nickname_5 VARCHAR(255) NOT NULL,
wifi_mac_5 VARCHAR(255) NOT NULL,
network_apn VARCHAR(255) NOT NULL,
mifi_ssid VARCHAR(255) NOT NULL,
mifi_pass VARCHAR(255) NOT NULL,
mifi_ip_address VARCHAR(255) NOT NULL,
mifi_admin_user VARCHAR(255) NOT NULL,
mifi_admin_pass VARCHAR(255) NOT NULL,
lan_ip_addr VARCHAR(255) NOT NULL,
lan_ip_gate VARCHAR(255) NOT NULL,
lan_dns_1 VARCHAR(255) NOT NULL,
lan_dns_2 VARCHAR(255) NOT NULL,
tvh_dvbt_config_requested VARCHAR(255) NOT NULL,
tv_market VARCHAR(255) NOT NULL,
dvbt_tuner_name VARCHAR(255) NOT NULL,
schedule_tvseries VARCHAR(255) NOT NULL,
schedule_podcasts VARCHAR(255) NOT NULL,
schedule_movies VARCHAR(255) NOT NULL,
schedule_iptv VARCHAR(255) NOT NULL,
traktv_username VARCHAR(255) NOT NULL,
traktv_watchlist VARCHAR(255) NOT NULL,
telegram_bot_id VARCHAR(255) NOT NULL,
telegram_chat_id VARCHAR(30) NOT NULL,
telegram_username VARCHAR(255) NOT NULL,
whatsapp_no_recipient BIGINT(15) NOT NULL,
whatsapp_no_sender BIGINT(15) NOT NULL,
notification_email_address VARCHAR(255) NOT NULL,
gmail_address VARCHAR(255) NOT NULL,
gmail_password VARCHAR(255) NOT NULL,
news_sources VARCHAR(255) NOT NULL,
cctv_all INT(3) NOT NULL,
cctv_whatsapp INT(3) NOT NULL,
cctv_telegram INT(3) NOT NULL,
cctv_sms INT(3) NOT NULL,
cctv_email INT(3) NOT NULL,
cctv_kodi INT(3) NOT NULL,
cctv_osd INT(3) NOT NULL,
cctv_call INT(3) NOT NULL,
cctv_lights INT(3) NOT NULL,
youtube_api_key VARCHAR(255) NOT NULL,
youtube_client_id VARCHAR(255) NOT NULL,
youtube_client_secret VARCHAR(255) NOT NULL,
wunderground_api_key VARCHAR(255) NOT NULL,
openweathermap_api_key VARCHAR(255) NOT NULL,
latitude_home DECIMAL(10, 8) NOT NULL,
longitude_home DECIMAL(11, 8) NOT NULL,
ispeech_tts_api_key VARCHAR(255) NOT NULL,
google_tts_api_key VARCHAR(255) NOT NULL,
watson_tts_api_key VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
)
