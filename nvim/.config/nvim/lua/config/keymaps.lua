-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.g.mapleader = " "
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = True })
vim.keymap.set("n", "<leader>d", [[:Copilot disable<CR>]], { noremap = True })
vim.keymap.set("n", "<leader>s", [[:Copilot enable<CR>]], { noremap = True })
-- vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
local set = vim.opt
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

vim.api.nvim_create_user_command("CC", function(args)
  vim.cmd("CopilotChat " .. args.args)
end, { nargs = "*" })

vim.api.nvim_create_user_command("CCR", function(args)
  vim.cmd("CopilotChatReset " .. args.args)
end, { nargs = "*" })

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- Create command to enable Copilot
vim.api.nvim_create_user_command("CopilotEnable", function()
  print("Copilot ON")
  vim.g.copilot_enabled = true
  vim.cmd("Copilot enable")
end, { nargs = 0 })

-- Create command to disable Copilot
vim.api.nvim_create_user_command("CopilotDisable", function()
  vim.g.copilot_enabled = false
  vim.cmd("Copilot disable")
  print("Copilot OFF")
end, { nargs = 0 })

-- Map the commands to leader+a and leader+d respectively
vim.keymap.set("n", "<leader>a", ":CopilotEnable<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d", ":CopilotDisable<CR>", { noremap = true, silent = true })

vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#00d9ca" })

-- run :Copilot enable with <C-E> in insert mode, there is no function called copilot#Enable
-- vim.keymap.set("n", "<F1>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<F2>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<F3>", "<Nop>", { noremap = true, silent = true })

-- vim.keymap.set("i", "<F1>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<F2>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<F3>", "<Nop>", { noremap = true, silent = true })

-- vim.keymap.set("v", "<F1>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("v", "<F2>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("v", "<F3>", "<Nop>", { noremap = true, silent = true })
