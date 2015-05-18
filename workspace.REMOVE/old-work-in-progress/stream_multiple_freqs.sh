#!/bin/sh

INTERFACE="--intf ncurses --extraintf http "
#INTERFACE="--extraintf http "

# itv1: 487250 : 23
# bbc1: 511250 : 26
# four: 543250 : 30
# bbc2: 567250 : 33
# five: 599250 : 37


# UBC: 175500 :  5
# NBS: 224500 : 12
# BUKEDDE1: 231500 : 13
# LTV: 479500: 22
# WBS: 503000: 25
# TOP: 527250: 28
# EATV: 551500: 31
# CITIZEN: 559500: 32
# STAR: 623500: 40
# RECORD: 639500: 42
# BUKEDDE2: 647500: 43
# CHAN44: 655500: 44
# NTV: 735000: 54


TV_INPUT="v4l2:/dev/video1:norm=pal:size=320x240:channel=0,adev=/dev/dsp1"
FREQS=( 175500 224500 231500 479500 503000 527250 551500 559500 623500 639500 647500 655500 735000 )
CHANS=( [503000]="wbs" [551500]="eatv" [559500]="citizen" [655500]="chan44" [735000]="ntv" )

INPUTS=""
for freq in ${FREQS[@]}; do
    chan=${CHANS[$freq]}
    INPUTS="${INPUTS} ${TV_INPUT/:norm/:name=${chan}:norm}:frequency=${freq}"
done

OPTS_TRANS_VIDEO="vcodec=mp4v,vb=256,venc=ffmpeg{keyint=50,hurry-up},fps=25"
OPTS_TRANS_AUDIO="acodec=mp4a,ab=64,samplerate=22050,channels=1"
OPTS_TRANS_NOAUDIO="acodec=dummy"
OPTS_TRANS="transcode{${OPTS_TRANS_VIDEO},${OPTS_TRANS_AUDIO}}"

MCAST_ADDR="239.255.12.23"
BCAST_ADDR="192.168.0.255"
UNI_ADDR1="192.168.0.250"
UNI_ADDR2="192.168.0.251"

OPTS_UNI="std{access=udp,mux=ts,dst=${UNI1_ADDR},sap,name=McBookUni}"
OPTS_MCAST="std{access=udp,mux=ts,dst=${MCAST_ADDR}}"
OPTS_RTP1="rtp{dst=${UNI_ADDR1},port=1234,sdp=sap://,name=McBookProTV}"
OPTS_RTP2="rtp{dst=${UNI_ADDR2},port=1244,sdp=sap://,name=MacBeeTV}"

OPTS_DISPLAY="display"
OPTS_STREAM="duplicate{dst=${OPTS_RTP1},dst=${OPTS_RTP2}}"
OPTS_OUTPUT="duplicate{dst=${OPTS_DISPLAY}, dst=\"${OPTS_TRANS}:${OPTS_STREAM}\"}"

echo ${OPTS_OUTPUT}

vlc ${INTERFACE} -f --color --loop --volume 128 ${INPUTS} \
    --sout "#${OPTS_OUTPUT}"
