return {
  'nvimdev/guard.nvim',
  dependencies = {
    'nvimdev/guard-collection',
    'williamboman/mason.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local ft = require 'guard.filetype'

    -- Define the formatters and linters
    ft('typescript,javascript,typescriptreact'):fmt 'prettier'
    ft('python'):fmt('black'):lint 'mypy'

    -- Ensure Mason installs the required tools
    local ensure_installed = {
      'black',
      'prettier',
    }
    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }

    -- Call Guard setup LAST!
    require('guard').setup {
      -- Choose to format on every write to a buffer
      fmt_on_save = true,
      -- Use lsp if no formatter was defined for this filetype
      lsp_as_default_formatter = false,
      -- You can disable auto save on format if desired
      -- save_on_fmt = false,
    }
  end,
}
