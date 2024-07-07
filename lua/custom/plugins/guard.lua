return {
  'nvimdev/guard.nvim',
  -- Builtin configuration, optional
  dependencies = {
    'nvimdev/guard-collection',
  },
  config = function()
    local ft = require 'guard.filetype'

    -- Assuming you have guard-collection
    ft('python'):lint 'mypy'

    -- Call setup() LAST!
    require('guard').setup {
      -- Choose to format on every write to a buffer
      fmt_on_save = true,
      -- Use lsp if no formatter was defined for this filetype
      lsp_as_default_formatter = false,
      -- By default, Guard writes the buffer on every format
      -- You can disable this by setting:
      -- save_on_fmt = false,
    }
  end,
}
