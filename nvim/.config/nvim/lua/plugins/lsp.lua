return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              procMacro = {
                ignored = {
                  leptos_macro = {
                    "server",
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
