#!/bin/bash
# Inspired by https://hub.jazz.net/project/communitysample/postgresql-nodejs/overview
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 service connection"
  echo "Sample of connection: redis://x:[password]@aws-us-east-1-portal.16.dblayer.com:11132"
  exit 1
fi

SERVICE_NAME=$1
URI=$2

TEMP_FILE=/tmp/new1.json


#Create a JSON File
echo "{\"credentials\":\"$URI\"}" > $TEMP_FILE

# Update the service
echo "Updating the service"
echo "Running cf cups $SERVICE_NAME -p $TEMP_FILE"
cf cups $SERVICE_NAME -p $TEMP_FILE

