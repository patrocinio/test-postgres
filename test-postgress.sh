#/bin/bash
# Inspired by https://hub.jazz.net/project/communitysample/postgresql-nodejs/overview

APP_NAME=patrocinio-test-postgres

# Push the application
cf push $APP_NAME --no-start --random-route

# Bind the app to the service
SERVICE_NAME=postgresql-9.1
cf bs $APP_NAME $SERVICE_NAME

# Start the app
cf start $APP_NAME

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
