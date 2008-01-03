#!/bin/sh

if [ $# -lt 2 ]; then
  echo "Usage:"
  echo "       rsh... [ -q | --quiet ] hosts_file remote_command"
  exit 1
fi

HOSTS=$1
shift

if [ "$1" = "-q" -o "$1" = "--quiet" ]; then
  quiet=true
  shift
fi

SSH_OPTS="-o ConnectTimeout=1"

sed -e 's/#.*//' -e '/^[ \t]*$/d' $HOSTS >.hosts.tmp
for H in `cat .hosts.tmp`
do
if [ ! $quiet ]; then
  ssh $SSH_OPTS $H "$*" && echo "OK on host $H"
else
  ssh $SSH_OPTS $H "$*" && echo "OK on host $H" || echo "Failure on host $H!"
fi
done
#wait
#echo "rsh... terminated"
