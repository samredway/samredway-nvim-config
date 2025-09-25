-- Enable the following language servers
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
-- For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
return {
  gopls = {},
  terraformls = {},
  clangd = {},
  ts_ls = {},
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          mccabe = { enabled = false },
          pylint = { enabled = false },
          yapf = { enabled = false },
          autopep8 = { enabled = false },
          pydocstyle = { enabled = false },
          flake8 = { enabled = true },
        },
      },
    },
  },
  rust_analyzer = {
    server = {
      path = '~/.cargo/bin/rust-analyzer',
    },
    cargo = {
      allFeatures = true,
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
      },
    },
  },
  omnisharp = {
    cmd = {
      vim.fn.executable 'OmniSharp' == 1 and 'OmniSharp' or 'omnisharp',
      '-z', -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
      '--hostPID',
      tostring(vim.fn.getpid()),
      'DotNet:enablePackageRestore=false',
      '--encoding',
      'utf-8',
      '--languageserver',
      'FormattingOptions:EnableEditorConfigSupport=true',
      'Sdk:IncludePrereleases=true',
    },
    enable_editorconfig_support = true,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
  },
}
