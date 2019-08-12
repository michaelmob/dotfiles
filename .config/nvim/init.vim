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

Plug 'Shougo/neosnippet.vim'  " Snippet engine
Plug 'Shougo/neosnippet-snippets'  " Snippet source

Plug 'Shougo/denite.nvim' " Selection menu
Plug 'Shougo/deoplete.nvim'  " Autocompletion

Plug 'Shougo/neoyank.vim'  " Yank denite source
Plug 'Shougo/neco-vim'  " VimL deoplete source
Plug 'Shougo/neomru.vim'  " MRU deoplete source
Plug 'carlitux/deoplete-ternjs'  " JavaScript deoplete source
Plug 'fszymanski/deoplete-emoji'  " Emoji deoplete source
Plug 'deoplete-plugins/deoplete-jedi'  " Python deoplete source
"Plug 'autozimu/LanguageClient-neovim', { 'build': 'bash install.sh', 'rev': 'next' }

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
set undofile
set undodir=~/.cache/vim/undo

" ----------------
" }}}



" Keybindings {{{
" ----------------
let mapleader = "\<Space>"

" Save
nmap <Space><Esc> :w<CR>

" Tab control
nmap tc :tabclose

" Yank/Pasting
nmap <Leader>p "+p
nmap <Leader>P "+P
map <Leader>y "+y

" Fuzzy Finders
nmap <silent> <Leader>c :Denite colorscheme<CR>
nmap <silent> <Leader>f :Denite -start-filter file/rec<CR>
nmap <silent> <Leader>b :Denite -start-filter buffer<CR>
nmap <silent> <Leader>/ :Denite -start-filter grep:::!<CR>
vmap <silent> <Leader>/ :DeniteCursorWord grep:::!<CR>

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

  autocmd FileType help call HelpSetup()
  function! HelpSetup()
    nmap <silent><buffer> <Esc> :q<CR>
  endfunction

  autocmd FileType denite call DeniteSetup()
  function! DeniteSetup() abort
    nmap <silent><buffer><expr> <CR> denite#do_map('do_action')
    nmap <silent><buffer><expr> <Esc> denite#do_map('quit')
    nmap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
    nmap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
    nmap <nowait> <silent><buffer><expr> <Space> denite#do_map('toggle_select') . 'j'

    nmap <nowait> <silent><buffer><expr> y denite#do_map('do_action', 'mkdir')
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
