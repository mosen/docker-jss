#!/usr/bin/env sh

export SELF_SIGNED=${SELF_SIGNED:-"1"}
export TLS_CERT=${TLS_CERT:-"/server.crt"}
export TLS_KEY=${TLS_KEY:-"/server.key"}
export CA_CERT=${CA_CERT:-"/ca.crt"}

KEYSTORE_PATH=/usr/local/tomcat/conf/.keystore

if [ $SELF_SIGNED -eq 1 ]; then
	/usr/bin/keytool -genkeypair -alias tomcat -keyalg RSA -keypass changeit -storepass changeit \
		-dname "CN=jss.example.com, OU=Mobile Device Management, O=Company, L=Location, ST=State, C=Country" -keystore ${KEYSTORE_PATH} -validity 365
else
	/usr/bin/keytool -import -alias root -keystore ${KEYSTORE_PATH} -trustcacerts -file ${CA_CERT}
	/usr/bin/keytool -import -alias tomcat -keystore ${KEYSTORE_PATH} -file ${TLS_CERT}
fi

/usr/bin/confd -onetime -backend env



catalina.sh run
