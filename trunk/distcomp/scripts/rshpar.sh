#!/bin/sh

if [ $# -lt 2 ]; then
  echo "Executes the command in parallel. Usage:"
  echo "$0 [ -q | --quiet ] hosts_file remote_command"
  exit 1
fi

if [ "$1" == "-q" -o "$1" == "--quiet" ]; then
  quiet=true
  shift
fi

HOSTS=$1
shift

SSH_OPTS="-o ConnectTimeout=2 -o BatchMode=yes"

TMP=`mktemp -t -d`
sed -e 's/#.*//' -e '/^[ \t]*$/d' $HOSTS > $TMP/hosts

for H in `cat $TMP/hosts`
do
    ( ssh -q $SSH_OPTS $H "$*" && touch $TMP/$H.ok || touch $TMP/$H.failed ) >$TMP/$H.result 2>&1 &
done

wait

if [ ! $quiet ]; then
    for OUT in `ls $TMP/*.result`
    do
        H=`basename $OUT .result`
        if [ -e $TMP/$H.ok ]; then
            echo "--- $H OK:"
            cat $OUT
        else
            echo "--- $H FAILED:"
            cat $OUT
        fi
    done
    echo
fi

# Calculate summary
GOOD=`ls -l $TMP/*.ok  2>/dev/null | wc -l`
BAD=`ls -l $TMP/*.failed 2>/dev/null | wc -l`
echo "$GOOD successful, $BAD failed."

if [ -e $TMP ]; then
	rm -rf $TMP
fi
