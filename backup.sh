#!/bin/bash
# Author: Ismael Barros² <ismael@barros2.org>
# License: WTFPL (http://www.wtfpl.net/txt/copying/)

SITE="$1"
OUTPUT="${2:-mongodb_${SITE:-local}_$(date +%y%m%d_%H%M)}"

URL=$(meteor mongo --url $SITE)
if [[ "$URL" =~ ^.*://((.*):(.*)@)?(.*:.*)/(.*)$ ]]; then
	USER=${BASH_REMATCH[2]}
	PASSWORD=${BASH_REMATCH[3]}
	HOST=${BASH_REMATCH[4]}
	DATABASE=${BASH_REMATCH[5]}
else
	echo "Invalid URL $URL"
	exit 1
fi

echo "Backing up ${SITE:-local} to ${OUTPUT}..."

[ -n "$USER" ] && cmd_user="-u $USER"
[ -n "$PASSWORD" ] && cmd_pass="-p $PASSWORD"
cmd="mongodump $cmd_user $cmd_pass -h $HOST -d $DATABASE -o $OUTPUT"
echo "Running '${cmd}'..."
$cmd
