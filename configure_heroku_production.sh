#!/bin/bash

set -e

# heroku login

APP_NAME=webapi-bobe-production

heroku apps:create $APP_NAME
heroku addons:create heroku-postgresql:hobby-dev --app $APP_NAME
heroku config:set RACK_ENV=production --app $APP_NAME
heroku drains:add $SUMOLOGIC_SOURCE --app $APP_NAME
