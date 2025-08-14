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
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          typeCheckingMode = "off",
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
}
