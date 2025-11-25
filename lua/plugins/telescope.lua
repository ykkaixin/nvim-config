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

-- ⭐ IntelliJ IDEA 完全兼容快捷键（Mac）
-- 搜索和导航
keymap.set("n", "<D-o>", "<cmd>Telescope find_files<cr>", { desc = "Go to File (Cmd+O)" })
keymap.set("n", "<D-S-o>", "<cmd>Telescope find_files<cr>", { desc = "Go to File (Cmd+Shift+O)" })
keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Go to File (Ctrl+P, 兼容 VSCode)" })

-- Cmd+Shift+F: 在项目中查找
keymap.set("n", "<D-S-f>", "<cmd>Telescope live_grep<cr>", { desc = "Find in Files (Cmd+Shift+F)" })
keymap.set("n", "<C-S-f>", "<cmd>Telescope live_grep<cr>", { desc = "Find in Files (Ctrl+Shift+F)" })

-- Cmd+F: 在当前文件中查找
keymap.set("n", "<D-f>", "/", { desc = "Find in File (Cmd+F)" })
keymap.set("n", "<C-f>", "/", { desc = "Find in File (Ctrl+F)" })

-- Cmd+E: 最近文件
keymap.set("n", "<D-e>", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files (Cmd+E)" })
keymap.set("n", "<C-e>", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files (Ctrl+E)" })

-- Cmd+Shift+E: 最近编辑的位置
keymap.set("n", "<D-S-e>", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Locations (Cmd+Shift+E)" })

-- Cmd+Shift+A: 查找操作
keymap.set("n", "<D-S-a>", "<cmd>Telescope commands<cr>", { desc = "Find Action (Cmd+Shift+A)" })
keymap.set("n", "<C-S-a>", "<cmd>Telescope commands<cr>", { desc = "Find Action (Ctrl+Shift+A)" })

-- Cmd+B: 跳转到定义（Go to Declaration）
keymap.set("n", "<D-b>", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to Definition (Cmd+B)" })
keymap.set("n", "<C-b>", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to Definition (Ctrl+B)" })

-- Cmd+Alt+B: 跳转到实现
keymap.set("n", "<D-M-b>", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "Go to Implementation (Cmd+Alt+B)" })
keymap.set("n", "<C-M-b>", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "Go to Implementation (Ctrl+Alt+B)" })

-- Cmd+[: 返回（Navigate Back）
keymap.set("n", "<D-[>", "<C-o>", { desc = "Navigate Back (Cmd+[)" })
keymap.set("n", "<C-[>", "<C-o>", { desc = "Navigate Back (Ctrl+[)" })

-- Cmd+]: 前进（Navigate Forward）
keymap.set("n", "<D-]>", "<C-i>", { desc = "Navigate Forward (Cmd+])" })
keymap.set("n", "<C-]>", "<C-i>", { desc = "Navigate Forward (Ctrl+])" })

-- Cmd+G: 跳转到行
keymap.set("n", "<D-g>", ":", { desc = "Go to Line (Cmd+G)" })
keymap.set("n", "<C-g>", ":", { desc = "Go to Line (Ctrl+G)" })

-- 标准快捷键（Space leader，作为备选）
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
