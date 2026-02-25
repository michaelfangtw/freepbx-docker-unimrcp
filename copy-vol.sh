docker cp twmdialer-pbx16:/var/lib/asterisk ./data/var
docker cp twmdialer-pbx16:/etc/asterisk ./data/etc
docker cp twmdialer-pbx16:/usr/lib64/asterisk ./data/usr
docker cp twmdialer-pbx16:/var/www/html ./data/www

#additional 
docker cp twmdialer-pbx16:/var/spool/asterisk/monitor ./data/monitor
docker cp twmdialer-pbx16:/var/lib/asterisk/etc/freepbx.conf ./data/conf/freepbx.conf
docker cp twmdialer-pbx16:/etc/odbc.ini ./data/conf/odbc.ini


