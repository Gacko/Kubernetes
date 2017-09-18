#!/bin/bash
# Define stage and task.
STAGE="$1"
TASK="$2"
# Shift arguments.
shift ; shift

# Execute task on hosts.
for host in $@
do
  # Remove existing stage files.
  ssh "$host" "rm -rf $STAGE"
  # Transfer new stage files.
  scp -r "$STAGE" "$host:"
  # Execute task.
  ssh "$host" "$STAGE/$TASK.sh"
done
