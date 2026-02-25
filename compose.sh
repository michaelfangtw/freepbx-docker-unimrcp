mkdir data -p
chown 999:1000 data -R
docker compose down
docker compose up -d
