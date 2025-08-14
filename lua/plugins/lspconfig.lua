return {
  { -- lsp configuration & plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- note using `opts = {}` will auto call setup
      { 'mason-org/mason-lspconfig.nvim' },
 

      -- useful status updates for lsp.
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures lua lsp for your neovim config, runtime and plugins
      -- used for completion, annotations and signatures of neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },

    config = function()
      vim.api.nvim_create_autocmd('lspattach', require('plugins.lsp.on-attach'))

      -- lsp servers and clients are able to communicate to each other what features they support.
      --  by default, neovim doesn't support everything that is in the lsp specification.
      --  when you add nvim-cmp, luasnip, etc. neovim now has *more* capabilities.
      --  so, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- load in the enabled language servers. to adde remove servers edit the file
      -- lsp.servers
      local servers = require('plugins.lsp.servers') 

      -- you can add other tools here that you want mason to install
      -- for you, so that they are available from within neovim.
      require('mason-lspconfig').setup {
        automatic_installation = true,  -- automatically install missing servers
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- this handles overriding only values explicitly passed
            -- by the server configuration above. useful when disabling
            -- certain features of an lsp (for example, turning off formatting for tsserver now ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
