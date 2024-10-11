local chat = require("CopilotChat")

vim.api.nvim_create_user_command("CC", function(args)
  local win_id = vim.api.nvim_get_current_win()
  local line1 = vim.fn.line("'<")
  local line2 = vim.fn.line("'>")

  local selected_text = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
  if line1 == 0 and line2 == 0 then
    line1 = vim.fn.line(".")
    line2 = line1
    vim.cmd("mark <")
    vim.cmd("mark >")
  end
  local joined_text = table.concat(selected_text, "\n") -- Join selected lines with newline
  chat.ask(joined_text .. "\n\n My prompt: \n" .. args.args) -- Concatenate with args.args
  vim.api.nvim_set_current_win(win_id)
  vim.cmd("delmarks < >")
  -- todo: clear selection buffer
end, { range = true, nargs = "*" })

vim.api.nvim_create_user_command("CCR", function(args)
  vim.cmd("CopilotChatReset " .. args.args)
end, { nargs = "*" })
