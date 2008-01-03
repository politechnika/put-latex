#!/bin/sh

if [ $# -lt 1 ]; then
  echo "Lists SSH-accessible hosts. Usage:"
  echo "$0 hosts_file"
  exit 1
fi

HOSTS=$1
shift

# Don't wait too long for inaccessible hosts.
SSH_OPTS="-o ConnectTimeout=2 -o BatchMode=yes"

TMP=`mktemp -t -d`
sed -e 's/#.*//' -e '/^[ \t]*$/d' $HOSTS > $TMP/hosts

for H in `cat $TMP/hosts`
do
  (ssh -q $SSH_OPTS $H "true" && echo $H ) > $TMP/$H.result &
done

wait

cat $TMP/*.result | sort

if [ -e $TMP ]; then
	rm -rf $TMP
fi
