-- Telescope Configuration (Fuzzy Finder)
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
    file_ignore_patterns = {
      "node_modules",
      ".git/",
      "dist",
      "build",
      "*.pyc",
      "__pycache__",
    },
    layout_config = {
      horizontal = {
        preview_width = 0.55,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
})

-- Load extensions
telescope.load_extension("fzf")

-- Keymaps
local keymap = vim.keymap

-- 标准快捷键
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics" })

-- ⭐ IntelliJ 风格快捷键（Mac 友好）
-- Shift+Shift -> 全局搜索（Search Everywhere）
-- 由于双击 Shift 难以实现，使用 Cmd+P (Mac) 或 Ctrl+P 作为替代
keymap.set("n", "<D-p>", "<cmd>Telescope find_files<cr>", { desc = "Search files (Cmd+P, IntelliJ style)" })
keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Search files (Ctrl+P, VSCode/IntelliJ style)" })

-- Shift+Cmd+F -> 在项目中查找（Find in Files）
keymap.set("n", "<D-S-f>", "<cmd>Telescope live_grep<cr>", { desc = "Find in files (Cmd+Shift+F, IntelliJ style)" })
keymap.set("n", "<C-S-f>", "<cmd>Telescope live_grep<cr>", { desc = "Find in files (Ctrl+Shift+F)" })

-- Shift+Cmd+R -> 替换功能（或者用作文件搜索的变体）
keymap.set("n", "<D-S-r>", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files (Cmd+Shift+R, IntelliJ style)" })
keymap.set("n", "<C-S-r>", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files (Ctrl+Shift+R)" })

-- Cmd+E -> 最近文件（Recent Files）
keymap.set("n", "<D-e>", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files (Cmd+E, IntelliJ style)" })
keymap.set("n", "<C-e>", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files (Ctrl+E)" })

-- Cmd+Shift+A -> 查找操作（Actions）
keymap.set("n", "<D-S-a>", "<cmd>Telescope commands<cr>", { desc = "Find commands (Cmd+Shift+A, IntelliJ style)" })
keymap.set("n", "<C-S-a>", "<cmd>Telescope commands<cr>", { desc = "Find commands (Ctrl+Shift+A)" })
