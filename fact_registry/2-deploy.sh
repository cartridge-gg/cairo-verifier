#!/usr/bin/env zsh

# Check if the arguments are provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <class-hash>"
    exit 1
fi

# Assign argument to variable
class_hash=$1

# Pass the class hash to the sncast command
sncast --wait deploy --class-hash "$class_hash"
