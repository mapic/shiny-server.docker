#!/bin/bash

GIT_SSH_COMMAND='ssh -i /root/.ssh/shiny-server.docker.deploy -o StrictHostKeyChecking=no' git pull --rebase