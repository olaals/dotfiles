vim.keymap.set("n", "<leader>d", [[:Copilot disable<CR>]], { noremap = True })
vim.keymap.set("n", "<leader>s", [[:Copilot enable<CR>]], { noremap = True })

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
