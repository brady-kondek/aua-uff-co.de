Filter logfiles before parsing:

ruby -ne 'print if /aua-uff-co.de/' other_vhosts_access.log.*