-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  --{"github/copilot.vim"},
  {"carlsmedstad/vim-bicep"},
  { "ellisonleao/gruvbox.nvim" },
  {
    "TobinPalmer/pastify.nvim",
    cmd = "Pastify",
    lazy = true,
    config = function()
      require("pastify").setup({
        opts = {
          local_path = "/assets/images", 
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  }
}
