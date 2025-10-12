-- Note: when installing an LSP, you must match the LSP name between mason and lspconfig
return {
  {
    "mason-org/mason.nvim",
    config = true
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Configure diagnostics globally
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = { border = "single" },
      })

      -- lsp setup for Lua
      vim.lsp.config('lua_ls', {
        filetypes = { "lua" },
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false, -- avoid prompts about "luassert" etc.
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      vim.lsp.enable('lua_ls')

      -- lsp setup for typescript
      vim.lsp.config('ts_ls', {
        settings = {},
      })
      vim.lsp.enable('ts_ls')

      -- lsp setup for eslint
      vim.lsp.config('eslint', {
        settings = {},
      })
      vim.lsp.enable('eslint')

      -- keybindings once language server attaches to buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          -- prevent ts_ls from trying to format
          if client and client.name == 'ts_ls' then
            client.server_capabilities.documentFormattingProvider = false
          end

          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'K', function()
            vim.lsp.buf.hover({
              border = "rounded"
            })
          end, opts)
          vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>cn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>k', function()
            vim.diagnostic.open_float()
            vim.diagnostic.open_float() -- place cursor in the window, making it easier to quit
          end, opts)
        end
      })

      -- toggle LSPs for the current buffer
      vim.keymap.set("n", "<leader>l", function()
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients({ bufnr = bufnr })

        if #clients > 0 then
          vim.b.detached_clients = vim.tbl_map(function(c) return c.id end, clients)
          for _, c in ipairs(clients) do
            vim.lsp.buf_detach_client(bufnr, c.id)
          end
        else
          if vim.b.detached_clients then
            for _, client_id in ipairs(vim.b.detached_clients) do
              vim.lsp.buf_attach_client(bufnr, client_id)
            end
          end
        end
      end, { desc = "Toggle LSPs for current buffer" })

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  }
}
