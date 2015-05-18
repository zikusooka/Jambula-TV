import time
import simplejson
from channel import BaseChannel, ChannelException,ChannelMetaClass, STATUS_BAD, STATUS_GOOD, STATUS_UGLY
from utils import *

################
## NTV Uganda ##
################
class NTV(BaseChannel):
    playable = True
    short_name = 'ntv'
    long_name = 'NTV'
    default_action = 'play_stream'

    def action_play_stream(self):
        self.plugin.set_stream_url('http://192.168.0.101:9981/stream/channelid/749917969')
 
###################
## WBS TV Uganda ##
###################      
class WBSTV(BaseChannel):
    playable = True
    short_name = 'wbs'
    long_name = 'WBS TV'
    default_action = 'play_stream'

    def action_play_stream(self):
        self.plugin.set_stream_url('http://192.168.0.101:9981/stream/channelid/788445509')
