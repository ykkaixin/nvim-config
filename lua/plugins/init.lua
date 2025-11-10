-- Plugin Manager Setup (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  -- Color scheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        styles = {
          sidebars = "dark",
          floats = "dark",
        },
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.nvim-tree")
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("plugins.telescope")
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    config = function()
      require("plugins.lsp")
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("plugins.cmp")
    end,
  },

  -- AI Autocomplete (Codeium - free alternative to Copilot)
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      require("plugins.ai")
    end,
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",  -- IntelliJ-style code navigation
    },
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- ⭐ Variable highlighting (like IntelliJ) - BEST PLUGIN!
  -- Automatically highlights all instances of the word under cursor
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        -- Providers: LSP (best), treesitter, regex
        providers = {
          'lsp',
          'treesitter',
          'regex',
        },
        -- Delay before highlighting (milliseconds)
        delay = 100,
        -- File types to disable
        filetypes_denylist = {
          'dirbuf',
          'dirvish',
          'fugitive',
        },
        -- Don't highlight under cursor
        under_cursor = true,
        -- Minimum word length to highlight
        min_count_to_highlight = 1,
      })
    end,
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          component_separators = "|",
          section_separators = "",
        },
      })
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Comment plugin
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },

  -- Which-key for keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  -- Buffer line
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          separator_style = "slant",
        },
      })
    end,
  },

  -- ============================================
  -- 📝 Markdown 增强插件（最佳组合！）
  -- ============================================

  -- Markdown 预览（5.7k+ stars，最流行！）
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    config = function()
      require("plugins.markdown")
    end,
  },

  -- Markdown 编辑增强（4.3k+ stars）
  {
    "preservim/vim-markdown",
    ft = { "markdown" },
    config = function()
      -- 禁用默认键映射，我们自己配置
      vim.g.vim_markdown_no_default_key_mappings = 0
      -- 启用 YAML front matter
      vim.g.vim_markdown_frontmatter = 1
      -- 启用 TOML front matter
      vim.g.vim_markdown_toml_frontmatter = 1
      -- 启用 JSON front matter
      vim.g.vim_markdown_json_frontmatter = 1
      -- 自动折叠
      vim.g.vim_markdown_folding_disabled = 0
      -- 折叠级别
      vim.g.vim_markdown_folding_level = 2
      -- 代码块隐藏
      vim.g.vim_markdown_conceal_code_blocks = 0
      -- 新建列表项自动缩进
      vim.g.vim_markdown_new_list_item_indent = 2
      -- 自动保存目录
      vim.g.vim_markdown_toc_autofit = 1
      -- 高亮重点
      vim.g.vim_markdown_emphasis_multiline = 1
    end,
  },

  -- 表格编辑（1.5k+ stars）
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    config = function()
      -- 使用 Markdown 风格的表格
      vim.g.table_mode_corner = '|'
      -- 快速格式化表格
      vim.g.table_mode_auto_align = 1
    end,
  },

  -- 自动列表/项目符号管理（300+ stars）
  {
    "dkarter/bullets.vim",
    ft = { "markdown", "text", "gitcommit" },
    config = function()
      -- 启用的文件类型
      vim.g.bullets_enabled_file_types = {
        'markdown',
        'text',
        'gitcommit',
      }
      -- 启用 checkbox 切换
      vim.g.bullets_checkbox_markers = ' .oOX'
      -- 自动包装文本
      vim.g.bullets_set_mappings = 1
      -- 启用重新编号
      vim.g.bullets_renumber_on_change = 1
    end,
  },

  -- ⭐ 编辑器内实时渲染（像 Typora！）
  -- 在 nvim 内直接看到渲染效果，不需要浏览器
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("render-markdown").setup({
        -- 启用实时渲染
        enabled = true,
        -- 最大文件大小（MB）
        max_file_size = 1.5,
        -- 渲染模式
        render_modes = { "n", "c" },
        -- 标题样式
        heading = {
          -- 启用标题渲染
          enabled = true,
          -- 标题符号
          sign = true,
          -- 标题图标
          icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          -- 标题背景
          backgrounds = {
            "RenderMarkdownH1Bg",
            "RenderMarkdownH2Bg",
            "RenderMarkdownH3Bg",
            "RenderMarkdownH4Bg",
            "RenderMarkdownH5Bg",
            "RenderMarkdownH6Bg",
          },
        },
        -- 代码块样式
        code = {
          -- 启用代码块渲染
          enabled = true,
          -- 代码块符号
          sign = true,
          -- 代码块样式
          style = "full",
          -- 左侧填充
          left_pad = 2,
          -- 右侧填充
          right_pad = 2,
          -- 语言名称
          language_pad = 0,
          -- 禁用语言名称
          disable_background = { "diff" },
        },
        -- 项目符号样式
        bullet = {
          -- 启用项目符号渲染
          enabled = true,
          -- 不同层级的符号
          icons = { "●", "○", "◆", "◇" },
          -- 右对齐
          right_pad = 1,
        },
        -- Checkbox 样式
        checkbox = {
          -- 启用 checkbox 渲染
          enabled = true,
          -- Checkbox 图标
          unchecked = { icon = "󰄱 " },
          checked = { icon = "󰱒 " },
          custom = {
            todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
          },
        },
        -- 引用块样式
        quote = {
          -- 启用引用块渲染
          enabled = true,
          -- 引用符号
          icon = "▋",
          -- 重复次数
          repeat_linebreak = false,
        },
        -- 分隔线样式
        pipe_table = {
          -- 启用表格渲染
          enabled = true,
          -- 表格样式
          style = "full",
          -- 单元格填充
          cell = "padded",
        },
        -- 链接样式
        link = {
          -- 启用链接渲染
          enabled = true,
          -- 链接图标
          image = "󰥶 ",
          -- 邮件图标
          email = "󰀓 ",
          -- 超链接图标
          hyperlink = "󰌹 ",
          -- 高亮
          highlight = "RenderMarkdownLink",
        },
        -- 窗口配置
        win_options = {
          -- 隐藏模式
          conceallevel = {
            default = vim.api.nvim_get_option_value("conceallevel", {}),
            rendered = 3,
          },
          -- 隐藏光标行
          concealcursor = {
            default = vim.api.nvim_get_option_value("concealcursor", {}),
            rendered = "",
          },
        },
      })
    end,
  },
})
