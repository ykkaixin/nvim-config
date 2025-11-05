-- Neovim Configuration
-- Main entry point

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Require Neovim 0.11+ for LSP (vim.lsp.config)
if vim.fn.has("nvim-0.11") == 0 then
    vim.api.nvim_echo({ { "This config requires Neovim >= 0.11.3 (LSP)", "ErrorMsg" } }, true, {})
    return
end

-- Load core configuration
require("core.options")
require("core.keymaps")

-- Load plugin manager and plugins
require("plugins")
