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
      'black', 'isort', 'flake8', 'mypy', 'prettier', 'jdtls'
    }

    require('mason').setup()
    require('mason-tool-installer').setup { ensure_installed = ensure }
  end
}
