" vim: et sw=2 fdm=marker fmr={{{,}}}
" github.com/thetarkus/dotfiles



" Variables {{{
let $cachedir = expand('$HOME/.local/share/nvim')
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

Plug 'tpope/vim-rsi'        " Readline
Plug 'tpope/vim-eunuch'     " Unix helper commands
Plug 'tpope/vim-sleuth'     " Detect and set buffer options
Plug 'tpope/vim-repeat'     " Repeating
Plug 'tpope/vim-apathy'     " Paths
Plug 'tpope/vim-fugitive'   " Git wrapper
Plug 'tpope/vim-dispatch'   " Async dispatching
Plug 'tpope/vim-obsession'  " Sessions
Plug 'justinmk/vim-dirvish' " File browser

Plug 'brooth/far.vim'                 " Find and replace :Far
Plug 'kkoomen/vim-doge'               " Documentation generator
Plug 'mkitt/tabline.vim'              " Tabline enhancements
Plug 'honza/vim-snippets'             " Snippets source
Plug 'wellle/targets.vim'             " Enhanced text objects
Plug 'junegunn/vim-slash'             " Enhanced buffer search
Plug 'Yggdroot/indentLine'            " Space-indentation levels
Plug 'tomtom/tcomment_vim'            " Comments
Plug 'jiangmiao/auto-pairs'           " Automatic bracket, parenthesis, quote pairing
Plug 'chrisbra/Recover.vim'           " Swap-file compare
Plug 'sheerun/vim-polyglot'           " Syntax language pack
Plug 'machakann/vim-sandwich'         " Surroundings
Plug 'chriskempson/base16-vim'        " Base16 colorschemes
Plug 'junegunn/vim-easy-align'        " Text alignment
Plug 'AndrewRadev/splitjoin.vim'      " Single-line <--> Multi-line
Plug 'easymotion/vim-easymotion'      " Motions on speed
Plug 'christoomey/vim-tmux-navigator' " Window navigation

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#install()}}

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

" coc.nvim
let g:coc_global_extensions = [
  \   'coc-snippets', 'coc-word', 'coc-emoji', 'coc-json',
  \   'coc-tsserver', 'coc-vetur', 'coc-phpls', 'coc-vetur'
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

" autopairs
let g:AutoPairsMultilineClose = 0

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
set undodir=$cachedir/undo

" Key timeout
set timeoutlen=500

" Prevent losing file contents on system crash
set fsync

" Dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'

" vim-doge
let g:doge_mapping = 'gcd'
let g:doge_mapping_comment_jump_forward = '<C-j>'
let g:doge_mapping_comment_jump_backward = '<C-k>'


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
let mapleader = "\<Space>"

" Escape
imap jk <Esc>

" Save
nmap <leader><leader> :w<CR>

" Undo/Redo
inoremap <expr> <silent> <C-u> '<C-o>u'
inoremap <expr> <silent> <C-r> '<C-o><C-r>'

" Yank/Pasting
map <leader>p "+p
map <leader>P "+P
map <leader>y "+y

" Fuzzy Finders
nmap <leader>f :Files<CR>
nmap <leader>F :GFiles<CR>
nmap <leader>d :Dirs<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>/ :Rg<CR>
nmap <leader>G :GGrep<CR>
nmap <leader>s :CocList symbols<CR>

" Coc.nvim
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)
nmap <silent> gh <Plug>(coc-diagnostic-info)
xmap <leader>gf <Plug>(coc-format-selected)
nmap <leader>n <Plug>(coc-rename)
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

" Easy Motion
nmap s <Plug>(easymotion-s2)

" Search
nmap <plug>(slash-after) zz

" Line Navigation
map <S-h> ^
map <S-l> g_

" Fugitive
nmap gs :tab Gstatus<CR>
nmap <leader>gd :Gdifftab<CR>

" Easy align
xmap ga <Plug>(EasyAlign)
nmap <leader>at vipga*\|  " Align Table
" ----------------
" }}}



" Filetypes {{{
" ----------------
augroup FILETYPES
  autocmd!
  autocmd FileType javascript let b:dispatch = 'npm test -- %'
  autocmd FileType vue syntax sync fromstart
  autocmd FileType help,qf,vim-plug nmap <silent><buffer> <Esc> :q<CR>
  autocmd FileType vim setlocal noautoindent
augroup END
" ----------------
" }}}



" Events {{{
" ----------------
augroup EVENTS
  autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd BufEnter *.txt,*.md setlocal nofen tw=80 "fo=aw2tq
augroup END
" ----------------
" }}}
