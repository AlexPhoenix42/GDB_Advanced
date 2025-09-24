#!/bin/bash

# Check if a program was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <program_to_run>"
  exit 1
fi

# Save PID and run Valgrind in foreground
bash -c "echo \$\$ > valgrind.pid; exec valgrind --vgdb=yes --vgdb-error=0 $1"
