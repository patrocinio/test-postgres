#!/bin/bash
# Inspired by https://hub.jazz.net/project/communitysample/postgresql-nodejs/overview
if [ "$#" -ne 5 ]; then
  echo "Usage: $0 host port dbname user password" 
  exit 1
fi

APP_NAME=patrocinio-test-postgres
SERVICE_NAME=postgres
URI=postgres:\/\/$4:$5\@$1:$2\/$3

# Parameters
# $1: app name
# $2: name
check_url () {
# Grab URL
URL=`cf app $APP_NAME | grep urls | awk '{print $2}'`

# Check response
LINE=`wget --server-response --content-on-error=off ${URL} 2>&1 | grep HTTP`

# Prints result
if [[ "$LINE" == *"200"* ]]; then
echo Postgres working great!
else
echo Postgres failed :-/
fi
}

#Create a JSON File
echo "{\"public_hostname\":\"$URI\", \"user\": \"$4\", \"password\": \"$5\"}" > /tmp/new1.json

# Update the service
echo "Updating the service"
echo "Running cf uups $SERVICE_NAME -p /tmp/new1.json"
cf uups $SERVICE_NAME -p /tmp/new1.json

echo "Restage the Applicatiion"
echo "Running cf restage $APP_NAME"
cf restage $APP_NAME

if [[ $? -ne 0 ]];
then
    echo Failed to bind $SERVICE_NAME to $APP_NAME
    echo Ensure we have a service called 'postgres'
else
  # Start the app
  echo Starting the application...
  cf start $APP_NAME

  # Check response
  check_url $APP_NAME "Postgres"
fi
