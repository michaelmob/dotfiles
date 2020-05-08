" vim: et sw=2 fdm=marker fmr={{{,}}}
" https://github.com/tarkusdev/dotfiles



" Variables {{{
" ----------------
let $sharedir = expand('$HOME/.local/share/nvim')
let $plugdir  = expand($sharedir . '/site/autoload')
" ----------------
" }}}



" Plugins {{{
" ----------------
if empty(glob($plugdir))
  exec 'silent !curl -fLo ' . $plugdir . '/plug.vim --create-dirs'
  \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin($plugdir)

Plug 'airblade/vim-rooter'            " Change directory to project root
Plug 'brooth/far.vim'                 " Find and replace :Far
Plug 'christoomey/vim-tmux-navigator' " Window navigation
Plug 'chriskempson/base16-vim'        " Base16 colorscheme pack
Plug 'easymotion/vim-easymotion'      " Faster motions
Plug 'honza/vim-snippets'             " Snippets source
Plug 'justinmk/vim-dirvish'           " File browser
Plug 'junegunn/vim-easy-align'        " Text alignment
Plug 'junegunn/vim-peekaboo'          " Register/macro viewer
Plug 'junegunn/goyo.vim'              " Distraction-free writing
Plug 'junegunn/limelight.vim'         " Focused writing
Plug 'ludovicchabant/vim-gutentags'   " Automatic ctags
Plug 'kkoomen/vim-doge'               " Documentation generator
Plug 'machakann/vim-sandwich'         " Surroundings
Plug 'mbbill/undotree'                " Undo tree
Plug 'mkitt/tabline.vim'              " Tabline enhancements
Plug 'reedes/vim-litecorrect'         " Autocorrection
Plug 'reedes/vim-pencil'              " Writing mode
Plug 'romainl/vim-cool'               " Search highlighting
Plug 'sheerun/vim-polyglot'           " Syntax language pack
Plug 'skywind3000/asyncrun.vim'       " Dispatching
Plug 'tomtom/tcomment_vim'            " Comments
Plug 'tpope/vim-apathy'               " Paths
Plug 'tpope/vim-eunuch'               " Unix helper commands
Plug 'tpope/vim-fugitive'             " Git wrapper
Plug 'tpope/vim-obsession'            " Sessions
Plug 'tpope/vim-repeat'               " Repeating
Plug 'tpope/vim-rsi'                  " Readline
Plug 'tpope/vim-sleuth'               " Detect and set buffer options
Plug 'wakatime/vim-wakatime'          " Time management
Plug 'wellle/targets.vim'             " Enhanced text objects
Plug 'AndrewRadev/splitjoin.vim'      " Single-line <--> Multi-line
Plug 'Yggdroot/indentLine'            " Space-indentation levels

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

Plug 'iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#install()}}

call plug#end()
" ----------------
" }}}



" Plugin Settings {{{
" ----------------
" coc.nvim
let g:coc_global_extensions = [
\  'coc-snippets', 'coc-yank', 'coc-emoji', 'coc-json', 'coc-css',
\  'coc-tsserver', 'coc-phpls', 'coc-python', 'coc-vetur'
\]

let g:coc_user_config = {
\  'diagnostic.level': 'warning',
\}

" vim-easy-align
let g:easy_align_delimiters = { '\': { 'pattern': '\\' } }

" markdown-preview.nvim
let g:mkdp_auto_close = 0

" indentLine
let g:indentLine_fileTypeExclude = ['text', 'sh', 'markdown', 'fzf']
let g:indentLine_char = '▏'
let g:indentLine_first_char = g:indentLine_char
let g:indentLine_showFirstIndentLevel = 1

" vim-dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'

" vim-sandwich
runtime macros/sandwich/keymap/surround.vim

" vim-doge
let g:doge_mapping = 'gcd'
let g:doge_mapping_comment_jump_forward = '<c-j>'
let g:doge_mapping_comment_jump_backward = '<c-k>'
let g:doge_filetype_aliases = { 'javascript': ['vue'] }

" vim-vue (vim-polyglot)
let g:vue_pre_processors = []

" vim-rooter
let g:rooter_patterns = ['Session.vim', 'Makefile', 'Dockerfile', '.git', '.git/']

" vim-gutentags
let g:gutentags_project_root = g:rooter_patterns
let g:gutentags_file_list_command = 'rg -g "!node_modules" -g "!*.json" --files'

" fzf.vim
let g:fzf_tags_command = g:gutentags_file_list_command . ' | ctags -R --links=no -L -'
let g:fzf_history_dir = expand('$HOME/.local/share/fzf-history')
" ----------------
" }}}



" Vim Settings {{{
" ----------------
syntax enable
colorscheme base16-default-dark
filetype plugin indent on

set nowrap
set inccommand=nosplit
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
set scrolloff=999
set sidescrolloff=2
set undofile
set undodir=$sharedir/undo
set timeoutlen=500
set fsync
" ----------------
" }}}



" Commands {{{
" ----------------
command! -nargs=1 Swap :normal! mA<c-w><args>mB'A<c-w>p'B<c-w>p

command! -bang -nargs=* Rg call fzf#vim#grep(
\ 'rg --column --line-number --no-heading --color=always --smart-case '
\ . shellescape(<q-args>) . ' 2> /dev/null', 1,
\ {'options': '--delimiter : --nth 4..'}, <bang>0)

