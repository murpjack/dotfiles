" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"
"   Jack Murphy vim setup
"
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" TODO: Write a colorscheme from template
" TODO: NERDTree - fix file icons (Font issue??)
" TODO: Configure Tmux 
" TODO: Configure work/personal env 
" TODO: ELM - Format on save
" TODO: ELM - key mapping to expose module/type/etc 
"
set nocompatible
if !exists('g:syntax_on')
	syntax enable
endif
set nowrap
set encoding=utf8


" Both , and \ act as leader
let mapleader = ','
map \ <Leader>


" Allow embedded script highlighting
"
"   g:vimsyn_embed == 0      : disable (don't embed any scripts)
"   g:vimsyn_embed == 'lPr'  : support embedded lua, python and ruby
let g:vimsyn_embed= 'l'



" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"   
"   Plugins
"
" --------------


let plugins_dir = '~/.config/nvim/vim-plug'
call plug#begin(expand(plugins_dir))


Plug 'junegunn/fzf' 
Plug 'junegunn/fzf.vim'
Plug 'http://github.com/sheerun/vim-polyglot'


" File tree viewer
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/vim-nerdtree_plugin_open'
Plug 'eugen0329/vim-esearch' " In place of vim-ack and nerdtree-ack
Plug 'ryanoasis/vim-devicons'

" ELM
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-highlight'

" Neorg - org-mode
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'vimwiki/vimwiki'

" JS
Plug 'pangloss/vim-javascript'


" Colours
Plug 'sts10/vim-pink-moon'
Plug 'joshdick/onedark.vim'

" Icons
Plug 'ryanoasis/vim-devicons'


call plug#end()



" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
"   Configuration
"
" -------------------


if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme onedark

"colorscheme pink-moon

set guifont=JetBrainsMono\ Nerd\ Font\ Mono\ 15


" conceallevels 
" 0 - No concealed characters
" 1 - Replace hidden for special characters
" 2 - No hidden characters, unless substitute available
" 3 - No hidden characters, regardless of settings
set conceallevel=2


" On startup
autocmd VimEnter * edit ~/.bashrc
autocmd VimEnter * call timer_start(5, { -> execute("edit $MYVIMRC")})



"   Search
"
" -----------


" Re-source nvim
nnoremap <Leader>sr :source $MYVIMRC<CR>


" Search recently-used history
nmap <C-c>  :History:<space><CR>


" Search all available nvim commands
nmap <Leader>c  :Commands<CR>


" See all open buffers
nnoremap <Leader><Space>          :Buf<CR>
tnoremap <Leader><Space> <C-\><C-n>:Buf<CR>


" Search in home or present directory
nmap <C-l>  :Files $HOME<CR>
nmap <C-p>  :Files <CR>




"   Navigation & Tab mischief
"
" --------------------------------

" Mouse can scroll
set mouse=a

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




"   File tree 
"
" ---------------


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

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let NERDTreeDirArrowExpandable=">"
let NERDTreeDirArrowCollapsible="v"

" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1


" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue


"		Coc language server et all
"
" ----------------------------------
" Look at coc - https://github.com/neoclide/coc.nvim#example-vim-configuration


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')


" ELM
" go to the definition of the function under the cursoer
" Ilist is the ilist variant from romainl/vim-qlist
autocmd FileType elm nnoremap <buffer> <leader>] yiw:ilist ^\s*<c-r>"\s.*=$<cr>

" JS 
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_arrow_function       = "⇒"




" References:
" https://github.com/bitterjug/dotfiles/tree/master/nvim
" https://github.com/lazamar/dotfiles/blob/master/.config/nvim/init.vim


