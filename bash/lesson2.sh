#!/bin/bash
# Habrahabr bash script lessons
# https://habrahabr.ru/company/ruvds/blog/325928

# IFS variable defines which symbol will be used as new line signal
#FILE=/etc/passwd
#IFS=$'\n'
#for VAR in $(cat $FILE) ; do
#	echo "$VAR"
#done

#for FILE in /home/gg/* ; do
#	if [ -d "$FILE" ] ; then
#		echo "$FILE is a directory"
#	elif [ -f "$FILE" ] ; then
#		echo "$FILE is a file"
#	fi
#done

VAR=5
while [ $VAR -gt 0 ] ; do
	echo $VAR
	VAR=$[ $VAR - 1 ]
done