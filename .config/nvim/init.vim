" vim: et sw=2 fdm=marker fmr={{{,}}}
" github.com/thetarkus/dotfiles



" Variables {{{
let $cachedir = expand('$HOME/.cache/vim')
let $plugdir = expand('$HOME/.local/share/nvim/site/autoload')
" }}}



" Plugins {{{
" ----------------
if empty(glob($plugdir))
  exec 'silent !curl -fLo ' . $plugdir . '/plug.vim --create-dirs'
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin($plugdir)

Plug 'tpope/vim-rsi'  " Readline
Plug 'tpope/vim-eunuch'  " Unix helper commands
Plug 'tpope/vim-sleuth'  " Detect and set buffer options
Plug 'tpope/vim-repeat'  " Repeating
Plug 'tpope/vim-apathy'  " Paths
Plug 'tpope/vim-vinegar'  " Netrw Enhancements
Plug 'tpope/vim-fugitive'  " Git wrapper
Plug 'tpope/vim-surround'  " Text surroundings
Plug 'tpope/vim-dispatch'  " Async dispatching
Plug 'tpope/vim-obsession'  " Sessions

Plug 'honza/vim-snippets'  " Snippets source
Plug 'wellle/targets.vim'  " Enhanced text objects
Plug 'junegunn/vim-slash'  " Enhanced buffer search
Plug 'Yggdroot/indentLine'  " Space-indentation levels
Plug 'tomtom/tcomment_vim'  " Comments
Plug 'jiangmiao/auto-pairs'  " Automatic bracket, paren, quotes pairing
Plug 'chrisbra/Recover.vim'  " Swap-file Compare
Plug 'sheerun/vim-polyglot'  " Syntax language pack
Plug 'chriskempson/base16-vim'  " Base16 colorschemes
Plug 'christoomey/vim-tmux-navigator'  " Window navigation

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'  " Fzf wrapper

Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}  " Autocomplete


" Nvim-compatiblity Plugins
if has('nvim')
  Plug 'radenling/vim-dispatch-neovim'

" Vim-compatiblity Plugins
else
  Plug 'tpope/vim-sensible'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()
" ----------------
" }}}



" Plugin Settings {{{
" ----------------
" indentLine
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" coc.nvim
let g:coc_global_extensions = [
  \   'coc-snippets',
  \   'coc-json', 'coc-tsserver', 'coc-vetur',
  \   'coc-word', 'coc-emoji'
  \ ]

let g:coc_user_config = {
  \ }

" vim-vue (vim-polyglot)
let g:vue_pre_processors = []

" autopairs
let g:AutoPairsMultilineClose = 0
" ----------------
" }}}



" Vim Settings {{{
" ----------------
" Colors
set termguicolors
colorscheme base16-monokai
syntax enable

" Text
set nowrap

" Indentation
filetype plugin indent on

" Wild Menu
set wildoptions=pum
set pumblend=5

" Line Numbers
set number
set relativenumber
set colorcolumn=81

" Scrolling
set scrolloff=2

" Persistent Undo
set undofile
set undodir=$cachedir/undo

" ----------------
" }}}



" Commands {{{
" ----------------
" Fugitive
command! Gdifftab tabedit %|Gvdiffsplit
" ----------------
" }}}



" Keybindings {{{
" ----------------
let mapleader = "\<Space>"

" Save
nmap <Space><Esc> :w<CR>

" Tab control
nmap tc :tabclose<CR>

" Yank/Pasting
nmap <Leader>p "+p
nmap <Leader>P "+P
map <Leader>y "+y

" Fuzzy Finders
nmap <silent> <Leader>c :Colors<CR>
nmap <silent> <Leader>f :Files<CR>
nmap <silent> <Leader>b :Buffers<CR>
nmap <silent> <Leader>/ :Rg<CR>

" Auto-completion
imap <expr><CR> pumvisible() && coc#expandable() ?
 \ '<C-y>' : coc#jumpable() ? '<C-j>' : '<CR>'

" Search
nmap <plug>(slash-after) zz

" Line Navigation
map <S-h> ^
map <S-l> g_

" Counterpart to <S-j>
nmap <S-k> DO<Esc>p==

" Fugitive
nmap <leader>gs :tab Gstatus<CR>
nmap <leader>gd :Gdifftab<CR>
nmap <leader>gc :Gcommit -v<CR>

" Surround
vmap <CR> S<C-J>jVj=$

" ----------------
" }}}



" Filetypes {{{
" ----------------
augroup FILETYPES
  autocmd!
  autocmd FileType javascript let b:dispatch = 'npm test -- %'
  autocmd FileType vue syntax sync fromstart
  autocmd FileType md setlocal conceallevel=0

  autocmd FileType help,qf,vim-plug nmap <silent><buffer> <Esc> :q<CR>
augroup END
" ----------------
" }}}



" Events {{{
" ----------------
augroup EVENTS

  autocmd BufWritePre <buffer> %s/\s\+$//e

  autocmd VimEnter * nested call AutoloadSession()
  function! AutoloadSession()
    if !argc() && filereadable('Session.vim')
      source Session.vim
      Obsess! Session.vim
    endif
  endfunction

augroup END
" ----------------
" }}}
