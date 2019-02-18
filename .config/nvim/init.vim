" vim: set filetype=vim:
"""
""" Plugins
"""
if has('nvim')
  let vimpath = '~/.local/share/nvim'
  let plugpath = vimpath . '/site/autoload/plug.vim'
  let pluginspath = vimpath . '/plugged'
else
  let vimpath = '~/.vim'
  let plugpath = vimpath . '/autoload/plug.vim'
  let pluginspath = vimpath . '/plugged'
endif

" Plug Installer
if empty(glob(plugpath))
  exec 'silent !curl -fLo ' . plugpath . ' --create-dirs ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  augroup PLUG
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

" Plugins
call plug#begin(pluginspath)

" Vim 8
if !has('nvim')
  Plug 'tpope/vim-sensible'            " Sensible defaults
  Plug 'markonm/traces.vim'            " Live substitute for Vim 8
  Plug 'roxma/vim-hug-neovim-rpc'      " Neovim RPC client for Vim 8
endif

" Dependencies
Plug 'roxma/nvim-yarp'                 " Remote plugin framework
Plug 'prabirshrestha/async.vim'        " Async job control API
Plug 'prabirshrestha/vim-lsp'          " Language Server Protocl
if has('nvim')
  Plug 'radenling/vim-dispatch-neovim' " Neovim's term for Vim 8 plugins
endif

" Completion
Plug 'ncm2/ncm2'                       " Completion framework
Plug 'ncm2/ncm2-bufword'               " Addon: completion from current buffer
Plug 'ncm2/ncm2-path'                  " Addon: completion from path
Plug 'ncm2/ncm2-jedi'                  " Addon: completion for python
Plug 'ncm2/ncm2-github'                " Addon: completion for github links
Plug 'ncm2/ncm2-tmux'                  " Addon: completion for tmux panes
Plug 'ncm2/ncm2-ultisnips'             " Addon: completion from ultisnips engine
Plug 'ncm2/ncm2-vim-lsp'               " Addon: completion from language clients
Plug 'phpactor/ncm2-phpactor'          " Addon: completion for PHP

" Files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                " Fuzzy file finder
Plug 'tpope/vim-vinegar'               " Netrw improvements

" Snippets
Plug 'SirVer/ultisnips'                " Snippets engine
Plug 'honza/vim-snippets'              " Snippets

" Navigation
Plug 'unblevable/quick-scope'          " Highlighting for f and t
Plug 'justinmk/vim-sneak'              " Easy cursor jumping; s/S
Plug 'christoomey/vim-tmux-navigator'  " Tmux split navigation

" Session
Plug 'xolox/vim-session'               " Session management
Plug 'xolox/vim-misc'                  " Extended standard library

" Text
Plug 'tpope/vim-commentary'            " Commenting; [visual]gc
Plug 'tpope/vim-surround'              " Text surroundings
Plug 'junegunn/vim-easy-align'         " Text alignment; [visual]ga
Plug 'tommcdo/vim-exchange'            " Swap selections of code
Plug 'jiangmiao/auto-pairs'            " {}, ''

" Visual
Plug 'Yggdroot/indentLine'             " Space indentation
Plug 'machakann/vim-highlightedyank'   " Briefly highlight yanked text
Plug 'romainl/vim-cool'                " Unhighlight searches

" Themes
Plug 'morhetz/gruvbox'                 " Gruvbox colorscheme
Plug 'drewtempelmeyer/palenight.vim'   " Palenight colorscheme

" UI
Plug 'vim-airline/vim-airline'         " Status line
Plug 'vim-airline/vim-airline-themes'  " Colorschemes for vim airline
Plug 'ryanoasis/vim-devicons'          " Icons for NERDTree and Airline
Plug 'junegunn/goyo.vim'               " Distraction free writing
Plug 'majutsushi/tagbar'               " Class outline viewer

" Functionality
Plug 'tpope/vim-dispatch'              " Async build & test dispatcher
Plug 'tpope/vim-dadbod'                " Database interface
Plug 'tpope/vim-repeat'                " Repeat for supported plugins
Plug 'tpope/vim-fugitive'              " Git; :Gstatus, :Gcommit, ...
Plug 'tpope/vim-sleuth'                " Indentation detection
Plug 'tpope/vim-eunuch'                " Unix shell commands
Plug 'moll/vim-bbye'                   " Close buffer; :Bdelete

" Languages
Plug 'davidhalter/jedi-vim'            " Python autocompletion
Plug 'phpactor/phpactor', {'do': 'composer install', 'for': 'php'}

" Syntax
Plug 'sheerun/vim-polyglot'            " Defaults for languages
Plug 'mboughaba/i3config.vim'          " i3 syntax highlighting


call plug#end()


"""
""" Built-in Settings
"""
syntax on
colorscheme gruvbox
set encoding=UTF-8
set t_Co=256
set background=dark
set hidden
if has('termguicolors')
 set termguicolors
endif

" Persistent Undo
if has('persistent_undo')
  let &undodir = expand('$HOME/.vim/undo')
  call system('mkdir -p ' . &undodir)
  set undofile
endif

" Mouse
"set mouse=a

" Cursor
set scrolloff=2
set nocursorline
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"

" List
set list
set listchars=tab:\ ,trail:\ ,precedes:^,extends:$,eol:¬

" Commands
set showcmd

" Conceal
set conceallevel=2

" Regex Engine
set regexpengine=1

" Timeouts
set timeoutlen=1000
set ttimeoutlen=0

" Rulers
set colorcolumn=81

" Wrapping
set wrap!

" Indentation
set shiftwidth=0
set tabstop=4
set noexpandtab
set smarttab

