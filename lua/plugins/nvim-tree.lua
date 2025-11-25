-- Nvim-tree Configuration (File Explorer)
-- ⭐ 使用漂亮的图标和现代化风格
require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  respect_buf_cwd = true,
  sync_root_with_cwd = true,
  view = {
    width = 35,
    relativenumber = true,
    side = "left",
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = true,
    full_name = false,
    highlight_opened_files = "icon", -- 高亮打开的文件图标
    root_folder_label = ":~:s?$?/..?", -- 更简洁的根目录显示
    indent_width = 2,
    -- ✨ 更漂亮的缩进线
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    -- ✨ 更现代的图标配置
    icons = {
      webdev_colors = true, -- 使用文件类型对应的颜色
      git_placement = "before",
      modified_placement = "after",
      padding = " ",
      symlink_arrow = " ➜ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
      },
      glyphs = {
        default = "󰈚", -- 更漂亮的默认文件图标
        symlink = "",
        bookmark = "󰆤",
        modified = "●",
        folder = {
          arrow_closed = "", -- 更圆润的箭头
          arrow_open = "",
          default = "󰉋", -- 更现代的文件夹图标
          open = "󰝰",
          empty = "󰉖",
          empty_open = "󰷏",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗", -- 未暂存
          staged = "✓", -- 已暂存
          unmerged = "", -- 冲突
          renamed = "➜", -- 重命名
          untracked = "★", -- 未跟踪
          deleted = "", -- 已删除
          ignored = "◌", -- 已忽略
        },
      },
    },
    -- ✨ 添加特殊文件高亮
    special_files = {
      "Cargo.toml",
      "Makefile",
      "README.md",
      "readme.md",
      "package.json",
    },
  },
  filters = {
    dotfiles = false,
    custom = { ".DS_Store", "node_modules", ".cache" },
    exclude = { ".env", ".gitignore" }, -- 显示这些点文件
  },
  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
    timeout = 400,
  },
  -- ✨ 文件操作时的确认提示
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  -- ✨ 更新频率
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
  },
})

-- Keymaps
local keymap = vim.keymap

-- 主要快捷键（多个选项，选择你喜欢的）
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer (Ctrl+n, VSCode style)" })
keymap.set("n", "<M-m>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer (Alt+m, 需要配置终端)" })

-- 其他文件树操作
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
