-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.g.mapleader = " "
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = True })
-- vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

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

vim.api.nvim_set_keymap("n", "<leader>ce", ":lua CopyLintError()<CR>", { noremap = true, silent = true })

function CopyLintError()
  local diagnostics = vim.diagnostic.get()
  local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local current_col = vim.api.nvim_win_get_cursor(0)[2]

  for _, diag in ipairs(diagnostics) do
    if diag.lnum == current_line and diag.col <= current_col then
      vim.fn.setreg("+", diag.message) -- Copies to the system clipboard
      print("Copied error to clipboard: " .. diag.message)
      return
    end
  end

  print("No error found at cursor position.")
end
