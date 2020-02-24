" vim: et sw=2 fdm=marker fmr={{{,}}}
" https://github.com/tarkusdev/dotfiles


" Variables {{{
let $sharedir = expand('$HOME/.local/share/nvim')
let $plugdir = expand($sharedir . '/site/autoload')
" }}}



" Plugins {{{
" ----------------
if empty(glob($plugdir))
  exec 'silent !curl -fLo ' . $plugdir . '/plug.vim --create-dirs'
  \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin($plugdir)
Plug 'tpope/vim-rsi'        " Readline
Plug 'tpope/vim-eunuch'     " Unix helper commands
Plug 'tpope/vim-sleuth'     " Detect and set buffer options
Plug 'tpope/vim-repeat'     " Repeating
Plug 'tpope/vim-apathy'     " Paths
Plug 'tpope/vim-fugitive'   " Git wrapper
Plug 'tpope/vim-dispatch'   " Async dispatching
Plug 'tpope/vim-obsession'  " Sessions

Plug 'brooth/far.vim'       " Find and replace :Far
Plug 'kkoomen/vim-doge'     " Documentation generator
Plug 'mkitt/tabline.vim'    " Tabline enhancements
Plug 'honza/vim-snippets'   " Snippets source
Plug 'wellle/targets.vim'   " Enhanced text objects
Plug 'Yggdroot/indentLine'  " Space-indentation levels
Plug 'tomtom/tcomment_vim'  " Comments
Plug 'sheerun/vim-polyglot' " Syntax language pack
Plug 'justinmk/vim-dirvish' " File browser

Plug 'machakann/vim-sandwich'         " Surroundings
Plug 'junegunn/vim-easy-align'        " Text alignment
Plug 'AndrewRadev/splitjoin.vim'      " Single-line <--> Multi-line
Plug 'radenling/vim-dispatch-neovim'  " Neovim compatibility for vim-dispatch
Plug 'christoomey/vim-tmux-navigator' " Window navigation
Plug 'chriskempson/base16-vim'        " Base16 colorschemes

Plug 'iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#install()}}
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
call plug#end()
" ----------------
" }}}



" Plugin Settings {{{
" ----------------
" coc.nvim
let g:coc_global_extensions = [
  \ 'coc-snippets', 'coc-word', 'coc-emoji', 'coc-json', 'coc-css', 'coc-yank',
  \ 'coc-tsserver', 'coc-vetur', 'coc-phpls', 'coc-vetur', 'coc-python'
  \ ]

let g:coc_user_config = {
  \   'diagnostic.level': 'warning'
  \ }

" markdown-preview
let g:mkdp_auto_close = 0

" indentLine
let g:indentLine_fileTypeExclude = ['text', 'sh', 'markdown']

" vim-vue (vim-polyglot)
let g:vue_pre_processors = []
" ----------------
" }}}



" Vim Settings {{{
" ----------------
" Mouse
set mouse=a

" Incremental substitute
set inccommand=nosplit

" Splits
set splitbelow
set splitright

" Colors
set termguicolors
colorscheme base16-onedark
syntax enable

" Text
set nowrap

" Indentation
set expandtab
set shiftwidth=2
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
set undodir=$sharedir/undo

" Key timeout
set timeoutlen=500

" Prevent losing file contents on system crash
set fsync

" Dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'

" vim-doge
let g:doge_mapping = 'gcd'
let g:doge_mapping_comment_jump_forward = '<c-j>'
let g:doge_mapping_comment_jump_backward = '<c-k>'
let g:doge_filetype_aliases = {
  \   'javascript': ['vue']
  \ }
" ----------------
" }}}



" Commands {{{
" ----------------
command! -nargs=1 Swap :normal! mA<c-w><args>mB'A<c-w>p'B<c-w>p
" }}}



" Keybindings {{{
" ----------------
let mapleader = "\<space>"

" Swap window buffers
nmap <c-w><c-h> :Swap h<cr>
nmap <c-w><c-j> :Swap j<cr>
nmap <c-w><c-k> :Swap k<cr>
nmap <c-w><c-l> :Swap l<cr>

" Line Navigation
map <s-h> ^
map <s-l> g_

map <silent> <leader> :nohl<cr>

" Yank/Pasting
map <leader>p "+p
map <leader>P "+P
map <leader>y "+y

" Fuzzy Finders
nmap <leader>f :CocList files<cr>
nmap <leader>b :CocList buffers<cr>
nmap <leader>l :CocList lines<cr>
nmap <leader>/ :CocList grep<cr>
nnoremap <silent> <space>Y  :<C-u>CocList -A --normal yank<cr>

" Diagnostics
nmap <leader>s :CocList symbols<cr>
nmap <silent> [g <plug>(coc-diagnostic-prev)
nmap <silent> ]g <plug>(coc-diagnostic-next)
nmap <silent> gh <plug>(coc-diagnostic-info)
xmap <silent> <leader>gf <plug>(coc-format-selected)
nmap <silent> <leader>n <plug>(coc-rename)
nmap gd <plug>(coc-definition)
nmap gy <plug>(coc-type-definition)
nmap gi <plug>(coc-implementation)
nmap gr <plug>(coc-references)

" Git
nmap gs :tab Gstatus<cr>

" Formating
nmap ga <plug>(EasyAlign)
xmap ga <plug>(EasyAlign)
" ----------------
" }}}



" Filetypes {{{
" ----------------
augroup FILETYPES
  autocmd!
  autocmd FileType javascript let b:dispatch = 'npm test -- %'
  autocmd FileType vue syntax sync fromstart
  autocmd FileType help,qf,vim-plug nmap <silent><buffer> <esc> :q<cr>
  autocmd FileType vim setlocal noautoindent
augroup END
" ----------------
" }}}



" Events {{{
" ----------------
augroup EVENTS
  autocmd! BufWritePre <buffer> %s/\s\+$//e
  autocmd! BufWritePost $MYVIMRC source $MYVIMRC
  autocmd! BufEnter *.txt,*.md setlocal nofen tw=80 "fo=aw2tq

  autocmd! VimEnter * nested call AutoloadSession()
  function! AutoloadSession()
    if !argc() && filereadable('Session.vim')
      source Session.vim
      Obsess! Session.vim
    endif
  endfunction
augroup END
" ----------------
" }}}
