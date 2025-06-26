#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

setup_flatpak_aliases() {
    # Directory for bashrc.d scripts
    local BASH_RC_D="$HOME/.bashrc.d"
    local ALIAS_FILE="$BASH_RC_D/flatpak-aliases.sh"
    
    mkdir -p "$BASH_RC_D"

    # Create a temporary file for new aliases
    local TMP_FILE
    TMP_FILE=$(mktemp) || {
        print_message "$RED" "Failed to create temporary file"
        return 1
    }

    # Get installed flatpaks (ID, Name)
    while IFS=$'\t' read -r app_id app_name; do
        alias_name=$(echo "$app_name" | \
                    tr '[:upper:]' '[:lower:]' | \
                    tr ' ' '-' | \
                    tr -cd '[:alnum:]-')
        [ -z "$alias_name" ] && continue
        echo "alias $alias_name='flatpak run $app_id'" >> "$TMP_FILE"
    done < <(flatpak list --app --columns=application,name 2>/dev/null)

    if [ -s "$TMP_FILE" ]; then
        mv "$TMP_FILE" "$ALIAS_FILE" || {
            print_message "$RED" "Failed to create alias file"
            return 1
        }
        chmod +x "$ALIAS_FILE"
        print_message "$GREEN" "Flatpak aliases updated in $ALIAS_FILE"
    else
        print_message "$YELLOW" "No Flatpak apps found for alias generation"
        rm -f "$TMP_FILE"
        return 1
    fi

    # Ensure ~/.bashrc sources ~/.bashrc.d/
    if ! grep -q "~/.bashrc.d/" ~/.bashrc; then
        echo -e "\n# Source all scripts in ~/.bashrc.d" >> ~/.bashrc
        echo 'for file in ~/.bashrc.d/*.sh; do [ -f "$file" ] && . "$file"; done' >> ~/.bashrc
        print_message "$BLUE" "Added ~/.bashrc.d sourcing to ~/.bashrc"
    fi

    # Source the new aliases
    if [ -f ~/.bashrc ]; then
        # shellcheck source=/dev/null
        source ~/.bashrc
        print_message "$GREEN" "Aliases sourced successfully"
    else
        print_message "$YELLOW" "Warning: ~/.bashrc not found. Restart your shell to apply changes"
    fi
}

update_flatpak_aliases() {
    if command_exists flatpak; then
        setup_flatpak_aliases
    else
        print_message "$YELLOW" "Flatpak not installed - skipping alias generation"
    fi
}