" Leader
let mapleader = ' '

" Live substitution
if has('nvim')
  set inccommand=nosplit
endif

" Line numbers
set number
set relativenumber

" Status
set showmode!

" Splits
set splitbelow
set splitright

" Sessions
let g:sessions_dir = '~/.vim/sessions'

" Messages
set shortmess+=c

" Completion
set completeopt+=menuone,noinsert
set completeopt-=preview



"""
""" Built-in Mappings
"""

" New lines
nnoremap <Enter> i<Enter><Esc>

" Make
nnoremap <silent> M :make<CR>

" Searching
set ignorecase
set smartcase

" Write current directory
nnoremap <Leader>L :!echo %:p:h > ~/.previous-dir<CR><CR>

" Source
nnoremap <Leader>S :source $MYVIMRC<CR>

" Terminal
tnoremap <Leader><Esc> <C-\><C-n>
tnoremap <C-p> i<C-P>
tnoremap <C-h> <C-\><C-n><C-W><C-H>
tnoremap <C-j> <C-\><C-n><C-W><C-J>
tnoremap <C-k> <C-\><C-n><C-W><C-K>
tnoremap <C-l> <C-\><C-n><C-W><C-L>

" Cut and Paste
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>P "+P

" Save
noremap <Space><Esc> :w<CR>
noremap <C-s> :w<CR>

" Buffer navigation
noremap <Leader>j :bprev<CR>
noremap <Leader>k :bnext<CR>
noremap <Leader>q :Bdelete<CR>
noremap <C-p> :tabprev<CR>
noremap <C-n> :tabnext<CR>

" Tab navigation
noremap <Leader>h :tabp<CR>
noremap <Leader>l :tabn<CR>

" Split navigation
map <Leader> <Nop>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" Split Resizing
nnoremap <C-w><C-y> :vertical resize -5<CR>
nnoremap <C-w><C-u> :resize -5<CR>
nnoremap <C-w><C-i> :resize +5<CR>
nnoremap <C-w><C-o> :vertical resize +5<CR>

" Visual
vnoremap - g_
vnoremap // y/<C-R>"<CR>



"""
""" Plugin Settings
"""

" Vim Sessions
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_symbols.linenr = 'Ξ'

" FZF
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <Leader>s :Ag<CR>

" Sneak
let g:sneak#label = 1

" Quickscope
let g:qs_highlight_on_keys = ['F', 'T', 'f', 't']

" Ultisnips
let g:UltiSnipsJumpForwardTrigger = "<c-f>"
let g:UltiSnipsJumpBackwardTrigger = "<c-b>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" Easy Align
xmap ga <Plug>(EasyAlign)

" Indents
let g:indentLine_char = ''
let g:indentLine_leadingSpaceChar = ' '
let g:indentLine_conceallevel  = &conceallevel
let g:indentLine_concealcursor = &concealcursor

" Netrw
let g:netrw_liststyle = 3
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_localrmdir='rm -r'
function! Netrw(cmd)
  if exists('b:sid') | execute "call " . b:sid . a:cmd | endif
endfunction
function! NetrwBuf()
  " https://github.com/vim/vim/blob/master/runtime/autoload/netrw.vim
  let b:sid = matchstr(maparg('%', 'n'), '<SNR>\d\+_')  " Netrw's <SID>
  nmap <buffer> t :call Netrw("NetrwOpenFile(1)")<CR>
endfunction

" NERDTree
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>

" Tagbar
nnoremap <Leader>T :TagbarToggle<CR>

" Highlightedyank
let g:highlightedyank_highlight_duration = 250

" Goyo
nmap <silent> <Leader>G :Goyo<CR>
let g:goyo_linenr = 1
function! s:goyo_enter()
  let g:goyo_wrap = &wrap
  let g:goyo_linebreak = &linebreak
  set wrap
  set linebreak
  nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
  nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
  nnoremap <silent> 0 g0
  nnoremap <silent> $ g$
endfunction
function! s:goyo_leave()
  if g:goyo_wrap == 0 | set nowrap | endif
  if g:goyo_linebreak == 0 | set linebreak | endif
  nnoremap <silent> j j
  nnoremap <silent> k k
  nnoremap <silent> 0 g0
  nnoremap <silent> $ g$
endfunction

" Auto pairs
let g:AutoPairsMapCR=0
inoremap <silent> <Plug>(MyCR) <CR><C-R>=AutoPairsReturn()<CR>

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
inoremap <silent><expr> <CR> pumvisible() ? ncm2_ultisnips#expand_or('', 'n') : '<CR><C-R>=AutoPairsReturn()<CR>'

" vim-lsp
if executable('bash-language-server')
  au User lsp_setup call lsp#register_server({
    \   'name': 'bash-language-server',
    \   'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
    \   'whitelist': ['sh'],
    \ })
endif



"""
""" Functions
"""
function! TwoSpaceIndent()
  setlocal tabstop=2
  setlocal softtabstop=2
  setlocal expandtab
endfunction



"""
""" Autocmd Groups
"""
" File Types
augroup FILETYPES
  autocmd FileType netrw    call NetrwBuf()
  autocmd FileType vim      call TwoSpaceIndent()
  autocmd FileType python   call TwoSpaceIndent()
  autocmd FileType html     call TwoSpaceIndent()
  autocmd FileType vue      call TwoSpaceIndent()
  autocmd FileType json     call TwoSpaceIndent()
  autocmd FileType netrw    setlocal bufhidden=delete
augroup END

" Vim Events
augroup EVENTS
  autocmd FocusGained,VimResized * :redraw!
  autocmd User GoyoEnter nested call <SID>goyo_enter()
  autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END
