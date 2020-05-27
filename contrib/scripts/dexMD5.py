#!/usr/bin/env python3
# tweak up from https://github.com/mgp25/classesMD5-64/blob/master/dexMD5.py
# build AXML library from https://github.com/mikusjelly/axmlparser
# add xml manifest parse for getting WhatsApp Version
# to use this $ python3 dexMD5.py apk/WhatsApp.apk
# Output : 
# WhatsApp Version : 2.17.296
# WhatsApp ClassesDEX MD5 : b'YrJNPljM3TuNFPIOZ+jziw=='
#
# @MasBog

import sys
import zipfile
import hashlib
import base64
from xml.dom import minidom
from axmlparser import AXML

try:
        apkName = sys.argv[1]
        zipFile = zipfile.ZipFile(apkName,'r')
        hash = hashlib.md5()
        hash.update(zipFile.read('classes.dex'))
        axml = AXML(zipFile.read('AndroidManifest.xml'))
        xml = minidom.parseString(axml.get_buff())
        package = xml.documentElement.getAttribute("package")
        print("--> WhatsApp Version : "+xml.documentElement.getAttributeNS('http://schemas.android.com/apk/res/android', "versionName"))
        print("--> WhatsApp ClassesDEX MD5 : "+ str(base64.b64encode(hash.digest())));

except:
        print("Please enter directory of WhatsApp.apk")
