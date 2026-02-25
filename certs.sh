# if certs error
mkdir ./data/etc/apache2/certs -p
openssl req -x509 -newkey rsa:4096 \
	-keyout ./data/etc/apache2/certs/server.key \
	-out ./data/etc/apache2/certs/server.crt \
	-sha256 -days 365 -nodes -subj "/C=US/ST=State/L=City/O=Org/CN=localhost"
