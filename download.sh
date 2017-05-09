#!/bin/bash

if [ $# -lt 2 ];
then
	(>&2 echo "Usage: pessimism [url] [file]")
	exit 1
fi

url=$1
output_file=$2
tmp_file=$(mktemp)

retcode=$( curl $url > $tmp_file )

if [ ! $retcode == 0 ];
then
	(>&2 echo "CURL returned an error.")
	exit 1
fi

if [ ! -f $tmp_file ];
then
	(>&2 echo "Nothing downloaded.")
	exit 1
fi

if [ ! -s $tmp_file ];
then
	(>&2 echo "No error, but no data either.")
	rm $tmp_file
	exit 1
fi

cp $tmp_file $output_file
rm $tmp_file

(>&2 echo "Data downloaded to $output_file")
