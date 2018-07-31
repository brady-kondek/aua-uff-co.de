# Filter logfiles before parsing:

rsync -v user@server.com:/var/log/apache2/other_vhosts_access* .
gunzip *.gz
ruby -ne 'print if /aua-uff-co.de/' -i other_vhosts_access.log* -i
find . -size  0 -print0 |xargs -0 rm
zcat -f other_vhosts_access* | goaccess > report.html


ruby -ne 'print if /\/episodes\/episode/' -i other_vhosts_access.log* -i


# Umwandlung von mp3 in opus:

avconv -i episodexx.mp3 -f wav - | opusenc --bitrate 128 - episodexx.opus
