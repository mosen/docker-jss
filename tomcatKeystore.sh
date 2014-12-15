#!/bin/bash

keypass=password
CN=fqdn
OU=organizational_unit
O=organization
L=city_location
ST=state
C=country
numDays=365

docker exec --interactive jss "keytool -genkey -alias tomcat -keyalg RSA -keypass $keypass -storepass $keypass -dname "CN=$fqdn, OU=$OU, O=$O, L=$L, ST=$ST, C=$C" -keystore /etc/tomcat7/keystore -validity $numDays"
