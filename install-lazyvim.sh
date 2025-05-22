#!/bin/bash

# install-lazyvim.sh - LazyVim installation script for Debian/Ubuntu systems

echo "Setting up LazyVim..."

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is required for LazyVim setup. Installing git..."
    sudo apt-get update && sudo apt-get install -y git
fi

# Create and prepare the LazyVim configuration directory
mkdir -p "$HOME/.config/nvim-lazy"

# Backup existing configuration if needed
if [ -d "$HOME/.config/nvim-lazy" ] && [ "$(ls -A "$HOME/.config/nvim-lazy")" ]; then
    BACKUP_DIR="$HOME/.config/nvim-lazy-backup-$(date +%Y%m%d-%H%M%S)"
    echo "Backing up existing LazyVim configuration to $BACKUP_DIR..."
    mkdir -p "$BACKUP_DIR"
    cp -r "$HOME/.config/nvim-lazy/." "$BACKUP_DIR/"
    rm -rf "$HOME/.config/nvim-lazy"/*
fi

# Install LazyVim
echo "Installing LazyVim..."
git clone --depth=1 https://github.com/LazyVim/starter ~/.config/nvim-lazy
rm -rf ~/.config/nvim-lazy/.git
mkdir -p ~/.config/nvim-lazy/lua/custom/plugins

# Add simple custom configurations directly in this script

# Custom plugin configuration
cat > ~/.config/nvim-lazy/lua/custom/plugins/example.lua << 'EOL'
-- Every plugin spec file needs to return a table
-- This file shows an example of a plugin spec and plugin configuration

return {
  -- Add your custom plugins here
  -- Example:
  -- {
  --   "github-username/plugin-name",
  --   event = "VeryLazy",
  --   config = function()
  --     -- Plugin configuration
  --   end,
  --   dependencies = {
  --     -- Plugin dependencies
  --   }
  -- }
}
EOL

# Custom configuration for LazyVim
cat > ~/.config/nvim-lazy/lua/config/options.lua << 'EOL'
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- UI settings
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true   -- Relative line numbers
vim.opt.cursorline = true       -- Highlight current line
vim.opt.termguicolors = true    -- True color support
vim.opt.signcolumn = "yes"      -- Always show signcolumn

-- Indentation
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.tabstop = 2             -- Number of spaces tabs count for
vim.opt.shiftwidth = 2          -- Number of spaces for each indent
vim.opt.smartindent = true      -- Smart autoindenting

-- Search
vim.opt.ignorecase = true       -- Ignore case in search patterns
vim.opt.smartcase = true        -- Override ignorecase if search contains uppercase

-- File handling
vim.opt.undofile = true         -- Save undo history
vim.opt.swapfile = false        -- No swap files
vim.opt.backup = false          -- No backup files
vim.opt.writebackup = false     -- No backup when writing

-- Editing experience
vim.opt.scrolloff = 8           -- Lines of context
vim.opt.sidescrolloff = 8       -- Columns of context
vim.opt.wrap = false            -- Don't wrap lines
EOL

cat > ~/.config/nvim-lazy/lua/config/keymaps.lua << 'EOL'
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Quick save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
EOL

echo "LazyVim setup complete!"
echo "To use LazyVim, run 'NVIM_APPNAME=nvim-lazy nvim' or create an alias."

# Create convenient alias in various shell configs if they exist
for shell_rc in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.bash_profile"; do
    if [ -f "$shell_rc" ]; then
        if ! grep -q "alias nvim-lazy" "$shell_rc"; then
            echo "Adding nvim-lazy alias to $shell_rc"
            echo -e "\n# LazyVim alias\nalias nvim-lazy='NVIM_APPNAME=nvim-lazy nvim'" >> "$shell_rc"
        fi
    fi
done
