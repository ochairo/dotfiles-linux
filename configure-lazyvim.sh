#!/bin/bash

# configure-lazyvim.sh - Configure LazyVim with custom settings

echo "Configuring LazyVim..."

# Create custom plugin directory
mkdir -p "$HOME/.config/nvim-lazy/lua/custom/plugins"

# Add example custom plugin configuration
create_plugin_example() {
    cat > "$HOME/.config/nvim-lazy/lua/custom/plugins/example.lua" << 'EOL'
-- Example custom plugin configuration
return {
  -- Your custom plugins go here
}
EOL
}

# Configure LazyVim options
configure_options() {
    cat > "$HOME/.config/nvim-lazy/lua/config/options.lua" << 'EOL'
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- UI settings
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true   -- Relative line numbers
vim.opt.cursorline = true       -- Highlight current line
vim.opt.signcolumn = "yes"      -- Always show signcolumn
vim.opt.scrolloff = 8           -- Keep 8 lines above/below cursor
  
-- Indentation
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.tabstop = 2             -- Number of spaces tabs count for
vim.opt.shiftwidth = 2          -- Number of spaces for each indent
 
-- File handling
vim.opt.undofile = true         -- Save undo history
vim.opt.swapfile = false        -- No swap files
vim.opt.backup = false          -- No backup files
EOL
}

# Configure LazyVim keymaps
configure_keymaps() {
    cat > "$HOME/.config/nvim-lazy/lua/config/keymaps.lua" << 'EOL'
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
EOL
}

# Set up shell aliases
configure_aliases() {
    for shell_rc in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.bash_profile"; do
        if [ -f "$shell_rc" ]; then
            if ! grep -q "alias nvim-lazy" "$shell_rc"; then
                echo "Adding nvim-lazy alias to $shell_rc"
                echo -e "\n# LazyVim alias\nalias nvim-lazy='NVIM_APPNAME=nvim-lazy nvim'" >> "$shell_rc"
            fi
        fi
    done
}

# Execute all configuration functions
create_plugin_example
configure_options
configure_keymaps
configure_aliases

echo "LazyVim configuration complete!"
echo "To use LazyVim, run 'nvim-lazy' or 'NVIM_APPNAME=nvim-lazy nvim'"
