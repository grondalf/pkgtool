#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"
source "$(dirname "${BASH_SOURCE[0]}")/config.sh"

is_installed_flatpak() {
    local package="$1"
    flatpak list --app | grep -q "$package"
}

install_flatpak() {
    if ! command -v flatpak &>/dev/null; then
        read -rp "Flatpak is not installed. Would you like to install it now? (y/n) " install_flatpak
        if [[ "$install_flatpak" =~ ^[Yy]$ ]]; then
            print_message "$YELLOW" "Installing flatpak..."
            run_with_sudo dnf install flatpak -y || return 1
            flatpak remote-add --if-not-exists flathub "$FLATHUB_REPO" || return 1
        else
            return 1
        fi
    fi
    return 0
}

install_flatpak_pkg() {
    local package="$1"
    print_message "$YELLOW" "Installing $package from Flathub..."
    flatpak install -y flathub "$package"
}

remove_flatpak() {
    local package="$1"
    print_message "$YELLOW" "Removing $package flatpak..."
    flatpak uninstall -y "$package"
}

purge_flatpak() {
    local package="$1"
    print_message "$YELLOW" "Purging $package flatpak..."
    flatpak uninstall --delete-data -y "$package"
}

reinstall_flatpak() {
    local package="$1"
    purge_flatpak "$package" && install_flatpak_pkg "$package"
}
