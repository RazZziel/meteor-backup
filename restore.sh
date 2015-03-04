#!/bin/bash
# Author: Ismael Barros² <ismael@barros2.org>
# License: WTFPL (http://www.wtfpl.net/txt/copying/)

BACKUP="$1"
SITE="$2"

[ -n "$BACKUP" ] || { echo "Please specify a backup directory"; exit 1; }

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

echo "Restoring ${BACKUP} to ${SITE:-local}..."

[ -n "$USER" ] && cmd_user="-u $USER"
[ -n "$PASSWORD" ] && cmd_pass="-p $PASSWORD"
cmd="mongorestore $cmd_user $cmd_pass -h $HOST -d $DATABASE -drop $BACKUP"
echo "Running '${cmd}'..."
$cmd
