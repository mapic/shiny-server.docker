#!/bin/bash

export SHINY_LOG_LEVEL=DEBUG

# start shiny
shiny-server --pidfile=/var/run/shiny-server.pid
