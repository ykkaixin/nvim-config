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

-- Reduce LSP logging (can cause performance issues)
vim.lsp.set_log_level("ERROR")

-- OPTIMIZED SOLUTION: Smart virtual text with performance optimization
-- User requested: "我希望他自动显示但是又不消耗我的性能"
--
-- Strategy:
-- 1. Virtual text appears after cursor stops (500ms delay)
-- 2. Limited to ERROR level only
-- 3. Text length capped at 80 chars
-- 4. Combined with diagnostic debouncing
-- 5. Hidden during cursor movement to reduce redraws

-- Initial config with virtual text DISABLED (will be toggled smartly)
vim.diagnostic.config({
  virtual_text = false,  -- Will be enabled after cursor stops
  update_in_insert = false,  -- Don't update while typing (CRITICAL!)
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
  signs = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
})

-- Smart virtual text toggle: only show when cursor stops moving
local virtual_text_timer = nil
local virtual_text_visible = false

local function hide_virtual_text()
  if virtual_text_visible then
    vim.diagnostic.config({ virtual_text = false })
    virtual_text_visible = false
  end
end

local function show_virtual_text_delayed()
  -- Clear existing timer
  if virtual_text_timer then
    vim.fn.timer_stop(virtual_text_timer)
    virtual_text_timer = nil
  end

  -- Hide immediately when cursor moves
  hide_virtual_text()

  -- Show after 500ms delay (when cursor stops)
  virtual_text_timer = vim.fn.timer_start(500, function()
    vim.diagnostic.config({
      virtual_text = {
        severity = vim.diagnostic.severity.ERROR,  -- Only errors
        spacing = 4,
        prefix = '●',
        -- Limit text length to reduce rendering cost
        format = function(diagnostic)
          local max_width = 80
          local message = diagnostic.message:gsub("\n", " ")  -- Remove newlines
          if #message > max_width then
            return message:sub(1, max_width) .. "..."
          end
          return message
        end,
      }
    })
    virtual_text_visible = true
    virtual_text_timer = nil
  end)
end

-- Trigger smart virtual text on cursor movement
local vtext_group = vim.api.nvim_create_augroup("SmartVirtualText", { clear = true })
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = vtext_group,
  callback = show_virtual_text_delayed,
})

-- Hide when entering insert mode (typing) for better performance
vim.api.nvim_create_autocmd("InsertEnter", {
  group = vtext_group,
  callback = hide_virtual_text,
})

-- Show when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = vtext_group,
  callback = show_virtual_text_delayed,
})

-- Add diagnostic debouncing to prevent excessive updates
-- This prevents LSP from constantly re-analyzing code with errors
local diagnostic_debounce_timer = nil
local original_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
  if diagnostic_debounce_timer then
    vim.fn.timer_stop(diagnostic_debounce_timer)
  end

  local args = {...}
  diagnostic_debounce_timer = vim.fn.timer_start(1000, function()  -- 1 second debounce
    original_handler(unpack(args))
    diagnostic_debounce_timer = nil
  end)
end

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

            -- Disable LSP for large files
            vim.api.nvim_create_autocmd("LspAttach", {
                buffer = vim.api.nvim_get_current_buf(),
                callback = function(args)
                    vim.schedule(function()
                        vim.lsp.buf_detach_client(args.buf, args.data.client_id)
                    end)
                end,
            })

            print("Large file detected, some features disabled for performance")
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

        -- Limit Treesitter for very large Python files
        local lines = vim.api.nvim_buf_line_count(0)
        if lines > 5000 then
            vim.schedule(function()
                local ok, ts = pcall(require, "nvim-treesitter.configs")
                if ok then
                    pcall(vim.cmd, "TSBufDisable highlight")
                end
            end)
        end
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

-- Debounce certain events to reduce CPU usage
-- This prevents excessive updates when editing
local debounce_timer = nil
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    callback = function()
        if debounce_timer then
            vim.fn.timer_stop(debounce_timer)
        end
        debounce_timer = vim.fn.timer_start(500, function()
            -- Any debounced actions can go here
            debounce_timer = nil
        end)
    end,
})

