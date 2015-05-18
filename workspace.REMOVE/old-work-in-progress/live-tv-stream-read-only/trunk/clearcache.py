import xbmc, xbmcaddon, xbmcgui, xbmcplugin,os
import shutil

def deletecachefiles():
	# Set path to What th Furk cache files
    wtf_cache_path = os.path.join(xbmc.translatePath('special://profile/addon_data/plugin.video.whatthefurk/cache'), '')
		
    for root, dirs, files in os.walk(wtf_cache_path):
        file_count = 0
        file_count += len(files)
	
    # Count files and give option to delete
        if file_count > 0:

            dialog = xbmcgui.Dialog()
            if dialog.yesno("Delete WTF Cache Files", str(file_count) + " files found", "Do you want to delete them?"):
			
                for f in files:
    	            os.unlink(os.path.join(root, f))
                for d in dirs:
    	            shutil.rmtree(os.path.join(root, d))
					
        else:
            dialog = xbmcgui.Dialog()
            dialog.ok("Delete WTF Cache Files", "There are no cache files to delete")
            
    if xbmc.getCondVisibility('system.platform.ATV2'):
        atv2_cache_a = os.path.join('/private/var/mobile/Library/Caches/AppleTV/Video/', 'Other')
        
        for root, dirs, files in os.walk(atv2_cache_a):
		file_count = 0
        file_count += len(files)
		
        if file_count > 0:

            dialog = xbmcgui.Dialog()
            if dialog.yesno("Delete ATV2 Cache Files", str(file_count) + " files found in 'Other'", "Do you want to delete them?"):
			
                for f in files:
    	            os.unlink(os.path.join(root, f))
                for d in dirs:
    	            shutil.rmtree(os.path.join(root, d))
					
        else:
            dialog = xbmcgui.Dialog()
            dialog.ok("Delete Cache Files", "There are no ATV2 'Other' cache files to delete")
			
        atv2_cache_b = os.path.join('/private/var/mobile/Library/Caches/AppleTV/Video/', 'LocalAndRental')
        
        for root, dirs, files in os.walk(atv2_cache_b):
		file_count = 0
        file_count += len(files)
		
        if file_count > 0:

            dialog = xbmcgui.Dialog()
            if dialog.yesno("Delete ATV2 Cache Files", str(file_count) + " files found in 'LocalAndRental'", "Do you want to delete them?"):
			
                for f in files:
    	            os.unlink(os.path.join(root, f))
                for d in dirs:
    	            shutil.rmtree(os.path.join(root, d))
					
        else:
            dialog = xbmcgui.Dialog()
            dialog.ok("Delete Cache Files", "There are no ATV2 'LocalAndRental' cache files", "to delete")

        atv2_cache_c = os.path.join('/private/var/cache/apt/archives/', 'Cydia Archive')
        
        for root, dirs, files in os.walk(atv2_cache_c):
		file_count = 0
        file_count += len(files)
		
        if file_count > 0:

            dialog = xbmcgui.Dialog()
            if dialog.yesno("Delete ATV2 Cache Files", str(file_count) + " files found in 'Cydia Archives'", "Do you want to delete them?"):
			
                for f in files:
    	            os.unlink(os.path.join(root, f))
                for d in dirs:
    	            shutil.rmtree(os.path.join(root, d))
					
        else:
            dialog = xbmcgui.Dialog()
            dialog.ok("Delete Cache Files", "There are no ATV2 'Cydia Archives' cache files to delete")

            
deletecachefiles()