-- -----------------------------------
-- Host: localhost Database: jambulatv
-- -----------------------------------
DROP TABLE IF EXISTS setup;
CREATE TABLE setup (
id int(3) NOT NULL AUTO_INCREMENT,
contact_name varchar(255) NOT NULL,
contact_email varchar(255) NOT NULL,
contact_phone int(15) NOT NULL,
contact_birthday varchar(255) NOT NULL,
contact_address1 varchar(255) NOT NULL,
contact_address2 varchar(255) NOT NULL,
contact_city varchar(255) NOT NULL,
contact_country varchar(255) NOT NULL,
isp_name varchar(255) NOT NULL,
internet_device varchar(255) NOT NULL,
wifi_nickname_1 varchar(255) NOT NULL,
wifi_mac_1 varchar(255) NOT NULL,
wifi_nickname_2 varchar(255) NOT NULL,
wifi_mac_2 varchar(255) NOT NULL,
wifi_nickname_3 varchar(255) NOT NULL,
wifi_mac_3 varchar(255) NOT NULL,
wifi_nickname_4 varchar(255) NOT NULL,
wifi_mac_4 varchar(255) NOT NULL,
wifi_nickname_5 varchar(255) NOT NULL,
wifi_mac_5 varchar(255) NOT NULL,
network_apn varchar(255) NOT NULL,
mifi_ssid varchar(255) NOT NULL,
mifi_pass varchar(255) NOT NULL,
lan_ip_addr varchar(255) NOT NULL,
lan_ip_gate varchar(255) NOT NULL,
lan_dns_1 varchar(255) NOT NULL,
lan_dns_2 varchar(255) NOT NULL,
schedule_tvseries varchar(255) NOT NULL,
schedule_podcasts varchar(255) NOT NULL,
schedule_movies varchar(255) NOT NULL,
traktv_username varchar(255) NOT NULL,
traktv_watchlist varchar(255) NOT NULL,
telegram_bot_id varchar(255) NOT NULL,
telegram_chat_id int(30) NOT NULL,
telegram_username varchar(255) NOT NULL,
whatsapp_no_recipient int(15) NOT NULL,
whatsapp_no_sender int(15) NOT NULL,
notification_email_address varchar(255) NOT NULL,
gmail_address varchar(255) NOT NULL,
gmail_password varchar(255) NOT NULL,
PRIMARY KEY (id)
)