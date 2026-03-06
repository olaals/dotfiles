-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local home = vim.env.HOME

local swap_dir = home .. "/.vim/swap//"
local backup_dir = home .. "/.vim/backup//"
local undo_dir = home .. "/.vim/undo//"

for _, dir in ipairs({ swap_dir, backup_dir, undo_dir }) do
  vim.fn.mkdir(dir:gsub("//$", ""), "p")
end

vim.opt.directory = { swap_dir }
vim.opt.backupdir = { backup_dir }
vim.opt.undodir = { undo_dir }

vim.opt.swapfile = true

vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.backupext = ".bak"

vim.opt.autowrite = false
vim.opt.autowriteall = false
