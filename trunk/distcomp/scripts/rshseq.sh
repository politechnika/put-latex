#!/bin/sh

if [ $# -lt 2 ]; then
  echo "Executes the command sequentially. Usage:"
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
    if [ ! $quiet ]; then
        echo "--- $H:"
        ( ssh -q $SSH_OPTS $H "$*" && touch $TMP/$H.ok || touch $TMP/$H.failed ) 2>&1
    else
        ( ssh -q $SSH_OPTS $H "$*" && touch $TMP/$H.ok || touch $TMP/$H.failed ) >/dev/null 2>&1

        if [ -e $TMP/$H.ok ]; then echo -n "."; else echo -n "x"; fi
    fi
done

# Calculate summary
GOOD=`ls -l $TMP/*.ok  2>/dev/null | wc -l`
BAD=`ls -l $TMP/*.failed 2>/dev/null | wc -l`
echo
echo "$GOOD successful, $BAD failed."

if [ -e $TMP ]; then
	rm -rf $TMP
fi
