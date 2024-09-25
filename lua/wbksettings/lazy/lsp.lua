return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "clangd", "solargraph", "elixirls", "pyright", "rubocop" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- function to make sure LSPs are attaching correctly
      local function attacher(client)
        print('Attaching LSP: ' .. client.name)
        vim.diagnostic.config({
          virtual_text = true,
          signs = true,
          update_in_insert = false,
          underline = true,
          severity_sort = true,
        })
      end

      -- lsp setup for Lua
      lspconfig.lua_ls.setup({
        on_attach = attacher
      })

      --lsp setup for tsserver
      lspconfig.tsserver.setup({
        on_attach = attacher
      })

      -- lsp setup for c++
      lspconfig.clangd.setup({
        on_attach = attacher
      })

      -- lsp setup for ruby
      lspconfig.solargraph.setup({
        on_attach = attacher
      })

      -- lsp setup for elixir
      lspconfig.elixirls.setup({
        on_attach = attacher,
        cmd = { "/Users/byronkarlen/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
        settings = {
          elixirLS = {
            dialyzerEnabled = true,
          }
        }

      })

      lspconfig.pyright.setup({
        on_attach = attacher
      })

      lspconfig.rubocop.setup({
        on_attach = attacher
      })

      -- keybindings once language server attaches to buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }

          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        end
      })

    end
  }
}
