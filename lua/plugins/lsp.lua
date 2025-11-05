-- Neovim 0.11+ is required (guarded in init.lua). Use new API directly.

-- Diagnostics (global)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Diagnostics: open float' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Diagnostics: previous' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Diagnostics: next' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics: loclist' })

-- Improve completion capabilities for nvim-cmp
local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
local capabilities = vim.lsp.protocol.make_client_capabilities()
if ok_cmp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- on_attach: buffer-local mappings when LSP attaches
local function on_attach(_, bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts) -- avoid <C-k> conflict
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
end

pcall(function() require('neodev').setup({}) end)

-- Prefer the modern name by default (ts_ls)
local ts_server = 'ts_ls'

-- Build server list and per-server opts
local servers = { 'lua_ls', 'pyright', ts_server, 'rust_analyzer', 'gopls' }
local function make_opts(server)
  local opts = { on_attach = on_attach, capabilities = capabilities }
  if server == 'lua_ls' then
    opts.settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        diagnostics = { globals = { 'vim' } },
        telemetry = { enable = false },
      },
    }
  elseif server == 'pyright' then
    opts.settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'workspace',
          typeCheckingMode = 'basic',
        },
      },
    }
  elseif server == 'ts_ls' or server == 'tsserver' then
    opts.init_options = {
      preferences = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    }
  end
  return opts
end

-- Mason UI (manual install via :Mason)
pcall(function()
  require('mason').setup()
end)

-- Define and enable configs directly
for _, server in ipairs(servers) do
  vim.lsp.config(server, make_opts(server))
  vim.lsp.enable(server)
end
