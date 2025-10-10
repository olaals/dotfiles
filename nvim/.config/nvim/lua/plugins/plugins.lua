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
  
   --k {"github/copilot.vim", config = function() require("copilot").setup() end},
  { "ellisonleao/gruvbox.nvim" },
{
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
        -- your configuration comes here; leave empty for default settings
    },

},
  { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
      system_prompt = require("config.constants").COPILOT_PROMPT
    }
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    -- Prefer opts in LazyVim; Lazy will call configs.setup(opts) for you
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc",
        "python", "json", "yaml", "bash",
        "typescript", "tsx", "javascript",
        "markdown", "markdown_inline",
        "rust", "regex",
      },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = { enable = true },
    },
    -- If you are NOT using LazyVim's built-in handler, uncomment this:
    -- config = function(_, opts)
    --   require("nvim-treesitter.configs").setup(opts)
    -- end,
  },

    {
        "mason-org/mason.nvim",
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry"
            }
        },
        ensure_installed = {
            "roslyn",
            "csharpier",
            "rust-analyzer"
        }

    }
}
