local config = function()
  -- require("mason").setup()
  -- require("mason-lspconfig").setup()

  vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- disable virtual text
        virtual_text = true,
        -- show signs
        signs = false,
        -- delay update diagnostics
        update_in_insert = false
        -- display_diagnostic_autocmds = { "InsertLeave" },
      })

  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  require 'lspconfig'.lua_ls.setup {
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        return
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths here.
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })
    end,
    settings = {
      Lua = {}
    }
  }

  local langs = {
    "clangd",
    "svelte",
    "pylsp",
    "pbls",
    "rust_analyzer",
    "nixd",
    "gopls",
    "ocamllsp",
    "clojure_lsp",
    "texlab",
    "ruby_lsp",
    "ts_ls",
    "tailwindcss",
    "gleam",
  }

  for _, lang in ipairs(langs) do
    require('lspconfig')[lang].setup({})
  end


  -- require("mason-lspconfig").setup {
  --   ensure_installed = langs
  -- }
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- "williamboman/mason.nvim",
    -- "williamboman/mason-lspconfig.nvim",
    { "folke/neodev.nvim",   opts = { experimental = { pathStrict = true } } },
    { "hrsh7th/cmp-nvim-lsp" },
  },
  config = config
}
