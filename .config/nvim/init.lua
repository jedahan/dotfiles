-- jedahan's neovim config
-- meant to be discoverable and documented
-- press space to see what commands are available

-- aliases
local option = vim.o
local window = vim.wo
local buffer = vim.bo
local cmd = vim.cmd
local global = vim.g
local keymap = vim.api.nvim_set_keymap

-- plugins
require 'paq' {
  'savq/paq-nvim';

  -- fuzzy finder
  'nvim-lua/popup.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';

  -- hop the cursor around
  'phaazon/hop.nvim';

  -- envaluate blocks
  'Olical/conjure';

  -- s-expressions
  'tpope/vim-sexp-mappings-for-regular-people';
  'guns/vim-sexp';
  'tpope/vim-repeat';
  'tpope/vim-surround';

  -- completion - use tab/shift+tab to navigate
  'hrsh7th/nvim-compe';
  'neovim/nvim-lspconfig';
  'prabirshrestha/vim-lsp';
  'mattn/vim-lsp-settings';
  'liuchengxu/vim-which-key';
  { 'nvim-treesitter/nvim-treesitter', run=':TSUpdate' };
}
option.completeopt = 'menuone,noinsert,noselect' -- better completion defaults
require('compe').setup({
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
})

require('lspconfig').tsserver.setup({})

-- options
cmd 'colorscheme new-moon' -- set colorscheme to something appropriate

option.hidden = true    -- allow switching buffers without saving
option.timeoutlen = 500 -- wait 500ms for mapped sequences to complete

local indent = 2
buffer.tabstop = indent     -- columns for tabs
buffer.shiftwidth = indent  -- columns for shifting text with `>`
buffer.expandtab = true     -- use spaces instead of tabs
option.smartcase = true     -- search takes casing into account when using Uppercase

-- keybinds - press space to show help for all keybinds
global.which_key_map = {}
vim.api.nvim_set_keymap('', '<space>', '<leader>', { silent = true })
vim.api.nvim_set_keymap('', '<leader>', "<cmd>WhichKey '<Space>'<cr>", { silent = true, noremap = true })
global.which_key_centered = 1
global.which_key_hspace = 5
cmd 'autocmd! FileType which_key'
cmd [[ autocmd FileType which_key set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler ]]

-- key mappings
global.keymaps = {
  [' '] = { ':set nohlsearch', 'clear-highlight' },
  ['/'] = { ':set nohlsearch', 'clear-highlight' },
  q = { 'q', 'quit' },
  Q = { 'qA!', 'quit-without-saving' },
  h = { '<c-w>h', 'left-window' },
  j = { '<c-w>j', 'up-window' },
  k = { '<c-w>k', 'down-window' },
  l = { '<c-w>l', 'right-window' },
  h = {
    name = '+help',
    c = { ':help conjure', 'help-conjure' },
  },
  j = {
    name = '+jump',
    j = { ':HopChar', 'hop-char' },
    w = { ':HopWord', 'hop-word' },
    c = { ':HopChar2', 'hop-char-2' },
    h = { ':HopPattern', 'hop-pattern' },
    l = { ':HopLine', 'hop-line' },
  },
  w = {
    name = '+window',
    h = { '<c-w>h', 'left-window' },
    j = { '<c-w>j', 'up-window' },
    k = { '<c-w>k', 'down-window' },
    l = { '<c-w>l', 'right-window' },
  },
  b = {
    name = '+buffer',
    d = { 'bdelete', 'delete-buffer'},
    n = { 'bnext', 'next-buffer'},
    p = { 'bprevious', 'previous-buffer'},
    f = { ':Telescope buffers', 'find-buffer' },
  },
  p = {
    name = '+plugins',
    i = { 'PaqInstall', 'plugins-install' },
    u = { 'PaqUpdate', 'plugins-update' },
    c = { 'PaqClean', 'plugins-clean' },
    l = { 'LspInstallServer', 'language-completion-install' },
  },
  c = {
    name = '+code',
    f = { ':Telescope live_grep', 'find-code' },
    b = { ':Telescope buffers', 'find-buffer' },
  },
  f = {
    name = '+file',
    s = { 'update', 'save-file' },
    f = { ':Telescope find_files', 'find-file' },
    S = { 'write !sudo % > /dev/null', 'save-file-as-root'},
  },
}
vim.fn['which_key#register']('<Space>', 'g:keymaps')
