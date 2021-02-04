colorscheme new-moon " appropriate color scheme
set autoread " automatically reload buffers when changed
set hidden " allow switching buffers without saving
set showcmd " show commands in status and selections in visual mode

" press space for everything
let g:mapleader = " "
let g:maplocalleader = " "
set timeoutlen=500

" use packer for plugins
lua require('plugins')

" show help on leader key
let g:which_key_map =  {}
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> <cmd>WhichKey '<Space>'<cr>

" code
let g:which_key_map.c = { 'name' : '+code' }
let g:which_key_map.c.f = 'find-code'
let g:which_key_map.c.t = 'find-tags'
let g:which_key_map.c.q = 'code-quickfixes'
nnoremap <silent> <leader>cf <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <silent> <leader>ct <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <silent> <leader>cq <cmd>lua require('telescope.builtin').quickfix()<cr>

" files
let g:which_key_map.f = { 'name' : '+file' }
let g:which_key_map.f.s = 'save-file'
let g:which_key_map.f.f = 'find-file'
let g:which_key_map.f.S = 'save-file-as-root'
nnoremap <silent> <leader>fs <cmd>update<cr>
nnoremap <silent> <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <silent> <leader>fS <cmd>w !sudo tee % > /dev/null<cr>

" buffers
let g:which_key_map.b = { 'name' : '+buffer' }
let g:which_key_map.b.f = 'find-buffer'
let g:which_key_map.b.n = 'next-buffer'
let g:which_key_map.b.p = 'previous-buffer'
let g:which_key_map.b.d = 'delete-buffer'
nnoremap <silent> <leader>bf <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <silent> <leader>bn <cmd>bnext<cr>
nnoremap <silent> <leader>bp <cmd>bprevious<cr>
nnoremap <silent> <leader>bd <cmd>bd<cr>

" app
let g:which_key_map.h = 'left-window'
let g:which_key_map.j = 'down-window'
let g:which_key_map.k = 'up-window'
let g:which_key_map.l = 'right-window'
nnoremap <silent> <leader>h <c-w>h
nnoremap <silent> <leader>j <c-w>j
nnoremap <silent> <leader>k <c-w>k
nnoremap <silent> <leader>l <c-w>l
let g:which_key_map.q = 'quit'
let g:which_key_map.Q = 'quit-without-saving'
nnoremap <silent> <leader>q <cmd>q<cr>
nnoremap <silent> <leader>Q <cmd>qA!<cr>

command! W w !sudo tee % > /dev/null " :W to save file as root

" windows
let g:which_key_map.w = { 'name' : '+window' }
let g:which_key_map.w.h = 'left-window'
let g:which_key_map.w.j = 'down-window'
let g:which_key_map.w.k = 'up-window'
let g:which_key_map.w.l = 'right-window'
nnoremap <silent> <leader>wh <c-w>h
nnoremap <silent> <leader>wj <c-w>j
nnoremap <silent> <leader>wk <c-w>k
nnoremap <silent> <leader>wl <c-w>l

" pick
let g:which_key_map.p = { 'name' : '+pick' }
let g:which_key_map.p.p = 'pick-planets'
let g:which_key_map.p.c = 'pick-colors'
nnoremap <silent> <leader>pp <cmd>lua require('telescope.builtin').planets()<cr>
nnoremap <silent> <leader>pc <cmd>lua require('telescope.builtin').colorscheme()<cr>

" github
let g:which_key_map.g = { 'name' : '+github' }
let g:which_key_map.g.i = 'github-issues'
let g:which_key_map.g.p = 'github-prs'
let g:which_key_map.g.g = 'github-gists'
nnoremap <silent> <leader>gi <cmd>lua require('telescope.builtin').extensions.issues()<cr>
nnoremap <silent> <leader>gp <cmd>lua require('telescope.builtin').extensions.pull_request()<cr>
nnoremap <silent> <leader>gg <cmd>lua require('telescope.builtin').extensions.gist()<cr>

" v
let g:which_key_map.v = { 'name' : '+vim' }
let g:which_key_map.v.i = 'vim-edit-init'
let g:which_key_map.v.p = 'vim-edit-plugins'
let g:which_key_map.v.r = 'vim-reload-config'
nnoremap <silent> <leader>vi <cmd>:vsplit ~/.config/nvim/init.vim<cr>
nnoremap <silent> <leader>vp <cmd>:vsplit ~/.config/nvim/lua/plugins.lua<cr>
nnoremap <silent> <leader>vr <cmd>:source ~/.config/nvim/init.vim<cr>

" enable better highlighting
lua <<ENABLE_HIGHLIGHT
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}
ENABLE_HIGHLIGHT
