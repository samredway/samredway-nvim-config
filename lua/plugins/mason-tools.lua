return {
  'williamboman/mason.nvim',
  cmd = { 'Mason' },
  build = ':MasonUpdate',
  dependencies = {
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  },
  opts = {},
  config = function()
    local ensure = {
      'isort', 'prettier', 'jdtls'
      -- never install python tools like black or mypy or flake8 with mason.
      -- If guard cannot find in mason it will look next for what it can access
      -- in your terminal and if you venv is activated that will be your venv mypy
    }

    require('mason').setup()
    require('mason-tool-installer').setup { ensure_installed = ensure }
  end
}
