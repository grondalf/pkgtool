# PKGTOOL - A Package Manager Wrapper

*A WIP CLI tool, made for personal use, for managing packages on Fedora Linux with DNF and Flatpak.*

## Disclaimer
This script is being developed for educarional pursposes with AI assistance to optimize functionality and user experience. It may contain bugs so use with caution.

## Features
- Installs either DNF (Fedora) or Flatpak packages.
- Auto-detects installed packages and their sources.
- Removes packages (by keeping config files) or purges them.
- Creates and updates handy terminal aliases for Flatpak apps.

## Installation steps

  1. Clone the repository: `git clone https://github.com/grondalf/pkgtool.git && cd pkgtool`
  2. Give the installer necessary permissions: `chmod +x setup`
  3. Run the installer: `./setup`
  4. Refresh your shell: `source ~/.bashrc`

## Usage

  ```bash
  pkgtool <package-name>
  ```

## Feature Roadmap

- [ ] Batch operations for installing or removing multiple packages at once.
- [ ] Support for other distributions and package managers.
- [ ] Distrobox support.

---
