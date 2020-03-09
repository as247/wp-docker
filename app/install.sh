#!/bin/bash

mkdir /wp
cp ./docker-compose-nginx-proxy.yml /wp/docker-compose.yml
cp ./docker-compose-template.yml /wp/docker-compose-template.yml
cp wp_create.php /wp/wp_create
chmod +x wp_create
docker network create nginx-proxy

