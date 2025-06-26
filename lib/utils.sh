#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/config.sh"

# Function to print colored messages
print_message() {
    local color="$1"
    shift
    echo -e "${color}$*${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" &>/dev/null
}

# Function to run with sudo if needed
run_with_sudo() {
    if [ "$(id -u)" -ne 0 ]; then
        sudo "$@"
    else
        "$@"
    fi
}
