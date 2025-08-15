return {
  'nvimdev/guard.nvim',
  dependencies = {
    'nvimdev/guard-collection',
  },
  commit = "9a9f00a6f70e5da2ea8379f203fcd45d8a7250cc",
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local ft = require 'guard.filetype'

    ft('typescript,javascript,typescriptreact'):fmt 'prettier'
    ft('python')
      :fmt('isort')
      -- Never install black or mypy with mason or that will get preference 
      -- over the version accessibly from your termail. Instead make sure
      -- you activate your vitual env before you open nvim and that version 
      -- will be used (otherwise it will be the system version)
      -- Check the version being used by doing ':! which mypy'
      :append('black')
      :lint('mypy')
      -- apparently cant chain this with flake8 so that gets done by the lsp
    ft('go'):fmt('gofmt')
    ft('cpp'):fmt('clang-format')
    ft('java'):fmt({
      cmd = 'google-java-format',
      args = { '-' },
      stdin = true,
    })

    vim.g.guard_config = {
      fmt_on_save = true,
      lsp_as_default_formatter = false,
      save_on_fmt = true,
      auto_lint = true,
    }
  end,
}
