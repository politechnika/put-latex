#!/bin/sh

hook_usage_head="Feeds SSH's known_hosts with a list of hosts."
hook_usage_args=""

hook_specific_args() {
	# allow host keys being added without asking
	SSH_STRICT_HK=no
}

hook_foreach_host() {
	( ssh $SSH_OPTS $H "true" && echo $H ) > $TMP/$H.result &
}

hook_afterall_hosts() {
	wait
	cat $TMP/*.result | sort
}

d=`dirname $0`
. "$d/rshrunner.sh"
