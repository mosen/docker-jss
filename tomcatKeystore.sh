#!/bin/bash

keypass=changeit
CN=fqdn
OU=organizational_unit
O=organization
L=city_location
ST=state
C=country
numDays=365

/usr/bin/keytool -genkey -alias tomcat -keyalg RSA -keypass $keypass -storepass $keypass -dname "CN=$fqdn, OU=$OU, O=$O, L=$L, ST=$ST, C=$C" -keystore /usr/local/tomcat/conf/.keystore -validity $numDays
