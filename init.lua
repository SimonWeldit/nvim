-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.g.mapleader = ","

-- Disable folding for nim
vim.cmd('autocmd FileType nim setlocal foldmethod=manual')

-- Enable relative line numbers
vim.wo.relativenumber = true

-- New line without insert mode with leader + o
vim.keymap.set('n', '<leader>o', 'o<ESC>', {noremap = true})
vim.keymap.set('n', '<leader>O', 'O<ESC>', {noremap = true})

-- Change line number colors
vim.cmd('highlight LineNumber ctermfg=yellow')
vim.cmd('autocmd ColorScheme * highlight LineNr guibg=none guifg=LineNumber')

local keymap = vim.api.nvim_set_keymap
keymap('n', '<c-s>', ':w<CR>', {})
keymap('i', '<c-s>', '<Esc>:w<CR>a', {})
local opts = { noremap = true }
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-k>', '<c-w>k', opts)

-- Error messages
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Just some keybindings for terminal mode
keymap('t', '<esc>', [[<C-\><C-n>]], opts)
keymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'vimwiki/vimwiki'
  use 'junegunn/goyo.vim'
  use ('nvim-treesitter/nvim-treesitter', {run = 'TSUpdate'})
  use 'folke/tokyonight.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'akinsho/toggleterm.nvim'
  use 'tpope/vim-surround'
  use 'jwalton512/vim-blade'
  use 'alaviss/nim.nvim'
  use 'fatih/vim-go'
  use 'alvan/vim-closetag'
  use 'tpope/vim-fugitive'
  use 'vim-airline/vim-airline'
  use 'tpope/vim-commentary'
  use 'ap/vim-css-color'
  use 'ThePrimeagen/vim-be-good'
  use 'nvim-tree/nvim-tree.lua'
  use {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {
        disable_in_visualblock = true,
      } end
}
  use 'nvim-lua/plenary.nvim'
  use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v1.x',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},         -- Required
    {'hrsh7th/cmp-nvim-lsp'},     -- Required
    {'hrsh7th/cmp-buffer'},       -- Optional
    {'hrsh7th/cmp-path'},         -- Optional
    {'saadparwaiz1/cmp_luasnip'}, -- Optional
    {'hrsh7th/cmp-nvim-lua'},     -- Optional

    -- Snippets
    {'L3MON4D3/LuaSnip'},             -- Required
    {'rafamadriz/friendly-snippets'}, -- Optional
  }
}
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}
end)

require("tokyonight").setup({
  transparent = true,
})

--Colorscheme
vim.cmd[[colorscheme tokyonight-night]]

vim.o.clipboard = "unnamedplus"

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

-- Toggleterm setup
require("toggleterm").setup()
keymap("n", "<leader>t", ":ToggleTerm<CR>", {noremap = true})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

-- Nvim tree config
-- require("nvim-tree").setup({
--   sort_by = "case_sensitive",
--   on_attach = on_attach,
--   view = {
--     adaptive_size = true,
--     mappings = {
--       list = {
--         { key = "u", action = "dir_up" },
--       },
--     },
--   },
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = true,
--   },
-- })

-- toggle NERDTree show/hide using <C-n> and <leader>n
-- keymap("n", "<leader>n", ":NvimTreeToggle<CR>", {noremap = true})
-- reveal open buffer in NERDTree
-- keymap("n", "<leader>r", ":NvimTreeFocus<CR>", {noremap = true})

-- telescope config
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Treesitter config
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "help", "javascript", "typescript", "php" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,


  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

  },
}
