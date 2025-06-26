#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

show_installation_menu() {
    local package="$1"
    echo -e "\n${BLUE}Installation options for: $package${NC}"
    echo -e "1) Install from Fedora repositories (dnf)"
    echo -e "2) Install from Flathub (flatpak)"
    echo -e "3) Cancel installation"
}

show_removal_menu() {
    local package="$1"
    local installer="$2"
    echo -e "\n${BLUE}Package $package is already installed via $installer${NC}"
    echo -e "${YELLOW}What would you like to do?${NC}"
    echo -e "1) Remove package (keep config files)"
    echo -e "2) Purge package (remove all files and data)"
    echo -e "3) Reinstall package"
    echo -e "4) Cancel and exit"
}

get_user_choice() {
    local min="$1"
    local max="$2"
    local prompt="$3"
    
    while true; do
        read -rp "$prompt " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge "$min" ] && [ "$choice" -le "$max" ]; then
            echo "$choice"
            return
        fi
        print_message "$RED" "Invalid choice. Please enter a number between $min and $max."
    done
}
