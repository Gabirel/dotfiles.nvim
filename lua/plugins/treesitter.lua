return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      ensure_installed = {
        "bash",
        "diff",
        "fish",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "toml",
        "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
