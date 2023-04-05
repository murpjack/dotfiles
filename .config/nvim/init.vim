" Both , and \ act as leader
let mapleader = ','
map \ <Leader>

set nocompatible
if !exists('g:syntax_on')
	syntax enable
endif

" Format
set encoding=utf8
set nonumber
set nowrap

" Indent
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

" Mouse can scroll
set mouse=a

" conceallevels
set conceallevel=2

" Allow embedded script highlighting
let g:vimsyn_embed= 'l'
let g:loaded_perl_provider = 0

let $FZF_DEFAULT_COMMAND='find . \! \( -type d \) \! -type d \! -name ''*.tags'' -printf ''%P\n'''

" Plugins
let plugins_dir = '~/.config/nvim/vim-plug'
call plug#begin(expand(plugins_dir))

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'itchyny/lightline.vim'

" File tree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vim-scripts/vim-nerdtree_plugin_open'

" Language
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-highlight'
Plug 'elm-tooling/elm-language-server'
Plug 'christoomey/vim-tmux-navigator'

" Git
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'zivyangll/git-blame.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Style
Plug 'bluz71/vim-moonfly-colors'

" Experimental
" Plug 'murpjack/bins_rust'

call plug#end()

" Startup
autocmd VimEnter * edit ~/.bashrc
autocmd VimEnter * edit ~/.bash_git_shortcuts
autocmd VimEnter * edit ~/.tmux.conf
autocmd VimEnter * edit $MYVIMRC

if (has("termguicolors"))
  set termguicolors
endif

colorscheme moonfly

" statusline
" for colours - :so $VIMRUNTIME/syntax/hitest.vim
set laststatus=2
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'moonfly',
      \ 'active': {
      \   'left': [ [ 'mode' ],
      \             [ 'filename' ],
      \           ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
      \ },
      \ 'inactive': {
      \   'left':  [ [ 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
      \ },
      \ 'component_function': {
	    \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  if &buftype ==# 'terminal'
    return ''
  else
    let filename = expand('%:t') !=# '' ? expand("%:~:.") : '[No Name]'
    let modified = &modified ? ' ✏️' : '   '
    return StatuslineGit() . ' ' . filename . modified
  endif
endfunction
 
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" function! BinDay()
"  let l:binDayFile = system("~/.config/nvim/binday/bins_rust")
"  " :! l:binDayFile
"  let l:binDay = '🗑'
"  " return l:binDay
"  return l:binDayFile
" endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

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
nmap <C-p>  :Files<CR>

" Use arrows to resize buffers
nnoremap <Down>     :resize +2<CR>
nnoremap <Up>       :resize -2<CR>
nnoremap <Right>    :vertical resize +2<CR>
nnoremap <Left>     :vertical resize -2<CR>
" Resize buffers quickly
nnoremap <C-Down>     :resize +20<CR>
nnoremap <C-Up>       :resize -20<CR>
nnoremap <C-Right>    :vertical resize +20<CR>
nnoremap <C-Left>     :vertical resize -20<CR>

" Faster scrolling
nnoremap <C-d> 20<C-e>
nnoremap <C-u> 20<C-y>

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

" Save session state (buffers, splits, file locations, etc) - Obsession
noremap <F2> :Obsess! tmp/Session.vim <cr> " Quick write session with F2

" remap git blame command
nnoremap <Leader>bl :<C-u>call gitblame#echo()<CR>

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'m',
                \ 'Staged'    :'+',
                \ 'Untracked' :'u',
                \ 'Renamed'   :'r',
                \ 'Unmerged'  :'',
                \ 'Deleted'   :'x',
                \ 'Dirty'     :'',
                \ 'Ignored'   :'i',
                \ 'Clean'     :'',
                \ 'Unknown'   :'',
                \ }

" Nerd tree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1

let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1

let NERDTreeDirArrowExpandable="▶"
let NERDTreeDirArrowCollapsible="▽"

let g:NERDTreeGitStatusUseNerdFonts = 1

augroup nerdtreeconcealbrackets
      autocmd!
    "  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL cchar=
     " autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
      autocmd FileType nerdtree setlocal conceallevel=2
      autocmd FileType nerdtree setlocal concealcursor=nvic
augroup END

let g:coc_global_extensions = [
      \'coc-highlight',
      \'coc-json', 
      \'coc-css',
      \'coc-tsserver',
      \'coc-prettier',
      \'coc-rust-analyzer',
      \'coc-eslint'
      \]

" Tab key to select a value from autocomplete list
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Fix code suggestions
nmap <leader>do <Plug>(coc-codeaction)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_arrow_function       = "⇒"

let g:typescript_conceal_function             = "ƒ"
let g:typescript_conceal_arrow_function       = "⇒"


autocmd FileType scss setl iskeyword+=@-@

let g:rustfmt_autosave = 1

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction
