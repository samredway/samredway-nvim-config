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
  end,
}
