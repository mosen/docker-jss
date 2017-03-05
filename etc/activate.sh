#!/usr/bin/env bash
REQUEST="{
  \"activationCode\": \"${JSS_ACTIVATION_CODE}\",
  \"institutionName\": \"${JSS_ORG_NAME}\",
  \"isEulaAccepted\": true,
  \"username\": \"${JSS_ADMIN_USERNAME}\",
  \"password\": \"${JSS_ADMIN_PASSWORD}\",
  \"email\": \"${JSS_ADMIN_EMAIL}\",
  \"jssUrl\": \"https://localhost:8444\"
}"

echo ${REQUEST} | curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d - 'http://localhost:8080/uapi/system/initialize'