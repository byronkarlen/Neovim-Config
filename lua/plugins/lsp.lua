return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({
        ui = { border = "single" }
      })
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- Install manually though Mason to avoid duplicate LSP problem
        -- ensure_installed = { "lua_ls", "typescript-language-server", "eslint-lsp" }
        ensure_installed = { "eslint" },
        automatic_installation = false,
        automatic_setup = false,
        automatic_enable = false,
        handlers = nil
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
          float = { border = "single" },
        })
      end

      -- lsp setup for Lua
      lspconfig.lua_ls.setup({
        on_attach = attacher,
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

      -- lsp setup for typescript
      lspconfig.ts_ls.setup({
        on_attach = attacher
      })

      -- lsp setup for eslint
      lspconfig.eslint.setup({
        on_attach = function(client, _)
          attacher(client)
        end,
        settings = {
          codeActionOnSave = {
            enable = true,
            mode = "all"
          },
        }
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
          vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, opts)
        end
      })

      -- toggle language server on/off
      vim.keymap.set("n", "<leader>l", function()
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients({ bufnr = bufnr })

        if #clients > 0 then
          for _, c in ipairs(clients) do
            vim.cmd("LspStop " .. c.name)
          end
          print("Stopping LSP: " .. table.concat(vim.tbl_map(function(c) return c.name end, clients), ", "))
        else
          local ft = vim.bo[bufnr].filetype
          for _, config in pairs(require("lspconfig.configs")) do
            if config.manager and vim.tbl_contains(config.filetypes or {}, ft) then
              config.manager:try_add(bufnr)
            end
          end
        end
      end, { desc = "Toggle all LSPs" })

    end
  }
}
