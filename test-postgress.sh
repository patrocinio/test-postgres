#/bin/bash
# Inspired by https://hub.jazz.net/project/communitysample/postgresql-nodejs/overview

APP_NAME=patrocinio-test-postgres

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

# Push the application
cf push $APP_NAME --no-start --random-route

# Bind the app to the service
SERVICE_NAME=postgres
cf bs $APP_NAME $SERVICE_NAME

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