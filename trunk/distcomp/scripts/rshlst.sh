#!/bin/bash

hook_usage_head="Lists SSH-accessible hosts."
hook_usage_args=""

hook_specific_args() {
	# forbid host keys being added
	SSH_STRICT_HK=yes
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
