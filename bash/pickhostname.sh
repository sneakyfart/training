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
#  Uncomment next line if you want to turn debug mode ON
#set -x

# =========================
# === STATIC PARAMETERS ===
# =========================
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
	if [[ -f $AVAIL_HOSTNAMES ]]; then
		if [[ -r $AVAIL_HOSTNAMES ]]; then
			if [[ -s $AVAIL_HOSTNAMES ]]; then
				echo "INFO: $AVAIL_HOSTNAMES file is present, checking $INUSE_HOSTNAME..."
				if [[ -f $INUSE_HOSTNAMES ]]; then
					if [[ -w $INUSE_HOSTNAMES ]]; then
						echo "INFO: Everything seems to be OK for now. Continuing..."
					else
						echo "ERROR: unable to write to $INUSE_HOSTNAMES. Does it have correct permissions?"
					fi
				else
					touch $INUSE_HOSTNAMES
					if [[ -f $INUSE_HOSTNAME ]]; then
						echo "INFO: Everything seems to be OK for now. Continuing..."
					else
						echo "ERROR: unable to create $INUSE_HOSTNAMES. Do you have correct access rights?"
						exit 1
					fi
				fi
			else
				echo "ERROR: file $AVAIL_HOSTNAMES is empty. Unable to proceed. Did you run out of hostnames?"
				exit 1
			fi
		else
			echo "ERROR: unable to read contents of $AVAIL_HOSTNAMES. Does it have correct permissions?"
			exit 1
		fi
	else
		echo "ERROR: file $AVAIL_HOSTNAMES doesn't exist. Did you configure the script properly?"
		exit 1
	fi
}

#  Function pick_and_cut picks desired number of hostnames
#+ from $AVAIL_HOSTNAMES file and then puts them into
#+ $INUSE_HOSTNAMES. Then result is shown to a user.
pick_and_cut(){
	HOSTNAME=`shuf -n $NUMBER $AVAIL_HOSTNAMES`
	sed -i -e '/$HOSTNAME/{w $INUSE_HOSTNAMES' -e 'd}' $AVAIL_HOSTNAMES
	echo "$HOSTNAME"
}

detect_command(){
	if [[ -n "$1" ]]; then # check if 1st argument is present
		case $1 in
			"pick") # case 1st argument is a "pick" command
					if [ -n "$2" ] ; then # check if 2nd argument is present
						if [[ "$2" =~ ^[-+]?[0-9]+$ ]] ; then # check if 2nd argument is a number
							NUMBER=`echo $2 | sed -e "s/[^[:digit:]]//g"`
							pick_and_cut
						else # if 2nd argument isn't a number
							NUMBER=1
							pick_and_cut
						fi
					else # if 2nd argument isn't present
						NUMBER=1
						pick_and_cut
					fi
					;;
			"reset") # and it is "reset" command
					cat $INUSE_HOSTNAMES >> $AVAIL_HOSTNAMES
					> $INUSE_HOSTNAMES
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
}

# ===================
# === MAIN SCRIPT ===
# ===================
check_file
ARGS=( $@ )

#detect_command