#!/bin/bash

set -e
set -u

DIR=$1
AUTH=$2

cd "$DIR"
echo "$AUTH" > ~/.npmrc

PACKAGE_NAME=`cat package.json | json name`
PACKAGE_VERSION=`cat package.json | json version`
PUBLISHED_VERSION=`npm info $PACKAGE_NAME version || echo '-'`

if [ "$PACKAGE_VERSION" != "$PUBLISHED_VERSION" ]; then
    npm publish
else
    echo "NPM has the latest version. Nothing to publish"
fi
