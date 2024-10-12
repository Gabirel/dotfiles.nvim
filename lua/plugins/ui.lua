return {
  -- status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opt = {},
    config = function(_, opts)
      require("lualine").setup(opts)
    end
  },
  -- ui select
  {
    "nvim-telescope/telescope-ui-select.nvim",
    opt = {},
    config = function(_, opts)
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }
          }
        }
      }
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("ui-select")
    end
  },
}
