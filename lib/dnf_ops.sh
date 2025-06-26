#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

is_installed_dnf() {
    local package="$1"
    rpm -q "$package" &>/dev/null
}

install_dnf() {
    local package="$1"
    print_message "$YELLOW" "Installing $package from Fedora repositories..."
    run_with_sudo dnf install -y "$package"
}

remove_dnf() {
    local package="$1"
    print_message "$YELLOW" "Removing $package (keeping config files)..."
    run_with_sudo dnf remove -y "$package"
}

purge_dnf() {
    local package="$1"
    print_message "$YELLOW" "Purging $package (removing all files)..."
    run_with_sudo dnf remove -y "$package" && run_with_sudo dnf clean all
}

reinstall_dnf() {
    local package="$1"
    purge_dnf "$package" && install_dnf "$package"
}
