#!/bin/bash

# install.sh - Dotfiles installation script

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

echo "Installing dotfiles from $DOTFILES_DIR"
echo "Backing up existing dotfiles to $BACKUP_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to install packages for Debian/Ubuntu systems
install_packages() {
    if command -v apt-get >/dev/null 2>&1; then
        echo "Installing essential packages with apt..."
        sudo apt-get update
        sudo apt-get install -y \
            build-essential \
            git \
            curl \
            wget \
            vim \
            neovim \
            tmux \
            zsh \
            zsh-syntax-highlighting \
            zsh-autosuggestions \
            htop \
            tree \
            neofetch \
            ack \
            ripgrep \
            fd-find \
            bat \
            unzip
            
        # Install Oh-My-Zsh for better Zsh experience
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
            echo "Installing Oh-My-Zsh..."
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        fi
        
        # Set Zsh as default shell if it's not already
        if [ "$SHELL" != "$(which zsh)" ]; then
            echo "Setting Zsh as default shell..."
            chsh -s $(which zsh)
            echo "NOTE: You may need to log out and log back in for shell change to take effect."
        fi
    else
        echo "apt-get not found. This script is intended for Debian/Ubuntu systems."
        echo "Please install the following packages manually:"
        echo "git, curl, wget, vim, neovim, tmux, zsh, htop, tree, neofetch, ack, ripgrep, fd-find, bat, unzip"
    fi
}

# Function to backup and link a file
backup_and_link() {
    local src="$1"
    local dst="$2"
    local name="$(basename "$dst")"
    
    # Backup if file exists
    if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]; then
        echo "Backing up $dst to $BACKUP_DIR/$name"
        mv "$dst" "$BACKUP_DIR/$name"
    fi
    
    # Create symbolic link
    echo "Linking $src to $dst"
    ln -s "$src" "$dst"
}

# Backup and link dotfiles
backup_and_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
backup_and_link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
backup_and_link "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
backup_and_link "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
backup_and_link "$DOTFILES_DIR/.inputrc" "$HOME/.inputrc"

# Create additional directories if necessary
mkdir -p "$HOME/.zsh"
mkdir -p "$HOME/.config/nvim-lazy"

# Install LazyVim directly
echo "Setting up LazyVim..."
# Check if git is installed (needed for LazyVim)
if ! command -v git &> /dev/null; then
    echo "Git is required for LazyVim setup. Installing git..."
    sudo apt-get update && sudo apt-get install -y git
fi

# Set up LazyVim
mkdir -p "$HOME/.config/nvim-lazy"
if [ -d "$HOME/.config/nvim-lazy" ] && [ "$(ls -A "$HOME/.config/nvim-lazy")" ]; then
    echo "Backing up existing LazyVim configuration..."
    mkdir -p "$BACKUP_DIR/nvim-lazy"
    cp -r "$HOME/.config/nvim-lazy/." "$BACKUP_DIR/nvim-lazy/"
    rm -rf "$HOME/.config/nvim-lazy"/*
fi

echo "Installing LazyVim..."
git clone --depth=1 https://github.com/LazyVim/starter ~/.config/nvim-lazy
rm -rf ~/.config/nvim-lazy/.git
mkdir -p ~/.config/nvim-lazy/lua/custom/plugins

# Add LazyVim alias to shell config files
for shell_rc in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.bash_profile"; do
    if [ -f "$shell_rc" ]; then
        if ! grep -q "alias nvim-lazy" "$shell_rc"; then
            echo "Adding nvim-lazy alias to $shell_rc"
            echo -e "\n# LazyVim alias\nalias nvim-lazy='NVIM_APPNAME=nvim-lazy nvim'" >> "$shell_rc"
        fi
    fi
done

# Install essential packages on Linux
echo "Checking for package dependencies..."
install_packages

echo "Dotfiles installation complete!"
echo "NOTE: You may want to customize the settings in .gitconfig, particularly your name and email."
