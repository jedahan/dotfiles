colorscheme new-moon " appropriate color scheme

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

nnoremap <silent> <leader>fs <cmd>update<cr>
nnoremap <silent> <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>

" buffers
let g:which_key_map.b = { 'name' : '+buffer' }
let g:which_key_map.b.f = 'find-buffer'
let g:which_key_map.b.n = 'next-buffer'
let g:which_key_map.b.p = 'previous-buffer'
nnoremap <silent> <leader>bf <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <silent> <leader>bn <cmd>bnext<cr>
nnoremap <silent> <leader>bp <cmd>bprevious<cr>

" pick
let g:which_key_map.p = { 'name' : '+github' }
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

" enable better highlighting
lua <<ENABLE_HIGHLIGHT
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}
ENABLE_HIGHLIGHT
