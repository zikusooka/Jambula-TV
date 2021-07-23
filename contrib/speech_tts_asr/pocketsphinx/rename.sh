#!/bin/sh

FILENAME=$(ls -x *.* | cut -d '.' -f1)


clear

# Rename
for foo in vocab sent log_pronounce lm dic; do mv -v $FILENAME.$foo jambulatv.000.$foo; done

# Sync 4 testing
rsync -aAXv * /usr/share/JambulaTV/pocketsphinx/

echo "

Sync 4 production as follows:

rsync -aAXv --size-only -n /usr/share/JambulaTV/pocketsphinx/ /Backup1/JambulaTV/contrib/speech_tts_asr/pocketsphinx/

"
