#!/usr/bin/perl -w

use ZoneMinder;

$| = 1;

# My Variables
my $ZM_DB_NAME = 'zm';
my $ZM_DB_HOST = 'localhost';
my $ZM_DB_USER = '';
my $ZM_DB_PASS = '';
my $OSD_SCRIPT = '/usr/bin/jambulatv-osd -m';
my $ALERT_SCRIPT = '';
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

        if ( my $last_event_id = zmHasAlarmed( $monitor, $monitor->{LastEventId} ) )
        {
            $monitor->{LastEventId} = $last_event_id;
            #
            # -----------
            # JambulaTV
            # -----------
            system("$OSD_SCRIPT 'Home Security Alarm $monitor->{Name} has been triggered'");

system("CHANGE-ME-SCRIPT CamID=".$monitor->{Id}." CamName=".$monitor->{Name});
            sleep(12)

            #system(1);
            #
            # -----------
        }
    }
    sleep( 1 );
}
