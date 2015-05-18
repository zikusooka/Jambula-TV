#!/bin/sh

exec /usr/sbin/chat -EVv				\
	ECHO 	OFF					\
	REPORT 	CONNECT					\
	ABORT	"\nBUSY\r"				\
	ABORT	"\nERROR\r"				\
	ABORT	"\nNO CARRIER\r"			\
	ABORT	"\nUsername/Password Incorrect\r"	\
	""      "ATE1"					\
	SAY 	"Setting the network mode parameters"	\
	SAY 	"-----------------------------------"	\
	OK 	"AT\^SYSCFG=$NETWORK_TYPE_BAND"		\
	SAY 	"-----------------------------------"	\
	SAY 	"Setting the network id String"		\
	SAY 	"-----------------------------------"	\
	SAY 	"Setting the APN ID"			\
	SAY 	"-----------------------------------"	\
	OK	"AT+CGDCONT=1,\"IP\",\"$APN\""		\
	SAY 	"The Signal Strength of this Link is:\n"\
	SAY 	"-----------------------------------"	\
	""      "AT+CSQ"				\
	SAY 	"Querying the network mode parameters"	\
	SAY 	"-----------------------------------"	\
	"" 	"AT\^SYSINFO"				\
	SAY 	"Dialing $ISP ...\n"			\
	SAY 	"-----------------------------------"	\
	OK	ATD$TELEPHONE				\
	SAY 	"Waiting for a connection - 1 min..."	\
	SAY 	"-----------------------------------"	\
	TIMEOUT	60					\
	CONNECT	''					\
	SAY 	"Connected, Speed of connection is ..."	\
	""	"AT+CGEQNEG"				\
	""	"AT\^DSFLOWRPT"				\






#########
# NOTES #
#########

# 3G Network Selector Type
##########################

# 1. minicom -s
# 2. AT+COPS=? (Query Network)
# 3. AT+CFUN=1 (Reset modem)
# 4. AT+CSQ (Signal Strength)
	# 0 <= -113dBm
	# 1 -111dBm
	# 2 – 30 -109dBm to -53dBm
	# 31 >= -51dBm
	# 99 Unknown
# 5. AT+CGMI (Manufacturer)
# 6. AT+CGMR (Software version)
# 7. AT+CIMI (SIM IMSI Number)
# 8. AT+CGSN (device EMEI)
# 9. AT^HWVER (Hardware version)
#10. AT^SYSINFO (System Info: status, domain, roaming status, mode, SIM state)
	# Status
	# ------ 
	# 0 No service.
	# 1 Restricted service
	# 2 Valid service
	# 3 Restricted regional service.
	# 4 Power-saving and deep sleep state

	# Domain
	# -------
	# 0 No service.
	# 1 Only CS service
	# 2 Only PS service
	# 3 PS+CS service
	# 4 CS and PS not registered, searching

	# Roaming
	# -------
	# 0 Non roaming state
	# 1 Roaming state

	# Mode
	# ----
	# 0 No service.
	# 1 AMPS mode (not in use currently)
	# 2 CDMA mode (not in use currently)
	# 3 GSM/GPRS mode
	# 4 HDR mode
	# 5 WCDMA mode
	# 6 GPS mode

	# SIM state
	# ---------
	# 0 Invalid USIM card state or pin code locked
	# 1 Valid USIM card state
	# 2 USIM is invalid in case of CS
	# 3 USIM is invalid in case of PS
	# 4 USIM is invalid in case of either CS or PS
	# 255 USIM card is not existent


#11. AT^SYSCFG = mode, order, band, roaming, domain
# --------------------------------------------------
	# Mode
	# ----
	# 2 Automatic search
	# 13 2G ONLY
	# 14 3G ONLY
	# 16 No change

	# Order
	# -----
	# 0 Automatic search
	# 1 2G first, then 3G
	# 2 3G first, then 2G
	# 3 No change

	# Band
	# ----
	# 3FFFFFFF = All
	# Other (query list with "AT^SYSCFG=?")

	# Roaming
	# -------
	# 0=Not Supported
	# 1=Supported
	# 2=no Change

	# Domain
	# ------
	# 0=Circuit-Switched only
	# 1=Packet-Switched only
	# 2=Circuit- & Packet-Switched
	# 3=Any
	# 4=no Change



# UTL Areas
############

# Entebbe - Kinyarwanda 
# AT+COPS=0,0,\"UTL\",2 

# Kazinga Zone - Kiwatule
# AT+COPS=1,0,\"Uganda Telecom\",2

# Kiwatule
# (2,"Uganda Telecom","UTL","64111",2)
