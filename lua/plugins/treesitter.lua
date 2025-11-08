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

  -- ⭐ IntelliJ-style text objects for quick code manipulation
  textobjects = {
    select = {
      enable = true,
      lookahead = true,  -- Automatically jump forward to textobj
      keymaps = {
        -- Function operations
        ["af"] = "@function.outer",  -- Select around function
        ["if"] = "@function.inner",  -- Select inside function
        -- Class operations
        ["ac"] = "@class.outer",     -- Select around class
        ["ic"] = "@class.inner",     -- Select inside class
        -- Parameter/argument operations
        ["aa"] = "@parameter.outer", -- Select around argument
        ["ia"] = "@parameter.inner", -- Select inside argument
        -- Block operations
        ["ab"] = "@block.outer",     -- Select around block
        ["ib"] = "@block.inner",     -- Select inside block
      },
    },
    move = {
      enable = true,
      set_jumps = true,  -- Add to jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",  -- Jump to next function
        ["]c"] = "@class.outer",     -- Jump to next class
        ["]a"] = "@parameter.outer", -- Jump to next argument
      },
      goto_next_end = {
        ["]F"] = "@function.outer",  -- Jump to end of next function
        ["]C"] = "@class.outer",     -- Jump to end of next class
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",  -- Jump to previous function
        ["[c"] = "@class.outer",     -- Jump to previous class
        ["[a"] = "@parameter.outer", -- Jump to previous argument
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",  -- Jump to end of previous function
        ["[C"] = "@class.outer",     -- Jump to end of previous class
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sa"] = "@parameter.inner",  -- Swap with next argument
      },
      swap_previous = {
        ["<leader>sA"] = "@parameter.inner",  -- Swap with previous argument
      },
    },
  },
})
