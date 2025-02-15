-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
function run_script()
  local filetype = vim.bo.filetype
  if filetype == "python" then
    vim.cmd("!python3 %")
  elseif filetype == "javascript" then
    vim.cmd("!node %")
  elseif filetype == "typescript" then
    vim.cmd("!tsc --outdir tscbuild && node tscbuild/index.js %")
  elseif filetype == "rust" then
    vim.cmd("!cargo run")
  end
end

function run_tests()
  local filetype = vim.bo.filetype
  if filetype == "python" then
    vim.cmd("!python3 -m unittest")
  elseif filetype == "javascript" then
    vim.cmd("!npm test")
  elseif filetype == "typescript" then
    vim.cmd("!npm run test")
  elseif filetype == "rust" then
    vim.cmd("!cargo test")
  end
end

-- Define a custom command :J that maps to the run_script function
vim.cmd("command! J lua run_script()")
vim.cmd("command! T lua run_tests()")
-- vim.api.nvim_command("autocmd FileType python nnoremap :J :!python3 %<CR>")
-- vim.api.nvim_command("autocmd FileType typescript nnoremap :J :!tsc --outdir tscbuild && node tscbuild/index.js %<CR>")

local set = vim.opt
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.conceallevel = 0 -- Ensure code block markers are visible
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.bo.shiftwidth = 2 -- Number of spaces per indentation level
    vim.bo.tabstop = 2 -- Number of spaces per Tab
    vim.bo.expandtab = true -- Use spaces instead of tabs
    vim.bo.softtabstop = 2 -- Inserts 2 spaces when you press Tab
    vim.bo.smartindent = true -- Makes indentation smarter
    vim.bo.autoindent = true -- Auto-indent new lines
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePre" }, {
  pattern = "*",
  callback = function()
    vim.opt.fileformat = "unix"
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    -- Replace carriage return characters with an empty string
    vim.api.nvim_buf_set_lines(
      0,
      0,
      -1,
      false,
      vim.split(vim.fn.join(vim.fn.getline(1, "$"), "\n"):gsub("\r", ""), "\n")
    )
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function()
    local black_exists = vim.fn.executable("black") == 1

    if black_exists then
      vim.cmd("silent !black %")
    else
      vim.cmd("silent !uvx black %")
    end

    vim.cmd("edit")
  end,
})
