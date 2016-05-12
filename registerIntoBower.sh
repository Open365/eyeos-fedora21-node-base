#!/bin/bash

set -e
set -u

REPO_NAME=$1
BOWER_USERNAME=$2
BOWER_OAUTH_TOKEN=$3

# Login as bower
mkdir -p /root/.config/configstore
echo "accessToken: $BOWER_OAUTH_TOKEN\nusername: $BOWER_USERNAME" >> /root/.config/configstore/bower-github.yml

# Register
if bower info $REPO_NAME; then
    echo "Lib already registered to bower"
else
    echo "Registering lib to bower with name: $REPO_NAME"
    bower register $REPO_NAME "https://github.com/Open365/${REPO_NAME}-artifacts"
fi
