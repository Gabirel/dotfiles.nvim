return {
  {
    "williamboman/mason.nvim",
    opts = {},
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "bashls", "ts_ls" },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      -- support these: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/builtins.json
      local sources = {
        -- lua
        null_ls.builtins.formatting.stylua,
        -- python
        null_ls.builtins.formatting.isort, -- sort imports
        null_ls.builtins.formatting.black,
        -- universal
        null_ls.builtins.completion.spell,
      }
      null_ls.setup({ sources = sources })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {},
    ---@diagnostic disable-next-line: unused-local
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      local lua_settings = {
        -- see: https://luals.github.io/wiki/settings/#settings
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      }

      -- lua setup
      lspconfig.lua_ls.setup({ settings = lua_settings })
      -- js/ts setup
      lspconfig.ts_ls.setup({})

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
    end,
  },
}
