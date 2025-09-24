#!/bin/bash

# Check if a program was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <program_to_debug>"
  exit 1
fi

# Run GDB with the specified program and connect to Valgrind's vgdb
gdb "$1" -ex "target remote | vgdb --pid=$(cat valgrind.pid)"
