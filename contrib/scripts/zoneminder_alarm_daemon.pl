#!/usr/bin/perl -w

use strict;
use warnings;
use ZoneMinder;

$| = 1;

# My Variables
my $ZM_DB_NAME = 'ZONEMINDER_DB_NAME';
my $ZM_DB_HOST = 'ZONEMINDER_DB_HOST';
my $ZM_DB_USER = 'ZONEMINDER_DB_USER';
my $ZM_DB_PASS = 'ZONEMINDER_DB_PASS';
my $ZM_ALARM_PID = $$;
my $ZM_ALARM_PID_FILE = '/run/zm/zm_alarm.pid';
my $ALARM_NOTIFICATION_SCRIPT = '/usr/bin/jambulatv-zm-alarm-all-notifications';

# Write PID to ZM alarm file - Used during ExecStop in systemd service file
open(my $fh, '>>', $ZM_ALARM_PID_FILE) or die "Could not open file '$ZM_ALARM_PID_FILE' $!";
print $fh "$ZM_ALARM_PID";
close $fh;


my $last_event_id = '0';

my $dbh = DBI->connect( "DBI:mysql:database=".$ZM_DB_NAME.";host=".$ZM_DB_HOST, $ZM_DB_USER, $ZM_DB_PASS );
my $sql = "select M.*, max(E.Id) as LastEventId from Monitors as M left join Events as E on M.Id = E.MonitorId where M.Function != 'None' group by (M.Id)";
my $sth = $dbh->prepare_cached( $sql ) or die( "Can't prepare '$sql': ".$dbh->errstr() );

my $res = $sth->execute() or die( "Can't execute '$sql': ".$sth->errstr() );
my @monitors;
while ( my $monitor = $sth->fetchrow_hashref() )
{
    push( @monitors, $monitor );
}

while( 1 )
{
   foreach my $monitor ( @monitors )
   {   
   next if ( !zmMemVerify( $monitor ) );

      if ( defined( zmMemRead( $monitor, "shared_data:last_event" )) ) {

         if ( defined( $monitor->{LastEventId} ))
         {
            if ( ( my $last_event_id = zmHasAlarmed( $monitor, $monitor->{LastEventId} ) ) )

         {
            $monitor->{LastEventId} = $last_event_id;
            print( "Monitor ".$monitor->{Name}." has alarmed\n" );
            print("Monitor ID = $monitor->{Id} Event ID = $last_event_id");
            #
            # -----------------------------------
            # Send JambulaTV Notification Alerts
            # -----------------------------------
            system("$ALARM_NOTIFICATION_SCRIPT $monitor->{Id} $monitor->{Name} $last_event_id");

         }
         }
      }
   }
      
   sleep( 1 );
}
