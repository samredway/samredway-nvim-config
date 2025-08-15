return {
  { -- lsp configuration & plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- note using `opts = {}` will auto call setup
      { 'mason-org/mason-lspconfig.nvim' },
 

      -- useful status updates for lsp.
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- `neodev` configures lua lsp for your neovim config, runtime and plugins
      -- used for completion, annotations and signatures of neovim apis
       'folke/neodev.nvim',
       'mfussenegger/nvim-lint',
       'mhartington/formatter.nvim'
    },

    config = function()
      -- Setup up commands etc
      local on_attach = require('plugins.lsp.on-attach')

      -- Server configs are in the lsp/servers file
      local servers = require('plugins.lsp.servers')

      -- Setup neovim lua configuration
      require("neodev").setup({
          library = { plugins = { "neotest" }, types = true },
      })

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
          automatic_enable = false,
          ensure_installed = vim.tbl_keys(servers),
      }

      local lspconfig = require("lspconfig")
 
      for server_name, config in pairs(servers) do
          lspconfig[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = config.settings,
          filetypes = config.filetypes,
        }
      end
    end
  }
}
