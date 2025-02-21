# Cross-Platform Dotfiles with Ansible

This repository contains my personal dotfiles and development environment setup, managed using Ansible for cross-platform compatibility. It provides a consistent development environment across MacOS, Linux, and Windows (WSL) systems.

## Overview

This dotfiles repository uses Ansible to automate the setup and configuration of:
- Shell environment (zsh with custom configurations)
- Text editors (Neovim)
- Terminal multiplexer (tmux)
- Git configuration
- Programming language environments
- Platform-specific tools and utilities

## Prerequisites

Before setting up these dotfiles, ensure you have:

- Git (2.28 or newer)
- Ansible (core 2.13 or newer)
- MacOS: `brew install ansible`
- Linux: `sudo apt install ansible` or equivalent
- Windows: Install WSL2 first, then follow Linux instructions
- Python 3.8 or newer

## Directory Structure

```
.
├── ansible/
│   ├── playbooks/         # Main automation playbooks
│   ├── roles/            # Role-based configurations
│   ├── group_vars/       # Environment-specific variables
│   └── host_vars/        # Host-specific variables
├── config/
│   ├── nvim/            # Neovim configuration
│   ├── tmux/            # Tmux configuration
│   ├── zsh/             # Zsh configuration files
│   └── git/             # Git configuration and templates
└── scripts/             # Utility scripts
```

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Run the setup script:
```bash
./scripts/setup.sh
```

3. Run the Ansible playbook:
```bash
ansible-playbook ansible/playbooks/setup.yml
```

## Customization

### Adding New Configurations

1. Create a new role in `ansible/roles/`:
```bash
ansible-galaxy init ansible/roles/new-tool
```

2. Add your configuration files to the role's `files/` or `templates/` directory

3. Define tasks in `tasks/main.yml`

4. Add the role to the main playbook

### Modifying Existing Configurations

- Shell (zsh): Edit `config/zsh/.zshrc`
- Neovim: Modify files in `config/nvim/`
- Tmux: Update `config/tmux/tmux.conf`
- Git: Adjust `config/git/gitconfig`

## Platform-Specific Notes

### MacOS

- Automatically installs Homebrew if not present
- Configures MacOS-specific settings via `defaults write`
- Installs GUI applications via Homebrew Cask

### Linux

- Supports Debian/Ubuntu and RHEL/CentOS
- Handles package manager differences automatically
- Configures specific Linux utilities and tools

### Windows (WSL)

- Requires Windows Subsystem for Linux 2
- Additional setup steps for Windows interoperability
- Handles path conversions and permissions

## Troubleshooting

### Common Issues

1. **Ansible Connection Errors**
- Ensure SSH keys are properly set up
- Check that ansible_connection is set to 'local' for local deployment

2. **Platform-Specific Problems**
- MacOS: Check XCode Command Line Tools installation
- Linux: Verify package manager and repositories
- WSL: Ensure WSL2 is properly configured

### Getting Help

If you encounter any issues:
1. Check the [Issues](https://github.com/yourusername/dotfiles/issues) page
2. Create a new issue with:
- Your OS and version
- Error messages
- Steps to reproduce

## Updates and Maintenance

To update your environment:
```bash
cd ~/.dotfiles
git pull
ansible-playbook ansible/playbooks/setup.yml
```

Regular maintenance tasks are automated through Ansible playbooks. Run the update playbook periodically to keep your environment current.


I was a little tired of having long alias files and everything strewn about
(which is extremely common on other dotfiles projects, too). That led to this
project being much more topic-centric. I realized I could split a lot of things
up into the main areas I used (Ruby, git, system libraries, and so on), so I
structured the project accordingly.

If you're interested in the philosophy behind why projects like these are
awesome, you might want to [read my post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## what's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork it](https://github.com/holman/dotfiles/fork), remove what you don't
use, and build on what you do use.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## install

Run this:

```sh
git clone https://github.com/holman/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

## bugs

I want this to work for everyone; that means when you clone it down it should
work for you even though you may not have `rbenv` installed, for example. That
said, I do use this as _my_ dotfiles, so there's a good chance I may break
something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/holman/dotfiles/issues) on this repository
and I'd love to get it fixed for you!

## thanks

I forked [Ryan Bates](http://github.com/ryanb)' excellent
[dotfiles](http://github.com/ryanb/dotfiles) for a couple years before the
weight of my changes and tweaks inspired me to finally roll my own. But Ryan's
dotfiles were an easy way to get into bash customization, and then to jump ship
to zsh a bit later. A decent amount of the code in these dotfiles stem or are
inspired from Ryan's original project.
