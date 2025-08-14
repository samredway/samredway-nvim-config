vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true
vim.bo.softtabstop = 2

local jdtls = require('jdtls')
local jdtls_setup = require('jdtls.setup')

-- Find root using Maven/Gradle/Git markers
local root_markers = { 'gradlew', 'mvnw', 'pom.xml', 'build.gradle', '.git' }
local root_dir = jdtls_setup.find_root(root_markers)
if not root_dir then return end

-- Create per-project workspace folder
local project_name = vim.fn.fnamemodify(root_dir, ':t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspaces/' .. project_name

-- Configure JDTLS
local config = {
  cmd = {
    'jdtls',
    '-data', workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      -- Optional: turn off diagnostics
      configuration = {
        runtimes = {
          -- You can declare JDKs here if you have different ones
          -- {
          --   name = "JavaSE-17",
          --   path = "/path/to/jdk17",
          -- },
        },
      },
    },
  },
  init_options = {
    bundles = {},
  },
}

-- Start or attach to JDTLS
jdtls.start_or_attach(config)
