#!/bin/bash

mkdir /wp
cp ./docker-compose-nginx-proxy.yml /wp/docker-compose.yml
cp wp_create.php /wp/wp_create
chmod +x wp_create
docker network create nginx-proxy

