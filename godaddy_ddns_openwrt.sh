#!/bin/sh

#TEST=`curl -X GET -H "Authorization: sso-key $KEY:$SECRET" https://api.godaddy.com/v1/domains/available?domain=milky-way.cloud 2> /dev/null`

DOMAIN=""
ARECORD="@"
CURRENT_IP=`curl https://ipinfo.io/ip 2> /dev/null`
DNS_IP=`dig @8.8.8.8 +short `
KEY=""
SECRET=""
AUTHORIZATION_HEADER="Authorization: sso-key $KEY:$SECRET"
JSON_HEADER="Content-Type: application/json"
GODADDY_API="https://api.godaddy.com/v1/domains/$DOMAIN/records/A/$ARECORD"
UPDATE="[ { \\\"data\\\":\\\"$CURRENT_IP\\\",\\\"ttl\\\":3600,\\\"port\\\":1,\\\"weight\\\":0  } ]"

REQUEST="curl -i -s -X PUT -H \"$AUTHORIZATION_HEADER\" -H \"$JSON_HEADER\" -d \"$UPDATE\" $GODADDY_API"

if [ $CURRENT_IP != $DNS_IP ]; then
	echo "---------------------------"
        echo "Updating IP"
	echo "New IP: $CURRENT_IP"
        echo "DNS IP: $DNS_IP"
	echo "---------------------------"
        echo $REQUEST
	eval $REQUEST
fi
