return {
  {
    "folke/noice.nvim",
    opts = {
      notify = {
        enabled = false,
      },
    },
  },
  { "folke/noice.nvim", enabled = false }, -- popups
  { "rcarriga/nvim-notify", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  { "stevearc/dressing.nvim", enabled = false },
  { "lewis6991/gitsigns.nvim", enabled = false },
  { "folke/trouble.nvim", enabled = false }, -- shows errors from lsp etc
  { "SmiteshP/nvim-navic", enabled = false }, -- statusline/winbar component that uses LSP to show your current code context
  { "rafamadriz/friendly-snippets.nvim", enabled = false }, -- some snippets
  -- { "goolord/alpha-nvim", enabled = false },
}
