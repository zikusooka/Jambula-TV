-- Host: localhost    Database: zm
-- Update Config Table with customized options

-- Authentication
UPDATE Config set Value=1 where Name='ZM_OPT_USE_AUTH';
UPDATE Config set Value=0 where Name='ZM_AUTH_HASH_IPS';
UPDATE Config set Value=1 where Name='ZM_AUTH_HASH_LOGINS';
UPDATE Config set Value=1 where Name='ZM_OPT_USE_LEGACY_API_AUTH';
UPDATE Config set Value='mai7cheiph6ua5kohdi2oopahDoh9taeQui6voi6lohsh5Oobei6choob2ahChahf1meisahpaidebeuduGepeic2iwohsei3favshdgdgaus' where Name='ZM_AUTH_HASH_SECRET';

-- API
UPDATE Config set Value=1 where Name='ZM_OPT_USE_API';
UPDATE Config set Value=0 where Name='ZM_ENABLE_CSRF_MAGIC';

-- Logging
UPDATE Config set Value=-1 where Name='ZM_LOG_LEVEL_SYSLOG';
UPDATE Config set Value=-1 where Name='ZM_LOG_LEVEL_FILE';
UPDATE Config set Value=-1 where Name='ZM_LOG_LEVEL_WEBLOG';


UPDATE Config set Value='/var/log/JambulaTV/zoneminder/zm_debug.log+' where Name='ZM_LOG_DEBUG_FILE';

-- Privacy
UPDATE Config set Value=0 where Name='ZM_SHOW_PRIVACY';
UPDATE Config set Value=0 where Name='ZM_TELEMETRY_DATA';

-- Filters
UPDATE Config set Value=100000000 where Name='ZM_FILTER_EXECUTE_INTERVAL';

-- Web Interface
UPDATE Config set Value='classic' where Name='ZM_SKIN_DEFAULT';
UPDATE Config set Value='JambulaTV Eyes' where Name='ZM_WEB_TITLE';
UPDATE Config set Value='JambulaTV-Eyes' where Name='ZM_WEB_TITLE_PREFIX';
UPDATE Config set Value='JambulaTV-Eyes' where Name='ZM_HOME_CONTENT';
UPDATE Config set Value='https://jambulatv.com' where Name='ZM_HOME_URL';
UPDATE Config set Value='http://172.16.0.1:8520' where Name='ZM_URL';

UPDATE Config set Value='JambulaTV-Eyes - CCTV recording and security system' where Name='ZM_WEB_CONSOLE_BANNER';

-- Email
UPDATE Config set Value=0 where Name='ZM_OPT_EMAIL';
UPDATE Config set Value='local.JambulaTV' where Name='ZM_EMAIL_HOST';
UPDATE Config set Value='JambulaTV-Eyes: Alarm - %MN%-%EI% (%ESM% - %ESA% %EFA%)' where Name='ZM_EMAIL_SUBJECT';
UPDATE Config set Value='subject = "JambulaTV-Eyes Alarm - %MN%-%EI% (%ESM% - %ESA% %EFA%)"\n      body = "\n      Hello,\n\n    An alarm has been detected on your installation of the JambulaTV-Eyes.\n\n      The details are as follows :-\n\n      Monitor  : %MN%\n      Event Id : %EI%\n      Length   : %EL%\n      Frames   : %EF% (%EFA%)\n      Scores   : t%EST% m%ESM% a%ESA%\n\n      This alarm was matched by the %FN% filter and can be viewed at %EPS%\n\n      JambulaTV-Eyes"' where Name='ZM_EMAIL_TEXT';

UPDATE Config set Value=0 where Name='ZM_OPT_MESSAGE';
UPDATE Config set Value='JambulaTV-Eyes alarm detected - %EL% secs, %EF%/%EFA% frames, t%EST%/m%ESM%/a%ESA% score.' where Name='ZM_MESSAGE_BODY';
UPDATE Config set Value='JambulaTV-Eyes: Alarm - %MN%-%EI%' where Name='ZM_MESSAGE_SUBJECT';
UPDATE Config set Value='subject = "JambulaTV-Eyes: Alarm - %MN%-%EI%"\n      body = "JambulaTV-Eyes alarm detected - %EL% secs, %EF%/%EFA% frames, t%EST%/m%ESM%/a%ESA% score."' where Name='ZM_MESSAGE_TEXT';

UPDATE Config set Value='Eyes@local.JambulaTV' where Name='ZM_FROM_EMAIL';
UPDATE Config set Value='\n      Hello,\n\n    An alarm has been detected on your installation of the JambulaTV-Eyes.\n\n      The details are as follows :-\n\n      Monitor  : %MN%\n      Event Id : %EI%\n      Length   : %EL%\n      Frames   : %EF% (%EFA%)\n      Scores   : t%EST% m%ESM% a%ESA%\n\n      This alarm was matched by the %FN% filter and can be viewed at %EPS%\n\n      JambulaTV-Eyes' where Name='ZM_EMAIL_BODY';

-- Events
UPDATE Config set Value=1 where Name='ZM_OPT_USE_EVENTNOTIFICATION';

-- Updates
UPDATE Config set Value=0 where Name='ZM_CHECK_FOR_UPDATES';

-- Donate
UPDATE Config set Value=0 where Name='ZM_DYN_SHOW_DONATE_REMINDER';
