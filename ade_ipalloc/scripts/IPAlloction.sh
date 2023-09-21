#!/bin/bash

function raiseError() {
	echo "$1" 1>&2 && exit 1
}

function assertNotEmpty() {
	[ -z "$2" ] && raiseError "Variable '$1' must not be empty!"
}

eval "$(jq -r '@sh "URL=\(.URL)"')"
assertNotEmpty 'URL' $URL

TOKEN=$(az account get-access-token --query accessToken --output tsv)
JSON=$(curl $VERBOSE -X GET "$URL" -H "Accept: application/json" -H "Authorization: Bearer $TOKEN")

jq -n \
	--arg IPRANGES "$(echo $JSON | jq -r '.data | join(",")')" \
	'{ "IPRANGES": $IPRANGES }' 