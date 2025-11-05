-- AI Autocomplete Configuration (Codeium)
-- Codeium is a free AI-powered autocomplete alternative to GitHub Copilot

-- Codeium keymaps
vim.g.codeium_disable_bindings = 1

vim.keymap.set("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true, desc = "Accept Codeium suggestion" })

vim.keymap.set("i", "<C-]>", function()
  return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, silent = true, desc = "Next Codeium suggestion" })

-- Avoid mapping <C-[> because it's equivalent to <Esc> and breaks Vim mode
vim.keymap.set("i", "<C-\\>", function()
  return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true, desc = "Previous Codeium suggestion" })

vim.keymap.set("i", "<C-x>", function()
  return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true, desc = "Clear Codeium suggestion" })

-- Note: On first use, you'll need to authenticate Codeium
-- Run :Codeium Auth to authenticate
-- It's free and works similar to GitHub Copilot
