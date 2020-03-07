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

Plug 'brooth/far.vim'        " Find and replace :Far
Plug 'romainl/vim-cool'      " Search highlighting
Plug 'kkoomen/vim-doge'      " Documentation generator
Plug 'mkitt/tabline.vim'     " Tabline enhancements
Plug 'honza/vim-snippets'    " Snippets source
Plug 'wellle/targets.vim'    " Enhanced text objects
Plug 'Yggdroot/indentLine'   " Space-indentation levels
Plug 'tomtom/tcomment_vim'   " Comments
Plug 'sheerun/vim-polyglot'  " Syntax language pack
Plug 'justinmk/vim-dirvish'  " File browser
Plug 'wakatime/vim-wakatime' " Time management

Plug 'machakann/vim-sandwich'         " Surroundings
Plug 'junegunn/vim-easy-align'        " Text alignment
Plug 'AndrewRadev/splitjoin.vim'      " Single-line <--> Multi-line
Plug 'radenling/vim-dispatch-neovim'  " Neovim compatibility for vim-dispatch
Plug 'christoomey/vim-tmux-navigator' " Window navigation
Plug 'dracula/vim'

" Languages
Plug 'afternoon/vim-phpunit'

" Node Dependents
Plug 'iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#install()}}
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

" Fzf Dependents
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'

call plug#end()
" ----------------
" }}}



" Plugin Settings {{{
" ----------------
" coc.nvim
let g:coc_global_extensions = [
  \   'coc-snippets', 'coc-yank', 'coc-word', 'coc-emoji', 'coc-json',
  \   'coc-css', 'coc-vetur', 'coc-tsserver', 'coc-phpls', 'coc-python'
  \ ]

let g:coc_user_config = {
  \   'diagnostic.level': 'warning',
  \ }

" markdown-preview
let g:mkdp_auto_close = 0

" indentLine
let g:indentLine_fileTypeExclude = ['text', 'sh', 'markdown']

" vim-vue (vim-polyglot)
let g:vue_pre_processors = []

" fzf.vim
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

command! -bang -nargs=* GFiles call fzf#run(fzf#wrap({
  \   'source': 'git ls-files --exclude-standard --cached --others 2> /dev/null'
  \ }))

command! -bang -nargs=* GGrep call fzf#vim#grep(
  \   'git grep --line-number ' . shellescape(<q-args>) . ' 2> /dev/null', 0,
  \   {'dir': systemlist('git rev-parse --show-toplevel')[0]}, <bang>0
  \ )

command! -bang -nargs=* Rg call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '
  \ . shellescape(<q-args>) . ' 2> /dev/null',
  \   1, {'options': '--delimiter : --nth 4..'}, <bang>0
  \ )

command! -bang -nargs=* Dirs call fzf#run(fzf#wrap({
  \   'source': 'find * -type d 2> /dev/null'
  \ }))

" ----------------
" }}}



" Vim Settings {{{
" ----------------
syntax enable
colorscheme dracula
filetype plugin indent on

set nowrap
set inccommand=nosplit  " Incremental updates for substitute
set updatetime=300
set splitbelow
set splitright
set termguicolors
set expandtab
set shiftwidth=2
set wildoptions=pum
set wildignore+=*/vendor/*
set wildignore+=*/node_modules/*
set pumheight=15
set pumblend=5
set number
set relativenumber
set colorcolumn=81
set scrolloff=2
set undofile
set undodir=$sharedir/undo
set timeoutlen=500
set fsync  " Prevent losing file contents on system crash

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

nmap <leader>rc :sp $MYVIMRC<cr>
inoremap <C-c> <Esc><Esc>

" Line Navigation
map <s-h> ^
map <s-l> g_

map <silent> <leader> :nohl<cr>

" Yank/Pasting
map <leader>p "+p
map <leader>P "+P
map <leader>y "+y

" Fuzzy Finders
nmap <leader>f :Files<cr>
nmap <leader>d :Dirs<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>h :History<cr>
nmap <leader>l :Lines<cr>
nmap <leader>/ :Rg<cr>
nmap <leader>? :GGrep<cr>

nmap <silent> <leader>r :CocFzfListResume<cr>
nmap <silent> <leader>t :CocFzfList diagnostics<cr>
nmap <silent> <leader>c :CocFzfList commands<cr>
nmap <silent> <leader>e :CocFzfList extensions<cr>
nmap <silent> <leader>L :CocFzfList location<cr>
nmap <silent> <leader>o :CocFzfList outline<cr>
nmap <silent> <leader>s :CocFzfList symbols<cr>
nmap <silent> <leader>S :CocFzfList services<cr>

" Diagnostics
xmap <leader>a   <plug>(coc-codeaction-selected)
nmap <leader>a   <plug>(coc-codeaction-selected)
nmap <leader>ac  <plug>(coc-codeaction)
nmap <leader>qf  <plug>(coc-fix-current)
nmap <silent> gn <plug>(coc-rename)
nmap <silent> gh <plug>(coc-diagnostic-info)
nmap <silent> [g <plug>(coc-diagnostic-prev)
nmap <silent> ]g <plug>(coc-diagnostic-next)

nmap gd <plug>(coc-definition)
nmap gy <plug>(coc-type-definition)
nmap gi <plug>(coc-implementation)
nmap gr <plug>(coc-references)

" Quickfix
nmap <silent> <leader>] :cnext<cr>
nmap <silent> <leader>[ :cprevious<cr>

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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
augroup END
" ----------------
" }}}



" Events {{{
" ----------------
augroup EVENTS
  autocmd! BufWritePre <buffer> %s/\s\+$//e
  autocmd! BufWritePost $MYVIMRC source $MYVIMRC
  autocmd! BufEnter *.txt,*.md setlocal nofen tw=80 "fo=aw2tq
  autocmd! CursorHold * silent call CocActionAsync('highlight')
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



" Projects {{{
augroup PROJECTS
  autocmd BufRead,BufNewFile **/gidget4/backend/*.php
    \ let b:dispatch = './scripts/run_tests --filter %:t:r'
augroup END
" }}}
