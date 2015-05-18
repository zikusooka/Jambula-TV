import xbmcaddon, util


url='http://www.ophanim.net:8270/'

addon = xbmcaddon.Addon('plugin.audio.fmradio.ug.eastafrica')

util.playMedia(addon.getAddonInfo('name'), addon.getAddonInfo('icon'), url)
