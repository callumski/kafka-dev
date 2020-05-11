#!/usr/bin/env bash

set -e

VALIDITY_IN_DAYS=3650
SERVER_WORKING_DIRECTORY="kafka/ssl/server"
CLIENT_WORKING_DIRECTORY="kafka/ssl/client"
SERVER_KEYSTORE_FILE="${SERVER_WORKING_DIRECTORY}/kafka.server.keystore.jks"
SERVER_TRUSTSTORE_FILE="${SERVER_WORKING_DIRECTORY}/kafka.server.truststore.jks"
CLIENT_TRUSTSTORE_FILE="${CLIENT_WORKING_DIRECTORY}/kafka.client.truststore.jks"
CA_CERT_FILE="ca-cert"
CA_KEY_FILE="ca-key"
KEYSTORE_SIGN_REQUEST="cert-file"
KEYSTORE_SIGN_REQUEST_SRL="ca-cert.srl"
KEYSTORE_SIGNED_CERT="cert-signed"

mkdir -p ${SERVER_WORKING_DIRECTORY}
mkdir -p ${CLIENT_WORKING_DIRECTORY}

keytool -keystore ${SERVER_KEYSTORE_FILE} -alias localhost -keyalg RSA -validity ${VALIDITY_IN_DAYS} -genkey
openssl req -new -x509 -keyout ${CA_KEY_FILE} -out ${CA_CERT_FILE} -days ${VALIDITY_IN_DAYS}
keytool -keystore ${CLIENT_TRUSTSTORE_FILE} -alias CARoot -import -file ${CA_CERT_FILE}
keytool -keystore ${SERVER_TRUSTSTORE_FILE} -alias CARoot -importcert -file ${CA_CERT_FILE}
keytool -keystore ${SERVER_KEYSTORE_FILE} -alias localhost -certreq -file ${KEYSTORE_SIGN_REQUEST}
openssl x509 -req -CA ${CA_CERT_FILE} -CAkey ${CA_KEY_FILE} -in ${KEYSTORE_SIGN_REQUEST} -out ${KEYSTORE_SIGNED_CERT} -days ${VALIDITY_IN_DAYS} -CAcreateserial -passin pass:${CA_PASSWORD}
keytool -keystore ${SERVER_KEYSTORE_FILE} -alias CARoot -import -file ${CA_CERT_FILE}
keytool -keystore ${SERVER_KEYSTORE_FILE} -alias localhost -import -file ${KEYSTORE_SIGNED_CERT}
rm $KEYSTORE_SIGN_REQUEST_SRL
rm $KEYSTORE_SIGN_REQUEST
rm $KEYSTORE_SIGNED_CERT