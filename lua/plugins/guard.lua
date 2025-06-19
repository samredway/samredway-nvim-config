return {
  'nvimdev/guard.nvim',
  dependencies = {
    'nvimdev/guard-collection',
  },
  config = function()
    local ft = require 'guard.filetype'

    ft('typescript,javascript,typescriptreact'):fmt 'prettier'
    ft('python')
      :fmt('black')
      :fmt('isort')
      :lint('flake8')
      :lint('mypy')
    ft('go'):fmt('gofmt')
    ft('cpp'):fmt('clang-format')

    local ensure_installed = {
      'black',
      'isort',
      'flake8',
      'mypy',
      'prettier',
    }

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }

    vim.g.guard_config = {
      fmt_on_save = true,
      lsp_as_default_formatter = false,
      save_on_fmt = true,
      auto_lint = true,
      lint_interval = 500,
    }
  end,
}
