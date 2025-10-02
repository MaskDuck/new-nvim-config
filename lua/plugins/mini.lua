return {
  'nvim-mini/mini.nvim',
  dependacies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Better Around/Inside textobjects
    --

    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    -- require('mini.git').setup {}

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    --
    vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufEnter' }, {
      pattern = '*.*',
      once = true,

      callback = function()
        require('mini.hipatterns').setup()
        require('mini.animate').setup()
        require('mini.move').setup {
          mappings = {
            left = 'H',
            right = 'L',
            up = 'K',
            down = 'J',
          },
        }
        require('mini.diff').setup{}
      end,
    })

    require('mini.notify').setup()

    vim.api.nvim_create_autocmd('InsertEnter', {
      once = true,
      callback = function()
        require('mini.indentscope').setup()
        require('mini.ai').setup { n_lines = 500 }
        require('mini.surround').setup()
        require('mini.pairs').setup()
      end,
    })
    require('mini.icons').setup {}
    

    require('mini.files').setup {
      mappings = {
        go_in_plus = '<CR>',
        go_in = 'L',
        trim_left = ',',
        trim_right = '.',
      },
    }

vim.api.nvim_create_user_command("Config", function (
  ) 
  config_dir = vim.fn.eval("stdpath('config')")
vim.fn.chdir(config_dir)
vim.notify("(:Config command) Changed directory to the config directory.")
MiniFiles.open(config_dir)

end, {desc = "Config"})

    k = require 'mini.extra'
    vim.api.nvim_create_user_command('M', k.pickers.marks, {})

    local files_set_cwd = function(path)
      -- Works only if cursor is on the valid file system entry
      local cur_entry_path = MiniFiles.get_fs_entry().path
      local cur_directory = vim.fs.dirname(cur_entry_path)
      vim.fn.chdir(cur_directory)
      MiniFiles.trim_left()
      local r = vim.fn.getcwd()
      vim.notify('(mini.files) Set current working directory to ' .. r)
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        vim.keymap.set('n', '<A-d>', files_set_cwd, { buffer = args.data.buf_id })
        -- vim.keymap.set('n', 'd', files_set_cwd, { buffer = args.data.buf_id })
        vim.keymap.set('n', 'l', function()
          MiniFiles.go_in { close_on_file = true }
        end, { buffer = args.data.buf_id })
      end,
    })
    vim.keymap.set('n', '<leader>ff', MiniFiles.open, { noremap = true })
    vim.api.nvim_create_user_command('Ff', 'lua MiniFiles.open()', {})
    vim.api.nvim_create_user_command('FF', 'lua MiniPick.builtin.files()', {})
    -- require('mini.starter').setup { header = 'I use Neovim btw.', footer = 'With a tiling window manager.\nOn Arch Linux!' }
    --
    -- local mode_map = {
    --   n = '(ᴗ_ ᴗ。)',
    --   nt = '(ᴗ_ ᴗ。)',
    --   i = '(•̀ - •́ )',
    --   R = '( •̯́ ₃ •̯̀)',
    --   v = '(⊙ _ ⊙ )',
    --   V = '(⊙ _ ⊙ )',
    --   no = 'Σ(°△°ꪱꪱꪱ)',
    --   ['\22'] = '(⊙ _ ⊙ )',
    --   t = '(⌐■_■)',
    --   ['!'] = 'Σ(°△°ꪱꪱꪱ)',
    --   c = 'Σ(°△°ꪱꪱꪱ)',
    --   s = 'SUB',
    -- }
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- function table.clone(org)
    --   return { table.unpack(org) }
    -- end
    -- ---@diagnostic disable-next-line: duplicate-set-field, unused-local
    -- statusline.section_mode = function(args)
    --   return { mode_map[vim.api.nvim_get_mode().mode] or vim.api.nvim_get_mode().mode, statusline.section_mode(args)[2] }
    -- end
    --

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    require('mini.pick').setup {
      mappings = {
        move_down = '<Tab>',
        move_up = '<S-Tab>',
        toggle_preview = '<C-Tab>',
      },
    }

    local wipeout_cur = function()
      vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
    end
    local buffers_picker_mappings = { wipeout = { char = '<C-d>', func = wipeout_cur } }

    vim.keymap.set('n', '<leader><leader>', function()
      MiniPick.builtin.buffers({}, buffers_picker_mappings)
    end, {})
    vim.keymap.set('n', '<leader>ff', MiniPick.builtin.files, {})
    vim.keymap.set('n', '<BS>', MiniPick.builtin.grep_live, {})

    vim.api.nvim_create_user_command('WS', function()
      k.pickers.lsp { scope = 'workspace_symbols' }
    end, {})

    vim.api.nvim_create_user_command('DS', function()
      k.pickers.lsp { scope = 'document_symbols' }
    end, {})

    vim.api.nvim_create_user_command('Branch', function()
      k.pickers.git_branches()
    end, {})
  end,
}
