#!/bin/bash
FILE=$1
TASK=$2

shift ; shift

for host in $@
do
  ssh $host rm -rf $FILE
  scp -r $FILE $host:
  ssh $host $FILE/$TASK.sh
done
