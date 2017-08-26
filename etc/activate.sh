#!/usr/bin/env bash

JSS_ORG_NAME=${JSS_ORG_NAME:-Test Organization}
JSS_ADMIN_USERNAME=${JSS_ADMIN_USERNAME:-admin}
JSS_ADMIN_PASSWORD=${JSS_ADMIN_PASSWORD:-"jamfsw03"}
JSS_ADMIN_EMAIL=${JSS_ADMIN_EMAIL:-admin@localhost}

REQUEST="{
  \"activationCode\": \"${JSS_ACTIVATION_CODE}\",
  \"institutionName\": \"${JSS_ORG_NAME}\",
  \"isEulaAccepted\": true,
  \"username\": \"${JSS_ADMIN_USERNAME}\",
  \"password\": \"${JSS_ADMIN_PASSWORD}\",
  \"email\": \"${JSS_ADMIN_EMAIL}\",
  \"jssUrl\": \"https://localhost:8444\"
}"

echo ${REQUEST} | curl -X POST \
    --header 'Content-Type: application/json' \
    --header 'Accept: application/json' \
    -d - 'http://localhost:9080/uapi/system/initialize'