#!/bin/bash
TASK=$1
FILE=$2

shift ; shift

for host in $@
do
  ssh $host rm -rf $FILE
  scp -r $FILE $host:
  ssh $host $FILE/$TASK.sh
done
