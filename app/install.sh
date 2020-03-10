#!/bin/bash
WP_ROOT_DIR=/wp
APP_DIR=/usr/local/wp-docker
BIN_PATH=/usr/local/bin/wp_create
BASEDIR=$(dirname "$0")
if [ ! -e $WP_ROOT_DIR ]; then
mkdir $WP_ROOT_DIR
fi
if [ -e $APP_DIR ]; then
  rm -rf $APP_DIR
fi
mkdir $APP_DIR
cp -r "$BASEDIR"/* $APP_DIR
echo $WP_ROOT_DIR > $APP_DIR/.root
cp $APP_DIR/docker-compose-nginx-proxy.yml $WP_ROOT_DIR/docker-compose.yml
chmod +x $APP_DIR/wp_create.php
if [ -e $BIN_PATH ]; then
  rm -f $BIN_PATH
fi
ln -s $APP_DIR/wp_create.php $BIN_PATH

if [ $(docker network ls | grep -c nginx-proxy) -lt 1 ]; then
  docker network create nginx-proxy
fi

echo "Install completed!";


