#!/bin/bash

set -e
set -u

DIR=$1
AUTH=$2

cd "$DIR"
echo "$AUTH" > ~/.npmrc
npm publish
