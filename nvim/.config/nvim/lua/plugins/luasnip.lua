-- ~/.config/nvim/lua/plugins/luasnip.lua
return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function(_, opts)
      local ls = require("luasnip")

      -- basic config (same as docs / LazyVim defaults) :contentReference[oaicite:1]{index=1}
      ls.config.set_config(opts)

      -- VSCode-style snippets (friendly-snippets + your html.json)
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })

      -- Lua snippets from lua/snippets/*.lua (Rust, etc.) :contentReference[oaicite:2]{index=2}
      require("luasnip.loaders.from_lua").load({
        paths = vim.fn.stdpath("config") .. "/lua/snippets",
      })

      -- ✅ keymaps: explicit expand, then jump
      vim.keymap.set({ "i" }, "<C-k>", function()
        if ls.expandable() then
          ls.expand()
        end
      end, { silent = true, desc = "LuaSnip expand" })

      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.jumpable(1) then
          ls.jump(1)
        end
      end, { silent = true, desc = "LuaSnip jump next" })

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true, desc = "LuaSnip jump prev" })
    end,
  },
}
