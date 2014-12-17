#!/bin/sh

mkdir -p /app/wp-content/themes
mkdir -p /app/wp-content/plugins
mkdir -p /app/wp-content/uploads

exec /run-wordpress.sh