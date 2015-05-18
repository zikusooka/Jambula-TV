import xbmcaddon, util


url='http://www.simba.fm:8000/stream.m3u'

addon = xbmcaddon.Addon('plugin.audio.fmradio.ug.simba')

util.playMedia(addon.getAddonInfo('name'), addon.getAddonInfo('icon'), url)
