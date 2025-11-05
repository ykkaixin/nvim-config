-- LSP Configuration
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Enable Mason
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- Mason LSP config
mason_lspconfig.setup({
  ensure_installed = {
    "pyright",       -- Python
    "lua_ls",        -- Lua
    "tsserver",      -- TypeScript/JavaScript
    "html",          -- HTML
    "cssls",         -- CSS
    "jsonls",        -- JSON
    "bashls",        -- Bash
  },
  automatic_installation = true,
})

-- Capabilities for autocompletion
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

-- Diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- On attach function for LSP keymaps
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap

  -- LSP keymaps
  keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
  keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
  keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show hover information" }))
  keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
  keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Show signature help" }))
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
  keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
  keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Show references" }))
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
  keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
  keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
  keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend("force", opts, { desc = "Format document" }))
end

-- Python LSP (Pyright)
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
})

-- Lua LSP
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- TypeScript/JavaScript LSP
lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- HTML LSP
lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- CSS LSP
lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- JSON LSP
lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Bash LSP
lspconfig.bashls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
