!/bin/bash
# Inspired by https://hub.jazz.net/project/communitysample/postgresql-nodejs/overview
if [ "$#" -ne 5 ]; then
  echo "Usage: $0 host port dbname user password"
  exit 1
fi

APP_NAME=patrocinio-test-postgres
SERVICE_NAME=postgres
URI=postgres:\/\/$4:$5\@$1:$2\/$3

#Create a JSON File
echo "{\"public_hostname\":\"$URI\", \"user\": \"$4\", \"password\": \"$5\"}" > /tmp/new1.json

# Update the service
echo "Creating the service"
echo "Running cf cups $SERVICE_NAME -p /tmp/new1.json"
cf cups $SERVICE_NAME -p /tmp/new1.json
if [[ $? -ne 0 ]];
then
  echo "Creation of Service Failed.."
fi
