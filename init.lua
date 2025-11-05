-- Neovim Configuration
-- Main entry point

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configuration
require("core.options")
require("core.keymaps")

-- Load plugin manager and plugins
require("plugins")
