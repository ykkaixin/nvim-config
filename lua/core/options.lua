-- Neovim Options
local opt = vim.opt

-- Line numbers
opt.number = true
-- Disable relativenumber to reduce CPU usage (major performance improvement)
-- Relative line numbers require constant recalculation on every cursor move
-- opt.relativenumber = true  -- Uncomment if you really need it, but may cause CPU issues

-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Cursor line (optimized in lua/core/perf.lua to only show in normal mode)
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Consider - as part of keyword
opt.iskeyword:append("-")

-- Disable swapfile
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Undo
opt.undofile = true
opt.undolevels = 10000

-- Update time (increased to reduce CPU usage from frequent updates)
opt.updatetime = 2000  -- Increased from 250ms to 2000ms to reduce CPU usage
opt.timeoutlen = 300

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Performance
opt.lazyredraw = true

-- Mouse
opt.mouse = "a"

-- Scroll
opt.scrolloff = 8
opt.sidescrolloff = 8
