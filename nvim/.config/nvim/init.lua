require("config.lazy")
vim.opt.conceallevel = 0

local function style_shell_errors()
  -- Option A (recommended): link to your theme's DiagnosticError style
  vim.api.nvim_set_hl(0, "ErrorMsg", { link = "DiagnosticError" })
  vim.api.nvim_set_hl(0, "WarningMsg", { link = "DiagnosticWarn" })

  -- Option B: explicitly remove the background (uncomment if you want this instead)
  -- vim.api.nvim_set_hl(0, "ErrorMsg", { bg = "NONE" })
end

-- Apply now + re-apply after :colorscheme changes (themes often override highlights)
style_shell_errors()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = style_shell_errors,
})
