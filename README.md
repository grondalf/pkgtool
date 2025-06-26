# PKGTOOL - A WIP Package Manager Wrapper

*A simple CLI tool, made for personal use, for managing packages on Fedora Linux with DNF and Flatpak.*

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

**Disclaimer:** *The script was developed with AI assistance to optimize functionality and user experience.*
