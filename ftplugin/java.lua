vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true
vim.bo.softtabstop = 2

local jdtls = require('jdtls')
local jdtls_setup = require('jdtls.setup')

-- Root detection
local root_markers = { 'gradlew', 'mvnw', 'pom.xml', 'build.gradle', '.git' }
local root_dir = jdtls_setup.find_root(root_markers)
if not root_dir then return end

-- Per-project workspace
local project_name = vim.fn.fnamemodify(root_dir, ':t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspaces/' .. project_name

-- Path to Lombok jar
local lombok_path = vim.fn.expand("~/.local/share/lombok/lombok.jar")

-- Key mappings
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_caps = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_caps.default_capabilities(capabilities)
end

local on_attach = function(_, bufnr)
  local map = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, { buffer = bufnr }) end
  map('gd', vim.lsp.buf.definition)
  map('gr', vim.lsp.buf.references)
  map('K',  vim.lsp.buf.hover)
  map('<leader>rn', vim.lsp.buf.rename)   -- rename mapping
end

-- Final config
local config = {
  cmd = {
    vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls"),
    '-data', workspace_dir,
  },
  root_dir = root_dir,
  cmd_env = {
    JAVA_TOOL_OPTIONS = '-javaagent:' .. lombok_path,
  },
  settings = {
    java = {
      configuration = {
        runtimes = {
          -- Add JDKs here if needed
        },
      },
    },
  },
  init_options = {
    bundles = {},
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

jdtls.start_or_attach(config)
