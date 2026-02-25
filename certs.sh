mkdir ./data/certs -p
openssl req -x509 -newkey rsa:4096 \
	-keyout ./data/certs/server.key \
	-out ./data/certs/server.crt \
	-sha256 -days 365 -nodes -subj "/C=US/ST=State/L=City/O=Org/CN=localhost"
