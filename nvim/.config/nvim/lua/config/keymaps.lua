-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.g.mapleader = " "
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = True })
-- vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
local set = vim.opt
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })

-- Open new window to the (left, down, up and right)
vim.api.nvim_set_keymap("n", "<leader>wnj", ":leftabove vsplit<CR>:enew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wnd", ":belowright split<CR>:enew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wnk", ":aboveleft split<CR>:enew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wnl", ":rightbelow vsplit<CR>:enew<CR>", { noremap = true, silent = true })

require("config.copilot")
require("config.copilotchat")
