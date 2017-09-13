#!/bin/bash
# Habrahabr bash script lessons
# https://habrahabr.ru/company/ruvds/blog/325522
# I'm also using unset to reuse variables

CURR_DIR1=`pwd`
echo "Current directory is $CURR_DIR1"
CURR_DIR2=$(pwd)
echo "Current directory is $CURR_DIR2"
unset CURR_DIR1 CURR_DIR2

# Time to do some math
VAR1=5
VAR2=4
SUMM=$(($VAR1+$VAR2))
MLTPL=$(($VAR1*$VAR2))
echo "SUMM is $SUMM"
echo "MLTPL is $MLTPL"
unset VAR1 VAR2 SUMM MLTPL

# if-then statement
if pwd 
then
	echo "It works!"
fi
# Another try
if pwd ; then
	echo "It works again!"
fi

# if-then-else statement
USR=gg
if grep $USR /etc/passwd ; then
	echo "User $USR exists"
else
	echo "User $USR doesn't exist"
fi
unset USR

# if-then-elif statement
USR=ggg
if grep $USR /etc/passwd ; then
	echo "User $USR exists"
elif ls /home | grep $USR ; then
	echo "User $USR doesn't exist but there is a $USR directory under /home"
else
	echo "User $USR doesn't exist and there is no $USR directory under /home"
fi
unset USR

# Numbers comparison
VAR1=4
VAR2=5
if [ $VAR1 -eq $VAR2 ] ; then
	echo "$VAR1 = $VAR2"
elif [ $VAR1 -lt $VAR2 ] ; then
	echo "$VAR1 < $VAR2"
elif [ $VAR1 -le $VAR2 ] ; then
	echo "$VAR1 <= $VAR2"
elif [ $VAR1 -gt $VAR2 ] ; then
	echo "$VAR1 > $VAR2"
elif [ $VAR1 -ge $VAR2 ] ; then
	echo "$VAR1 >= $VAR2"
else
	echo "$VAR1 != $VAR2"
fi
unset VAR1 VAR

# String comparison
USR=ggg
if [ $USR = $USER ] ; then
	echo "User $USR is the current logged in user"
else
	echo "User $USR is not the current logged in user"
fi
unset USR
