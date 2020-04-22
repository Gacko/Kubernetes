#!/bin/bash
# Define stage and task.
stage="$1"
task="$2"
# Shift arguments.
shift ; shift

# Execute task on hosts.
for host in $@
do
  # Remove existing stage files.
  ssh "$host" "rm -rf $stage"
  # Transfer new stage files.
  scp -r "$stage" "$host:"
  # Execute task.
  ssh "$host" "$stage/$task.sh"
done
