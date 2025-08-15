return {
  'nvimdev/guard.nvim',
  dependencies = {
    'nvimdev/guard-collection',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local ft = require 'guard.filetype'

    ft('typescript,javascript,typescriptreact'):fmt 'prettier'
    ft('python')
      :fmt('isort')
      -- Close but breaks if the file has an error in it and cant be imported
      -- :append({
      --   cmd = 'black',
      --   args = { '--quiet', '-' },
      --   stdin = true,
      -- })
      :lint('flake8')  -- do we need to use the env flake8??
      -- Doesnt run right now. But really need to use the env mypy to be useful
      -- Anyway ...
      -- :append('mypy')
    ft('go'):fmt('gofmt')
    ft('cpp'):fmt('clang-format')

    vim.g.guard_config = {
      fmt_on_save = true,
      lsp_as_default_formatter = false,
      save_on_fmt = true,
      auto_lint = true,
    }
  end,
}
