#!/bin/bash
WP_ROOT_DIR=/wp
mkdir $WP_ROOT_DIR
cp -r app /usr/local/wp-docker
echo $WP_ROOT_DIR > /usr/local/wp-docker/.root
cp /usr/local/wp-docker/docker-compose-nginx-proxy.yml /wp/docker-compose.yml
chmod +x /usr/local/wp-docker/wp_create.php
ln -s /usr/local/wp-docker/wp_create.php /usr/local/bin/wp_create
docker network create nginx-proxy

