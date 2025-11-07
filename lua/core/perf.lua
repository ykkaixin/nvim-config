-- Performance Optimizations
-- Fixes CPU 100% usage issues with multiple nvim processes

-- Disable unnecessary providers to prevent background process leaks
-- This is the main fix for multiple nvim processes consuming 100% CPU
vim.g.loaded_python_provider = 0  -- Disable Python 2
vim.g.loaded_python3_provider = 0 -- Disable Python 3 (comment out if you need Python plugins)
vim.g.loaded_ruby_provider = 0    -- Disable Ruby
vim.g.loaded_perl_provider = 0    -- Disable Perl
vim.g.loaded_node_provider = 0    -- Disable Node.js

-- Note: If you need Python plugins (like some LSP servers), uncomment this line:
-- vim.g.loaded_python3_provider = 1

-- Syntax highlighting limits (prevent performance issues with long lines)
vim.opt.synmaxcol = 200           -- Limit syntax highlighting to 200 columns
vim.opt.maxmempattern = 2000      -- Limit memory used for pattern matching

-- Large file detection and optimization
local aug = vim.api.nvim_create_augroup("LargeFile", { clear = true })
vim.api.nvim_create_autocmd("BufReadPre", {
    group = aug,
    callback = function()
        local file = vim.fn.expand("<afile>")
        local size = vim.fn.getfsize(file)
        -- If file is larger than 1MB or size is -2 (error)
        if size > 1024 * 1024 or size == -2 then
            -- Disable heavy features for large files
            vim.opt_local.eventignore:append("FileType")
            vim.opt_local.swapfile = false
            vim.opt_local.bufhidden = "unload"
            vim.opt_local.undolevels = -1
            vim.cmd("syntax off")
        end
    end,
})

-- Python file specific optimizations
local py_aug = vim.api.nvim_create_augroup("PythonPerf", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = py_aug,
    pattern = "python",
    callback = function()
        -- Use simpler folding method for better performance
        vim.opt_local.foldmethod = "indent"
        vim.opt_local.foldlevel = 99
    end,
})

-- Cursorline optimization: only enable in normal mode
local cursorline_aug = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
    group = cursorline_aug,
    callback = function()
        vim.opt.cursorline = false
    end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    group = cursorline_aug,
    callback = function()
        vim.opt.cursorline = true
    end,
})
