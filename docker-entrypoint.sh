#!/bin/bash

export SHINY_LOG_LEVEL=DEBUG

# chown apps folder
chown 1001:www-data /srv/shiny-server/apps

# chown logs folder
chown -R 1001:www-data /var/log/shiny-server/

# start shiny
shiny-server --pidfile=/var/run/shiny-server.pid
