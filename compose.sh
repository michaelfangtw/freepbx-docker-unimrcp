mkdir data -p 
chown 999:1000 data -R
mkdir /var/log/asterisk -p 
docker compose down
docker compose up -d
