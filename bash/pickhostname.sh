#!/bin/bash
#
#  Training script for picking random hostname from $AVAIL_HOSTNAMES file
#+ and putting it into $INUSE_HOSTNAME file
#
#  Written by Yuferev Kirill
#  Version 0.1

# ==================
# === DEBUG MODE ===
# ==================
#  Uncomment next line if you want to turn debug mode ON.
#set -x

# =========================
# === STATIC PARAMETERS ===
# =========================
#  You'll need to modify next parameters if your
#+ files will be located somewhere else and/or
#+ have another name.
AVAIL_HOSTNAMES="available_hostnames"
INUSE_HOSTNAMES="inuse_hostnames"


# =================
# === FUNCTIONS ===
# =================
usage(){
	echo "ERROR: too few parameters"
	echo "Usage: $0 command [number of hostnames]"
	echo "Available commands: pick reset"
}

#  Function check_file checks if $AVAIL_HOSTNAMES file is present, 
#+ is it available to read by current user and is it empty. Then it
#+ checks if $INUSE_HOSTNAMES is present
check_file(){
	if [[ -f $AVAIL_HOSTNAMES ]] && [[ -r $AVAIL_HOSTNAMES ]] && [[ -s $AVAIL_HOSTNAMES ]]; then
	if test -f $AVAIL_HOSTNAMES && test -r $AVAIL_HOSTNAMES && test -s $AVAIL_HOSTNAMES; then
		echo "INFO: $AVAIL_HOSTNAMES file is present, checking $INUSE_HOSTNAME..."
	else
		echo "ERROR: something wrong with $AVAIL_HOSTNAMES file."
		echo "It is either not present or non-writable or empty. Unable to proceed."
		exit 1
	fi
	if [[ -f $INUSE_HOSTNAMES ]] && [[ -w $INUSE_HOSTNAMES ]]; then
		echo "INFO: everything seems to be OK for now. Continuing..."
	else
		echo "ERROR: something is wrong with $INUSE_HOSTNAMES file."
		echo "It is either not present or non-writable. Unable to proceed."
		exit 1
	fi
}

#  Function pick picks desired number of hostnames
#+ from $AVAIL_HOSTNAMES file and then puts them into
#+ $INUSE_HOSTNAMES. Then result is shown to a user.
pick(){
	HOSTNAME=`shuf -n $NUMBER $AVAIL_HOSTNAMES`
	sed -i -e '/$HOSTNAME/{w $INUSE_HOSTNAMES' -e 'd}' $AVAIL_HOSTNAMES
	echo "$HOSTNAME"
}

reset(){
	cat $INUSE_HOSTNAMES >> $AVAIL_HOSTNAMES
	> $INUSE_HOSTNAMES
}

# ===================
# === MAIN SCRIPT ===
# ===================
check_file
if [[ -n "$1" ]]; then # check if 1st argument is present
	case $1 in
		"pick") # case 1st argument is a "pick" command
				if [[ -n "$2" ]]; then # check if 2nd argument is present
					if [[ "$2" =~ ^[-+]?[0-9]+$ ]]; then # check if 2nd argument is a number
							NUMBER=`echo $2 | sed -e "s/[^[:digit:]]//g"`
							pick
						else # if 2nd argument isn't a number
							NUMBER=1
							pick
						fi
					else # if 2nd argument isn't present
						NUMBER=1
						pick
					fi
					;;
			"reset") # and it is "reset" command
					reset
					;;
			*)
					echo "ERROR: unknown command. Unable to proceed."
					echo "Available commands: pick reset"
					exit 1
		esac
	else # if no arguments are present
		usage
		exit 1
fi