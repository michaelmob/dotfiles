" vim: et sw=2 fdm=marker fmr={{{,}}}
" github.com/thetarkus/dotfiles



" Plugins {{{
" ----------------
if &compatible | set nocompatible | endif

let $dein_path = '~/.cache/dein'
set runtimepath+=$dein_path/repos/github.com/Shougo/dein.vim

if empty(glob($dein_path))
  exec '!wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh && sh installer.sh ' . $dein_path
  source $MYVIMRC
endif


if dein#load_state($dein_path)
  call dein#begin($dein_path)
  call dein#add($dein_path . '/repos/github.com/Shougo/dein.vim')

  call dein#add('sheerun/vim-polyglot')  " Syntax language pack
  call dein#add('chriskempson/base16-vim')  " Base16 colorscheme
  call dein#add('christoomey/vim-tmux-navigator')  " Window navigation

  call dein#add('tpope/vim-sleuth')  " Detect and set buffer options
  call dein#add('tpope/vim-vinegar')  " Netrw Enhancements
  call dein#add('tpope/vim-fugitive')  " Git wrapper
  call dein#add('tpope/vim-surround')  " Text surroundings
  call dein#add('tpope/vim-obsession')  " Sessions
  call dein#add('wellle/targets.vim') " Enhanced text objects
  call dein#add('junegunn/vim-slash')  " Enhanced buffer search
  call dein#add('tomtom/tcomment_vim')  " Comments
  call dein#add('Yggdroot/indentLine')  " Space-indentation levels
  call dein#add('chrisbra/Recover.vim')  " Swap-file Compare

  call dein#add('Shougo/neosnippet.vim')  " Snippet engine
  call dein#add('Shougo/neosnippet-snippets')  " Snippet source

  call dein#add('Shougo/denite.nvim') " Interfaces
  call dein#add('Shougo/deoplete.nvim')  " Autocompletion

  call dein#add('Shougo/neco-vim')  " VimL Deoplete Source
  call dein#add('Shougo/neomru.vim')  " MRU
  call dein#add('carlitux/deoplete-ternjs')  " JavaScript Deoplete Source
  call dein#add('fszymanski/deoplete-emoji')  " Emoji Deoplete Source
  call dein#add('deoplete-plugins/deoplete-jedi')  " Python Deoplete Source
  "call dein#add('autozimu/LanguageClient-neovim', { 'build': 'bash install.sh', 'rev': 'next' })

  " Vim-compatiblity Plugins
  if !has('nvim')
    call dein#add('tpope/vim-sensible')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

if dein#check_install() | call dein#install() | endif
" ----------------
" }}}



" Plugin Settings {{{
" ----------------
" Deoplete
let g:deoplete#enable_at_startup = 1

" Neosnippet
let g:neosnippet#enable_completed_snippet = 1

" Denite
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" indentLine
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" ----------------
" }}}



" Vim Settings {{{
" ----------------

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
set undofile
set undodir=~/.cache/vim/undo

" ----------------
" }}}



" Keybindings {{{
" ----------------
let mapleader = "\<Space>"

" Save
nmap <Space><Esc> :w<CR>

" Yank/Pasting
nmap <Leader>p "+p
nmap <Leader>P "+P
map <Leader>y "+y

" Fuzzy Finders
nmap <silent> <Leader>c :Denite colorscheme<CR>
nmap <silent> <Leader>f :Denite -start-filter file/rec<CR>
nmap <silent> <Leader>b :Denite -start-filter buffer<CR>
nmap <silent> <Leader>/ :Denite -start-filter grep:::!<CR>
vmap <silent> <Leader>/ :DeniteCursorWord -start-filter grep:::!<CR>

" Auto-completion
imap <expr><CR> pumvisible() && neosnippet#expandable() ?
 \ '<Plug>(neosnippet_expand)' : neosnippet#jumpable() ?
 \ '<Plug>(neosnippet_jump)' : '<CR>'

" Search
nmap <plug>(slash-after) zz

" Line Navigation
map <S-h> g0
map <S-l> g_

" Counterpart to <S-j>
nmap <S-k> DO<Esc>p==

" ----------------
" }}}



" Filetypes {{{
" ----------------
augroup FILETYPES

  autocmd!

  autocmd FileType vue syntax sync fromstart

  autocmd FileType md call MarkdownSetup()
  function! MarkdownSetup()
    setlocal conceallevel=0
  endfunction

  autocmd FileType denite call DeniteSetup()
  function! DeniteSetup() abort
    nmap <silent><buffer><expr> <Esc> denite#do_map('quit')
    nmap <silent><buffer><expr> <CR> denite#do_map('do_action')
    nmap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
    nmap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
    nmap <silent><buffer><expr> q denite#do_map('quit')
    nmap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
  endfunction

  autocmd FileType denite-filter call DeniteFilterSetup()
  function! DeniteFilterSetup() abort
    imap <silent><buffer><expr> <Esc> denite#do_map('quit')
  endfunction

augroup END
" ----------------
" }}}



" Events {{{
" ----------------
autocmd VimEnter * nested call AutoloadSession()
function! AutoloadSession()
  if !argc() && filereadable('Session.vim')
    source Session.vim
    Obsess! Session.vim
  endif
endfunction
" ----------------
" }}}