command! -bang -nargs=* Dirs call fzf#run(fzf#wrap({
\ 'source': 'find * -type d 2> /dev/null' }))
" ----------------
" }}}



" Keybindings {{{
" ----------------
let mapleader = "\<space>"

" Windows
nmap <leader>w  <c-w>
nmap <leader>ws <c-w>s-
nmap <leader>wv <c-w>v-
nmap <silent><leader>wc :enew\|bd#<cr>

" Swap window buffers
nmap <silent><c-w>H :Swap h<cr>
nmap <silent><c-w>J :Swap j<cr>
nmap <silent><c-w>K :Swap k<cr>
nmap <silent><c-w>L :Swap l<cr>

" Files
nmap <leader>j :w<CR>

" Text
nnoremap vw viw
nnoremap cw ciw

" Indentation
xnoremap > >gv
xnoremap < <gv

" Surround
nmap S viwS
map Sc Sfconsole.log<cr>
map Sd Sfconsole.debug<cr>
map Sj SfJSON.stringify<cr>

" Line Navigation
noremap H ^
noremap L g_

" Yank/Pasting
nnoremap p p=`]
map <leader>p "+p
map <leader>P "+P
map <leader>y "+y

" Finders
nmap <leader><leader> :Tags<cr>
nmap <leader>f :Files<cr>
nmap <leader>d :Dirs<cr>
nmap <leader>s :Rg<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>h :History<cr>
nmap <leader>l :Lines<cr>
nmap <leader>g :Commits<cr>
nmap <leader>c :Color<cr>

" LSP Finders
nmap <silent> <leader>kr :CocFzfListResume<cr>
nmap <silent> <leader>kd :CocFzfList diagnostics<cr>
nmap <silent> <leader>kc :CocFzfList commands<cr>
nmap <silent> <leader>ke :CocFzfList extensions<cr>
nmap <silent> <leader>kl :CocFzfList location<cr>
nmap <silent> <leader>ko :CocFzfList outline<cr>
nmap <silent> <leader>ks :CocFzfList symbols<cr>
nmap <silent> <leader>kS :CocFzfList services<cr>

" LSP Actions
nmap <silent> gk <plug>(coc-rename)
nmap <silent> gh <plug>(coc-diagnostic-info)
nmap <silent> [g <plug>(coc-diagnostic-prev)
nmap <silent> ]g <plug>(coc-diagnostic-next)
nmap <silent> gd <plug>(coc-definition)
nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)

" LSP Diagnostics
xmap <silent> <leader>a  <plug>(coc-codeaction-selected)
nmap <silent> <leader>a  <plug>(coc-codeaction-selected)
nmap <silent> <leader>ac <plug>(coc-codeaction)
nmap <silent> <leader>qf <plug>(coc-fix-current)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Quickfix
nmap <silent> <leader>] :cnext<cr>
nmap <silent> <leader>[ :cprevious<cr>

" Git
nmap <leader>gg :tab Gstatus<cr>

" Formating
nmap ga <plug>(EasyAlign)
xmap ga <plug>(EasyAlign)

" Terminal
tmap <c-u> <c-\><c-n><c-u>

" EasyMotion
map <leader>e <plug>(easymotion-prefix)
map s <plug>(easymotion-overwin-f2)
" ----------------
" }}}



" Filetypes {{{
" ----------------
augroup FILETYPES
  autocmd!
  autocmd FileType javascript let b:dispatch = 'npm test -- %'
  autocmd FileType vue syntax sync fromstart
  autocmd FileType help,qf,vim-plug nmap <buffer> <esc> :q<cr>
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
" ----------------
augroup PROJECTS
  autocmd BufRead,BufNewFile **/gidget4/backend/*.php
    \ let b:dispatch = './scripts/run_tests --filter %:t:r'
augroup END
" ----------------
" }}}
