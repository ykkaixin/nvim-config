-- Treesitter Configuration
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "python",
    "lua",
    "vim",
    "vimdoc",
    "javascript",
    "typescript",
    "html",
    "css",
    "json",
    "yaml",
    "bash",
    "markdown",
    "markdown_inline",
    "regex",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})
