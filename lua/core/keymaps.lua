-- Keymaps
local keymap = vim.keymap

-- General keymaps
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Navigate between splits
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left split" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to bottom split" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to top split" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right split" })

-- Tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Buffer navigation (barbar.nvim)
keymap.set("n", "<S-h>", "<cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<S-l>", "<cmd>BufferNext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>bd", "<cmd>BufferClose<CR>", { desc = "Delete buffer" })

-- Barbar additional keymaps
keymap.set("n", "<leader>bp", "<cmd>BufferPin<CR>", { desc = "Pin/unpin buffer" })
keymap.set("n", "<leader>bc", "<cmd>BufferCloseAllButCurrent<CR>", { desc = "Close all but current buffer" })
keymap.set("n", "<leader>bca", "<cmd>BufferCloseAllButPinned<CR>", { desc = "Close all but pinned buffers" })
keymap.set("n", "<leader>bl", "<cmd>BufferCloseBuffersLeft<CR>", { desc = "Close all buffers to the left" })
keymap.set("n", "<leader>br", "<cmd>BufferCloseBuffersRight<CR>", { desc = "Close all buffers to the right" })

-- Goto buffer in position...
keymap.set("n", "<leader>1", "<cmd>BufferGoto 1<CR>", { desc = "Go to buffer 1" })
keymap.set("n", "<leader>2", "<cmd>BufferGoto 2<CR>", { desc = "Go to buffer 2" })
keymap.set("n", "<leader>3", "<cmd>BufferGoto 3<CR>", { desc = "Go to buffer 3" })
keymap.set("n", "<leader>4", "<cmd>BufferGoto 4<CR>", { desc = "Go to buffer 4" })
keymap.set("n", "<leader>5", "<cmd>BufferGoto 5<CR>", { desc = "Go to buffer 5" })
keymap.set("n", "<leader>6", "<cmd>BufferGoto 6<CR>", { desc = "Go to buffer 6" })
keymap.set("n", "<leader>7", "<cmd>BufferGoto 7<CR>", { desc = "Go to buffer 7" })
keymap.set("n", "<leader>8", "<cmd>BufferGoto 8<CR>", { desc = "Go to buffer 8" })
keymap.set("n", "<leader>9", "<cmd>BufferGoto 9<CR>", { desc = "Go to buffer 9" })
keymap.set("n", "<leader>0", "<cmd>BufferLast<CR>", { desc = "Go to last buffer" })

-- Re-order buffers
keymap.set("n", "<A-<>", "<cmd>BufferMovePrevious<CR>", { desc = "Move buffer left" })
keymap.set("n", "<A->>", "<cmd>BufferMoveNext<CR>", { desc = "Move buffer right" })

-- Buffer pick mode (like quick switch)
keymap.set("n", "<leader>bb", "<cmd>BufferPick<CR>", { desc = "Pick buffer" })

-- Better indenting
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Stay in visual mode when pasting
keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Better up/down movement for wrapped lines
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Save file
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Quit
keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Quit all without saving" })

-- ⭐ IntelliJ-style variable navigation (vim-illuminate)
-- Jump between highlighted references of word under cursor
keymap.set("n", "]]", function() require("illuminate").goto_next_reference(false) end, { desc = "Next reference" })
keymap.set("n", "[[", function() require("illuminate").goto_prev_reference(false) end, { desc = "Previous reference" })

-- ============================================
-- 📝 Markdown 快捷键
-- ============================================

-- Markdown 预览（浏览器）
keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Markdown: 打开浏览器预览" })
keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { desc = "Markdown: 关闭浏览器预览" })
keymap.set("n", "<leader>mt", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown: 切换浏览器预览" })

-- Markdown 实时渲染（编辑器内，像 Typora）
keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", { desc = "Markdown: 切换实时渲染（Typora 模式）" })

-- 表格模式
keymap.set("n", "<leader>tm", "<cmd>TableModeToggle<CR>", { desc = "Markdown: 切换表格模式" })
keymap.set("n", "<leader>tr", "<cmd>TableModeRealign<CR>", { desc = "Markdown: 重新对齐表格" })

-- Markdown 导航（仅在 markdown 文件中生效）
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- 跳转到标题
    keymap.set("n", "]]", "<Plug>Markdown_MoveToNextHeader", { buffer = true, desc = "下一个标题" })
    keymap.set("n", "[[", "<Plug>Markdown_MoveToPreviousHeader", { buffer = true, desc = "上一个标题" })
    keymap.set("n", "][", "<Plug>Markdown_MoveToNextSiblingHeader", { buffer = true, desc = "下一个同级标题" })
    keymap.set("n", "[]", "<Plug>Markdown_MoveToPreviousSiblingHeader", { buffer = true, desc = "上一个同级标题" })
    keymap.set("n", "]c", "<Plug>Markdown_MoveToCurHeader", { buffer = true, desc = "当前标题" })
    keymap.set("n", "]u", "<Plug>Markdown_MoveToParentHeader", { buffer = true, desc = "父级标题" })

    -- 格式化
    keymap.set("n", "<leader>mb", "viw<esc>a**<esc>bi**<esc>", { buffer = true, desc = "Markdown: 加粗" })
    keymap.set("v", "<leader>mb", "<esc>`>a**<esc>`<i**<esc>", { buffer = true, desc = "Markdown: 加粗" })
    keymap.set("n", "<leader>mi", "viw<esc>a*<esc>bi*<esc>", { buffer = true, desc = "Markdown: 斜体" })
    keymap.set("v", "<leader>mi", "<esc>`>a*<esc>`<i*<esc>", { buffer = true, desc = "Markdown: 斜体" })
    keymap.set("n", "<leader>mc", "viw<esc>a`<esc>bi`<esc>", { buffer = true, desc = "Markdown: 代码" })
    keymap.set("v", "<leader>mc", "<esc>`>a`<esc>`<i`<esc>", { buffer = true, desc = "Markdown: 代码" })

    -- 链接
    keymap.set("n", "<leader>ml", "viw<esc>a]()<esc>bi[<esc>", { buffer = true, desc = "Markdown: 创建链接" })
    keymap.set("v", "<leader>ml", "<esc>`>a]()<esc>`<i[<esc>", { buffer = true, desc = "Markdown: 创建链接" })

    -- 插入
    keymap.set("n", "<leader>mh", "I# <esc>", { buffer = true, desc = "Markdown: 插入 H1" })
    keymap.set("n", "<leader>mH", "I## <esc>", { buffer = true, desc = "Markdown: 插入 H2" })
    keymap.set("n", "<leader>m-", "I- <esc>", { buffer = true, desc = "Markdown: 插入列表项" })
    keymap.set("n", "<leader>m[", "I- [ ] <esc>", { buffer = true, desc = "Markdown: 插入复选框" })

    -- 目录
    keymap.set("n", "<leader>mo", "<cmd>Toc<CR>", { buffer = true, desc = "Markdown: 显示目录" })
  end,
})
