#!/usr/bin/env bash

sitefile=sites.txt
sitelog=sites.log
curlopts="--silent \
	--max-time 10 \
	--location \
	--max-redirs 10 \
	--output /dev/null"
log_failures_only=0

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
	if [ "$log_failures_only" -eq "1" ]; then
		if [ "$result" == "FAIL" ]; then
			echo "$date $1 $result" >> $sitelog
		fi
	else
		echo "$date $1 $result" >> $sitelog
	fi
}

if [ -e "$sitefile" ]; then
	while read site; do
		check_and_report "$site"
	done < "$sitefile"
else
	echo "Sites file does not exist"
	exit 1
fi
