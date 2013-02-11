#!/usr/bin/env bash

sitefile=/opt/sitecheck/sites.txt
sitelog=/opt/sitecheck/sites.log
curlopts="--silent \
	--max-time 10 \
	--location \
	--max-redirs 10 \
	--output /dev/null"

function check()
{
	status=`curl $curlopts --write-out "%{http_code}\n" "$1" 2>> /dev/null`
	if [ "$status" == "200" ]; then
		return 0
	else
		return 1
	fi
}

function check_and_report()
{
	date=`date --iso-8601=seconds --utc`
	if check "$1"; then
		result=OK
	else
		result=FAIL
	fi
	echo "$date $1 $result" >> $sitelog
}

if [ -e "$sitefile" ]; then
	while read site; do
		check_and_report "$site"
	done < "$sitefile"
else
	echo "Sites file does not exist"
	exit 1
fi
