#!/usr/bin/env sh
KEYTOOL="/usr/bin/keytool"


export SELF_SIGNED=${SELF_SIGNED:-"1"}
export TLS_ENCODING=${TLS_ENCODING:-"PEM"}
export CA_CERT=${CA_CERT:-"/ca.crt"}

export JKS_PASS=${JKS_PASS:-"changeit"}
export PKCS12_PASS=${PKCS12_PASS:-"changeit"}

TLS_CERT_PATH=/server.crt
TLS_KEY_PATH=/server.key
TLS_CA_PATH=/ca.crt
PKCS12_PATH=/server.p12

KEYSTORE_PATH=/usr/local/tomcat/conf/.keystore

if [ $SELF_SIGNED -eq 1 ]; then
	${KEYTOOL} -genkeypair \
	    -alias tomcat \
	    -keyalg RSA \
	    -keypass "${JKS_PASS}" \
	    -storepass "${JKS_PASS}" \
		-dname "CN=localhost, OU=Mobile Device Management, O=Company, L=Location, ST=State, C=Country" \
		-keystore ${KEYSTORE_PATH} \
		-validity 365
else
	if [ -n "$PKCS12" ]; then
        ${KEYTOOL} -importkeystore \
                -deststorepass "${JKS_PASS}" \
                -destkeypass "${JKS_PASS}" \
                -destkeystore ${KEYSTORE_PATH} \
                -srckeystore /server.p12 \
                -srcstoretype PKCS12 \
                -srcstorepass ${PKCS12_PASS} \
                -alias tomcat
    else
        ${KEYTOOL} -import -alias tomcat -keystore ${KEYSTORE_PATH} -file ${TLS_CERT_PATH}
    fi

    ${KEYTOOL} -import -alias root -keystore ${KEYSTORE_PATH} -trustcacerts -file ${CA_CERT}
fi

# PKCS12


catalina.sh run
