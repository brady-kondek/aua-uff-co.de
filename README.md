Filter logfiles before parsing:

rsync user@server.com:/var/log/apache2/other_vhosts_access* .
gunzip *.gz
ruby -ne 'print if /aua-uff-co.de/' other_vhosts_access.log.*
find . -size  0 -print0 |xargs -0 rm
zcat -f other_vhosts_access* | goaccess > report.html