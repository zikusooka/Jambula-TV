
OUTPUT=/tmp/JambulaTV.intro.mkv

GEOMETRY=$(xwininfo -root | grep 'geometry' | awk '{print $2;}' | sed -e 's:+0+0::') 
FRAMERATE=15
VCODEC=flv
ACODEC=wmav1
VIDEO_BITRATE=16384k


#PULSE_SOURCE="default"


PULSE_SOURCE="microphone_out.monitor"
#PULSE_SOURCE="jambulatv_out.monitor"

#PULSE_SOURCE="alsa_output.pci-0000_00_14.2.analog-stereo"
#PULSE_SOURCE="alsa_output.pci-0000_00_14.2.analog-stereo.monitor"


su -l jambula -c "ffmpeg -f x11grab -s $GEOMETRY -framerate $FRAMERATE -i :0.0 -f pulse -ac 2 -i $PULSE_SOURCE $OUTPUT"
