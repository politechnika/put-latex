#!/bin/sh

hook_usage_head="Executes the command in parallel."
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
	( ssh $SSH_OPTS $H "$SSH_REMOTE_CMD" && touch $TMP/$H.ok || touch $TMP/$H.failed ) >$TMP/$H.result 2>&1 &
}

hook_afterall_hosts() {
	wait

	if [ ! $quiet ]; then
		for OUT in $TMP/*.result; do
			H=`basename $OUT .result`
			if [ -e $TMP/$H.ok ]; then
				echo "--- $H OK:"
			else
				echo "--- $H FAILED:"
			fi
			cat $OUT
		done
		echo
	fi

	# Calculate summary
	GOOD=`ls $TMP/*.ok  2>/dev/null | wc -l`
	BAD=`ls $TMP/*.failed 2>/dev/null | wc -l`
	echo "$GOOD successful, $BAD failed."
}

. rshrunner.sh
