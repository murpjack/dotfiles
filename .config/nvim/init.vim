let g:vimsyn_embed= 'l'

" Both , and \ act as leader
let mapleader = ','
map \ <Leader>

" Re-source nvim with this [updated] init.vim file
nnoremap <Leader>sr :source $MYVIMRC<CR>


let plugins_dir = '~/.config/nvim/vim-plug'

call plug#begin(expand(plugins_dir))

Plug 'junegunn/fzf' 
Plug 'junegunn/fzf.vim'
Plug 'http://github.com/sheerun/vim-polyglot'

" File tree viewer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" ELM
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Neorg - org-mode
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'

" JS
Plug 'pangloss/vim-javascript'

call plug#end()


nmap <C-p>  :Files <CR>
nmap <C-l>  :Files $HOME<CR>

" Search command history
nmap <C-c>  :History:<space><CR>

" Search available commands
nmap <Leader>c  :Commands<CR>

" Show all open buffers
nnoremap <Leader><Space>          :Buf<CR>
tnoremap <Leader><Space> <C-\><C-n>:Buf<CR>

" Use arrows to resize screen
nnoremap <Down>     :resize +2<CR>
nnoremap <Up>       :resize -2<CR>
nnoremap <Right>    :vertical resize +2<CR>
nnoremap <Left>     :vertical resize -2<CR>

" Faster scrolling 
nnoremap <C-d> 6<C-e> 
nnoremap <C-u> 6<C-y>

" Exit terminal mode
tmap <C-w> <C-\><C-n><C-w>


" Open terminal with our setup file loaded
nmap <Leader>T            :vsplit \| execute "terminal" \| startinsert <CR>
tmap <Leader>T  <C-\><C-n>:vsplit \| execute "terminal" \| startinsert <CR>
nmap <Leader>t            :split  \| execute "terminal" \| startinsert <CR>
tmap <Leader>t  <C-\><C-n>:split  \| execute "terminal" \| startinsert <CR>

" Force quit a window
tnoremap <Leader>q <C-\><C-n>:bd!<CR>
noremap  <Leader>q      <C-w>:bd!<CR>

let g:nvim_tree_icons = {
    \ 'default': "",
    \ 'symlink': "",
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" More available functions:
" NvimTreeOpen
" NvimTreeClose
" NvimTreeFocus
" NvimTreeFindFileToggle
" NvimTreeResize
" NvimTreeCollapse
" NvimTreeCollapseKeepBuffers

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue



" ELM
" go to the definition of the function under the cursoer
" Ilist is the ilist variant from romainl/vim-qlist
autocmd FileType elm nnoremap <buffer> <leader>] yiw:ilist ^\s*<c-r>"\s.*=$<cr>

" JS 
set conceallevel=1

let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_arrow_function       = "⇒"

