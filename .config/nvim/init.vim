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

Plug 'justinmk/vim-dirvish' " File browser
Plug 'brooth/far.vim'       " Find and replace :Far
Plug 'kkoomen/vim-doge'     " Documentation generator
Plug 'mkitt/tabline.vim'    " Tabline enhancements
Plug 'honza/vim-snippets'   " Snippets source
Plug 'wellle/targets.vim'   " Enhanced text objects
Plug 'junegunn/vim-slash'   " Enhanced buffer search
Plug 'Yggdroot/indentLine'  " Space-indentation levels
Plug 'tomtom/tcomment_vim'  " Comments
Plug 'chrisbra/Recover.vim' " Swap-file compare
Plug 'sheerun/vim-polyglot' " Syntax language pack

Plug 'machakann/vim-sandwich'         " Surroundings
Plug 'chriskempson/base16-vim'        " Base16 colorschemes
Plug 'junegunn/vim-easy-align'        " Text alignment
Plug 'AndrewRadev/splitjoin.vim'      " Single-line <--> Multi-line
Plug 'easymotion/vim-easymotion'      " Motions on speed
Plug 'radenling/vim-dispatch-neovim'  " Neovim compatibility for vim-dispatch
Plug 'christoomey/vim-tmux-navigator' " Window navigation

Plug 'iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#install()}}
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
call plug#end()
" ----------------
" }}}



" Plugin Settings {{{
" ----------------
" coc.nvim
let g:coc_global_extensions = [
  \   'coc-snippets', 'coc-word', 'coc-emoji', 'coc-json',
  \   'coc-tsserver', 'coc-vetur', 'coc-phpls', 'coc-vetur', 'coc-python'
  \ ]

let g:coc_user_config = {
  \   'diagnostic.level': 'warning'
  \ }

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" markdown-preview
let g:mkdp_auto_close = 0

" indentLine
let g:indentLine_fileTypeExclude = ['text', 'sh', 'markdown']

" vim-vue (vim-polyglot)
let g:vue_pre_processors = []

" fzf
function! FloatingFZF()
  let height = &lines > 20 ? float2nr(&lines * 0.50) : &lines
  let width = (&columns > 120 ? float2nr(120) : &columns) - 10
  let left = float2nr((&columns - width) / 2)
  let top = float2nr((&lines - height) / 2)

  let opts = {
    \   'style': 'minimal', 'relative': 'editor',
    \   'row': top, 'col': left, 'width': width, 'height': height,
    \ }

  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')
  call nvim_open_win(buf, v:true, opts)
endfunction

let $FZF_DEFAULT_OPTS =
  \ ' --bind ctrl-j:next-history,ctrl-k:previous-history,ctrl-n:down,ctrl-p:up'
" \.' --reverse'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = {'window': 'call FloatingFZF()'}
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
colorscheme base16-default-dark
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
" fzf
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



" Keybindings {{{
" ----------------
let mapleader = "\<space>"

" Line Navigation
map <s-h> ^
map <s-l> g_

" Yank/Pasting
map <leader>p "+p
map <leader>P "+P
map <leader>y "+y

" Fuzzy Finders
nmap <leader>f :Files<cr>
nmap <leader>F :GFiles<cr>
nmap <leader>d :Dirs<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>/ :Rg<cr>
nmap <leader>G :GGrep<cr>

" Diagnostics
nmap <leader>s :CocList symbols<cr>
nmap <silent> g[ <plug>(coc-diagnostic-prev)
nmap <silent> g] <plug>(coc-diagnostic-next)
nmap <silent> gh <plug>(coc-diagnostic-info)
xmap <silent> <leader>gf <plug>(coc-format-selected)
nmap <silent> <leader>n <plug>(coc-rename)
nmap gd <plug>(coc-definition)
nmap gy <plug>(coc-type-definition)
nmap gi <plug>(coc-implementation)
nmap gr <plug>(coc-references)

" Git
nmap gs :tab Gstatus<cr>
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
  autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd BufEnter *.txt,*.md setlocal nofen tw=80 "fo=aw2tq

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
