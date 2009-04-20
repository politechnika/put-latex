#!/bin/bash

##########
# This file contains common code used in rsh* set of commands.
#
# If you want to write a custom script using this predefined code, you have to:
# * define the following "hook" functions
#   - hook_specific_args(): for reading additional parameters from the command
#     line, after the default ones has been read, or for modifying variables
#     (see below). If reading additional command line parameters, $params_cnt
#     must be set to their number.
#   - hook_foreach_host(): what actions to perform for a single host. The most
#     common is to run ssh command (see examples). Host name is received in $H.
#   - hook_afterall_hosts(): additional actions (like waiting for ssh sessions
#     to end, cleanup) performed after `serving' the last host.
# * define help-connected variables: $hook_usage_head for one-liner describing
#   scripts role, and $hook_usage_args for one-liner listing script-specific
#   command line arguments
# * source this file, like
#     . rshrunner.sh
#
# If a specific hook is not required, it can be as simple as:
#   hook_something() ;
# but it must occur.
#
# Variables, which are defined and used in this helper:
# SSH_KNOWN_HOSTS -- if set, defines the hosts public key file to be used;
#   optional in the command line, can be overriden
# SSH_USER -- defines username to use on SSH connections. Defaults to current
#   user's login; optional in the command line, can be overriden
# quiet -- loosely-defined flag for quiet output. Optional in the command line,
#   can be overriden
# SSH_COMMON_OPTS -- default options for SSH, hardcoded, can be overriden
# HOSTS -- file keeping the list of hosts to operate on; set only after
#   hook_specific_args()
# SSH_STRICT_HK -- whether it is forbidden to add new keys to the key file.
#   Defaults to system-wide setting (usually: ask for permission, which is
#   the same as denying in batch mode). When not explicitly set and
#   SSH_KNOWN_HOSTS is set, this is forced to be 'yes'. Can be overriden.
# TMP -- temporary directory, can be used to store e.g. partial results. Read
#   only, set only after hook_specific_args().
# H -- the host currently being processed. Read-only, available in
#   hook_foreach_host().
##########

# Parses command line options, which are common to all rsh* commands
# and sets useful variables
parse_common_opts() {
	SSH_KNOWN_HOSTS=''
	SSH_USER=$USER

	params_cnt=0
	while [[ $1 = -* ]]; do
		p=1
		case $1 in
			(-q | --quiet)
				quiet=true
				;;
			--ssh)
				SSH_KNOWN_HOSTS="$2"
				p=2
				;;
			--user)
				SSH_USER="$2"
				p=2
				;;
			--help)
				print_usage
				exit 0
				;;
			*)
				echo "Ignoring unknown option: $1" 1>&2
				;;
		esac
		shift $p
		params_cnt=$((params_cnt+p))
	done
}

# Prints program usage
print_usage() {
	echo $hook_usage_head 1>&2
	echo "Usage: $0 [ --help ] [ --quiet | -q ] [ --ssh known_hosts ] [ --user username ] hosts_file $hook_usage_args" 1>&2
}


##########
# Run

SSH_COMMON_OPTS="-q -o ConnectTimeout=3 -o BatchMode=yes"

parse_common_opts $@
shift $params_cnt

if [ $# -lt 1 ]; then
  print_usage
  exit 1
fi

HOSTS=$1
shift

params_cnt=0
hook_specific_args $@
shift $params_cnt

SSH_OPTS="$SSH_COMMON_OPTS -l $SSH_USER"
if [ "$SSH_KNOWN_HOSTS" != "" ]; then
	SSH_OPTS="$SSH_OPTS -o UserKnownHostsFile=$SSH_KNOWN_HOSTS"
	if [ "$SSH_STRICT_HK" == "" ]; then
		SSH_STRICT_HK=yes
	fi
fi

if [ "$SSH_STRICT_HK" != "" ]; then
	SSH_OPTS="$SSH_OPTS -o StrictHostKeyChecking=$SSH_STRICT_HK"
fi

TMP=`mktemp -t -d`
sed -e 's/#.*//' -e '/^[ \t]*$/d' $HOSTS > $TMP/hosts

for H in `cat $TMP/hosts`; do
	hook_foreach_host
done

hook_afterall_hosts

if [ -e $TMP ]; then
	rm -rf $TMP
fi

exit 0;

