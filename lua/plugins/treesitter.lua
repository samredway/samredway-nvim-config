return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      parsers = {
        -- Python, Lua, Terraform, HTML, JavaScript, and TypeScript are active.
        -- Uncomment any parser below to reactivate another language.
        'bash',
        -- 'c',
        -- 'cpp',
        -- 'css',
        'diff',
        'gitignore',
        'hcl',
        'html',
        'javascript',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'vim',
        'vimdoc',
        'python',
        -- 'rust',
        'tsx',
        'typescript',
        'yaml',
      },
    },
    config = function(_, opts)
      local treesitter = require 'nvim-treesitter'
      treesitter.setup {}

      local function enable(buf)
        if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= '' then
          return
        end
        local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
        if lang and pcall(vim.treesitter.start, buf, lang) then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      local pending = {}
      local available = {}
      for _, lang in ipairs(treesitter.get_available()) do
        available[lang] = true
      end

      local function install(languages)
        -- Parser compilation requires the separately installed CLI.
        if vim.fn.executable('tree-sitter') ~= 1 then
          return
        end
        treesitter.install(languages):await(function()
          vim.schedule(function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              enable(buf)
            end
          end)
        end)
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('UserTreesitter', { clear = true }),
        callback = function(args)
          enable(args.buf)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if lang and available[lang] and not pending[lang] then
            pending[lang] = true
            install { lang }
          end
        end,
      })

      for _, lang in ipairs(opts.parsers) do
        pending[lang] = true
      end
      install(opts.parsers)
    end,
  },
}
