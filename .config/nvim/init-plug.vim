" vim: et sw=2 fdm=marker fmr={{{,}}}
" github.com/thetarkus/dotfiles



" Variables {{{
let cachedir = '~/.cache/vim'
let plugdir = cachedir . '/plug'
" }}}



" Plugins {{{
" ----------------
if empty(glob(plugdir . '/plug.vim'))
  exec 'silent !curl -fLo ' . plugdir . '/plug.vim --create-dirs'
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin(plugdir)

Plug 'tpope/vim-eunuch'  " Unix helper commands
Plug 'tpope/vim-sleuth'  " Detect and set buffer options
Plug 'tpope/vim-repeat'  " Repeating
Plug 'tpope/vim-vinegar'  " Netrw Enhancements
Plug 'tpope/vim-fugitive'  " Git wrapper
Plug 'tpope/vim-surround'  " Text surroundings
Plug 'tpope/vim-dispatch'  " Async dispatching
Plug 'tpope/vim-obsession'  " Sessions

Plug 'Yggdroot/indentLine'  " Space-indentation levels
Plug 'junegunn/vim-slash'  " Enhanced buffer search
Plug 'wellle/targets.vim' " Enhanced text objects
Plug 'tomtom/tcomment_vim'  " Comments
Plug 'chrisbra/Recover.vim'  " Swap-file Compare

Plug 'honza/vim-snippets'  " Snippets
Plug 'sheerun/vim-polyglot'  " Syntax language pack
Plug 'chriskempson/base16-vim'  " Base16 colorscheme
Plug 'christoomey/vim-tmux-navigator'  " Window navigation

Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}  " Autocompletion

" Nvim-compatiblity Plugins
if has('nvim')
  Plug 'radenling/vim-dispatch-neovim'

" Vim-compatiblity Plugins
else
  Plug 'tpope/vim-sensible'
endif

call plug#end()
" ----------------
" }}}



" Plugin Settings {{{
" ----------------
" indentLine
"let g:indentLine_char_list = '¦'

" coc.nvim
let g:coc_snippet_next = '<CR>'
let g:coc_global_extensions = [
  \   'coc-word', 'coc-json', 'coc-css', 'coc-html',
  \   'coc-pairs', 'coc-highlight', 'coc-yank',
  \   'coc-lists',
  \   'coc-snippets',
  \ ]
let g:coc_user_config = {
  \   'list.limitLines': 1000,
  \   'list.source.grep.command': 'rg',
  \   'list.source.grep.args': ['-j', '1', '--vimgrep', '--no-heading'],
  \   'list.insertMappings': {
  \     '<C-n>': 'normal:j',
  \     '<C-p>': 'normal:k',
  \   },
  \   'coc.source.word.filetypes': [
  \     'markdown', 'gitcommit', 'text', ''
  \   ],
  \ }
" ----------------
" }}}



" Vim Settings {{{
" ----------------
" Path
set path+=**

" Colors
" set t_Co=256
" set t_AB=^[[48;5;%dm
" set t_AF=^[[38;5;%dm
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
set colorcolumn=80

" Scrolling
set scrolloff=2

" Persistent Undo
" set undofile
" set undodir=~/.cache/vim/undo

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
nmap <silent> <Leader>/ :CocList grep<CR>
nmap <silent> <Leader>f :CocList files<CR>
nmap <silent> <Leader>c :CocList colors<CR>

imap <silent><expr><CR>
 \ pumvisible() && coc#expandable() ? coc#_select_confirm() : coc#jumpable() ?
 \ '<C-r>=coc#rpc#request("doKeymap", ["snippets-expand-jump"])<CR>' : '<CR>'

" Search
nmap <plug>(slash-after) zz

" Line Navigation
map <S-h> g0
map <S-l> g_

" Counterpart to <S-j>
nmap <S-k> DO<Esc>p==

" Git
nmap gs :tab Gstatus<CR>

" ----------------
" }}}



" Filetypes {{{
" ----------------
augroup FILETYPES
  autocmd!
  autocmd FileType vue syntax sync fromstart
  autocmd FileType md setlocal conceallevel=0
  autocmd FileType help,vim-plug nmap <silent><buffer> <Esc> :q<CR>
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
