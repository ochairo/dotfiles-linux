# Linux Dotfiles

This repository contains my personal dotfiles for Linux environments. These configuration files help set up a consistent development environment across different machines.

## Included Configurations

- `.zshrc` - Z shell configuration with Oh-My-Zsh
- `.vimrc` - Vim editor configuration
- LazyVim - Modern Neovim distribution
- `.gitconfig` - Git configuration
- `.gitignore_global` - Global Git ignore patterns
- `.tmux.conf` - Tmux terminal multiplexer configuration
- `.inputrc` - Readline configuration for command-line editing

## Installation

You can install these dotfiles by cloning the repository and running the installation script:

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles-linux.git
cd dotfiles-linux

# Make the install script executable
chmod +x install.sh

# Run the install script
./install.sh
```

The installation script will:
1. Create backups of your existing dotfiles
2. Create symbolic links from this repository to your home directory
3. Install essential packages on Linux systems (git, vim, neovim, tmux, etc.)
4. Install and configure Zsh with Oh-My-Zsh as the default shell
5. Set up LazyVim, a modern Neovim distribution

## Customization

### Git Configuration

Make sure to update your Git user information in `.gitconfig`:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Shell-specific Configuration

- For Bash-specific customizations, add them to `~/.bashrc.d/` directory
- For Zsh-specific customizations, add them to `~/.zsh/` directory or `~/.zshrc.local`

## Features

### Zsh with Oh-My-Zsh
- Automatic Zsh installation and configuration
- Oh-My-Zsh for improved shell experience
- Improved command history
- Useful aliases
- Better tab completion
- Directory navigation shortcuts

### Vim
- Syntax highlighting
- Line numbers
- Improved search
- Space-based indentation (4 spaces)
- Mouse support in terminal

### Neovim with LazyVim
- Modern Lua-based configuration
- Lazy-loading for fast startup
- Rich plugin ecosystem pre-configured
- LSP, completion, and syntax highlighting
- Installed and configured automatically
- Accessible via `nvim-lazy` alias (default editor)

### Tmux
- Mouse support
- Improved key bindings
- Status bar customization
- Session management shortcuts

### Git
- Useful aliases
- Better diffs
- Improved conflict resolution

## Updating

To update your dotfiles, simply pull the latest changes from the repository:

```bash
cd path/to/dotfiles-linux
git pull
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
