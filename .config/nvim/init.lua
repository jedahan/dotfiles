-- jedahan's neovim config
-- meant to be discoverable and documented
-- press space to see what commands are available

-- aliases
local option = vim.o
local window = vim.wo
local buffer = vim.bo
local cmd = vim.cmd
local fn = vim.fn
local global = vim.g
local keymap = vim.api.nvim_set_keymap

-- plugins
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/savq/paq-nvim', install_path})
  cmd('PaqInstall')
end

require 'paq' {
  'savq/paq-nvim';

  -- colors
  'rktjmp/lush.nvim';
  'alaric/nortia.nvim';
  'folke/lsp-colors.nvim';

  -- statusline
  'itchyny/lightline.vim';

  -- fuzzy finder
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';

  -- hop the cursor around
  'phaazon/hop.nvim';
  'kyazdani42/nvim-web-devicons';
  'folke/trouble.nvim';

  -- toggle comments
  'JoosepAlviste/nvim-ts-context-commentstring';
  'tpope/vim-commentary';

  -- signature helpers
  'ray-x/lsp_signature.nvim';

  -- debugging
  'mfussenegger/nvim-dap';
  'rcarriga/nvim-dap-ui';

  -- symbol outlines
  'simrat39/symbols-outline.nvim';

  -- completion - use tab/shift+tab to navigate
  'hrsh7th/nvim-cmp';
  'hrsh7th/cmp-buffer';
  'williamboman/nvim-lsp-installer';
  'neovim/nvim-lspconfig';
  'terrastruct/d2-vim';
  'kosayoda/nvim-lightbulb';
  'liuchengxu/vim-which-key';
  'gleam-lang/gleam.vim';
  { 'nvim-treesitter/nvim-treesitter', run=':TSUpdate' };
}
require('lspconfig').tsserver.setup({})
require('lsp_signature').setup()
require('nortia.theme').set_hour(16)

local dap = require('dap')
local dapui = require('dapui')
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
dapui.setup()

global.neovide_cursor_vfx_mode = "pixiedust"

option.termguicolors = true
global.nortia_bat_light_theme = true
cmd 'colorscheme nortia-nvim'

option.hidden = true    -- allow switching buffers without saving
option.timeoutlen = 500 -- wait 500ms for mapped sequences to complete

option.inccommand = 'nosplit'

local indent = 2
buffer.tabstop = indent     -- columns for tabs
buffer.shiftwidth = indent  -- columns for shifting text with `>`
buffer.expandtab = true     -- use spaces instead of tabs
option.ignorecase = true    -- search takes casing into account when using Uppercase
option.smartcase = true

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
  o = { 'SymbolsOutline', 'outline-symbols'},
  q = { 'q', 'quit' },
  Q = { 'qA!', 'quit-without-saving' },
  h = { '<c-w>h', 'left-window' },
  j = { '<c-w>j', 'up-window' },
  k = { '<c-w>k', 'down-window' },
  l = { '<c-w>l', 'right-window' },
  h = {
    name = '+help',
    h = { ':help', 'help' },
    n = { ':help neovide', 'help' },
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
    N = { 'enew', 'new-buffer'},
    b = { 'enew', 'new-buffer'},
    p = { 'bprevious', 'previous-buffer'},
    f = { ':Telescope buffers', 'find-buffer' },
  },
  p = {
    name = '+plugins',
    s = { 'PaqSync', 'plugins-sync' },
    i = { 'PaqInstall', 'plugins-install' },
    u = { 'PaqUpdate', 'plugins-update' },
    c = { 'PaqClean', 'plugins-clean' },
  },
  g = {
    name = '+goto',
    d = { 'vim.lsp.buf.definition', 'goto-definition' },
    r = { 'vim.lsp.buf.declaration', 'goto-declaration' },
    i = { 'vim.lsp.buf.implementation', 'goto-implementation' },
  },
  c = {
    name = '+code',
    d = { ':lua vim.lsp.buf.definition()', 'code-definition' },
    r = { ':lua vim.lsp.buf.declaration()', 'code-declaration' },
    i = { ':lua vim.lsp.buf.implementation()', 'code-implementation' },
    h = { ':lua vim.lsp.buf.hover()', 'code-hover' },
    f = { ':Telescope live_grep', 'find-code' },
    b = { ':Telescope buffers', 'find-buffer' },
  },
  f = {
    name = '+file',
    s = { 'update', 'save-file' },
    f = { ':Telescope find_files', 'find-file' },
    o = { ':edit', 'open-file' },
    S = { 'write !sudo % > /dev/null', 'save-file-as-root'},
  },
  x = {
    name = '+xrouble',
    x = { 'Trouble', 'toggle-trouble' }
  }
}
vim.fn['which_key#register']('<Space>', 'g:keymaps')
require('telescope').setup()

local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}
