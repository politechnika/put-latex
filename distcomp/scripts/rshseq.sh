#!/bin/bash

hook_usage_head="Executes the command sequentially."
hook_usage_args="remote_command"

hook_specific_args() {
	if [ $# -lt 1 ]; then
		print_usage
		exit 1
	fi
	
	# slurp the rest of command line
	SSH_REMOTE_CMD="$*"
	params_cnt=$#
}

hook_foreach_host() {
	if [ ! $quiet ]; then
		echo "--- $H:"
		( ssh $SSH_OPTS $H "$SSH_REMOTE_CMD" && touch $TMP/$H.ok || touch $TMP/$H.failed ) 2>&1
	else
		( ssh $SSH_OPTS $H "$SSH_REMOTE_CMD" && touch $TMP/$H.ok || touch $TMP/$H.failed ) >/dev/null 2>&1
		if [ -e $TMP/$H.ok ]; then echo -n "."; else echo -n "x"; fi
    fi
}

hook_afterall_hosts() {
# Calculate summary
	# Calculate summary
	GOOD=`ls $TMP/*.ok  2>/dev/null | wc -l`
	BAD=`ls $TMP/*.failed 2>/dev/null | wc -l`
	echo "$GOOD successful, $BAD failed."
}

d=`dirname $0`
. "$d/rshrunner.sh"
