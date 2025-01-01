return {
  'nvimdev/guard.nvim',
    dependencies = {
        "nvimdev/guard-collection",
    },
    config = function()
    local ft = require 'guard.filetype'

    -- Define the formatters and linters
    ft('typescript,javascript,typescriptreact'):fmt 'prettier'
    ft('python'):fmt('black'):lint 'mypy'
    ft('go'):fmt('gofmt')
    ft('cpp'):fmt('clang-format')

    -- Ensure Mason installs the required tools
    local ensure_installed = {
      'black',
      'prettier',
    }
    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }

   -- change this anywhere in your config (or not), these are the defaults
  vim.g.guard_config = {
      -- format on write to buffer
      fmt_on_save = true,
      -- use lsp if no formatter was defined for this filetype
      lsp_as_default_formatter = false,
      -- whether or not to save the buffer after formatting
      save_on_fmt = true,
      -- automatic linting
      auto_lint = true,
      -- how frequently can linters be called
      lint_interval = 500
  }
  end,
}
