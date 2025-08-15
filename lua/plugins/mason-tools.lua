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
      'black', 'isort', 'flake8', 'prettier', 'jdtls'
      -- never install mypy with mason. If guard cannot find in mason it will
      -- look next for what it can access on your terminal and if you venv is
      -- activated that will be your venv mypy
    }

    require('mason').setup()
    require('mason-tool-installer').setup { ensure_installed = ensure }
  end
}
