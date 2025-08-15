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
      -- Close but breaks if the file has an error in it and cant be imported
      -- In fact this will always happen as blck needs to import the file to 
      -- run. Maybe we live with the ugly error coming up each time?
      :append({
        cmd = 'black',
        args = { '--quiet', '-' },
        stdin = true,
      })
      -- Never install mypy to mason or this will use mason instead of your venv
      -- always activate venv before running nvim or you will use sys instead of
      -- venv
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
