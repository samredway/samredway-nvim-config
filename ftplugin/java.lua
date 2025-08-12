vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true
vim.bo.softtabstop = 2

-- Set path to libs for java lsp
vim.env.JAVA_TOOL_OPTIONS = "-javaagent:" .. vim.fn.expand("~/.local/share/nvim/mason/packages/lombok-nightly/lombok.jar")


