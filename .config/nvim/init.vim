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

" Vim 8 Compatibility
if !has('nvim')
  Plug 'tpope/vim-sensible'       " Sensible defaults
  Plug 'markonm/traces.vim'       " Live substitute for vim
endif

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'  " Fuzzy finder

" Functionality
Plug 'lifepillar/vim-mucomplete'      " Autocompletion
Plug 'tpope/vim-surround'             " Surround text; [visual]S <p>
Plug 'tpope/vim-vinegar'              " Better netrw defaults
Plug 'tpope/vim-commentary'           " Commenting; [visual]gc
Plug 'tpope/vim-fugitive'             " Git; :Gstatus, :Gcommit, ...
Plug 'tpope/vim-repeat'               " Repeat for supported plugins
Plug 'tpope/vim-sleuth'               " Indentation detection
Plug 'junegunn/vim-easy-align'        " Text alignment; [visual]ga
Plug 'justinmk/vim-sneak'             " Easy cursor jumping; s/S
Plug 'tommcdo/vim-exchange'           " Swap selections of code
Plug 'machakann/vim-highlightedyank'  " Briefly highlight yanked text
Plug 'christoomey/vim-tmux-navigator' " Tmux split navigation
Plug 'moll/vim-bbye'                  " Close buffer; :Bdelete
Plug 'majutsushi/tagbar'              " Class outline viewer
Plug 'unblevable/quick-scope'         " Highlighting for f and t
Plug 'SirVer/ultisnips'               " Snippets engine
Plug 'honza/vim-snippets'             " Snippets

" UI
Plug 'drewtempelmeyer/palenight.vim'  " Palenight colorscheme
Plug 'morhetz/gruvbox'                " Gruvbox colorscheme
Plug 'vim-airline/vim-airline'        " Status line
Plug 'vim-airline/vim-airline-themes' " Status line themes
Plug 'ryanoasis/vim-devicons'         " File icons
Plug 'Yggdroot/indentLine'            " Space indentation
Plug 'junegunn/goyo.vim'              " Distraction free writing
Plug 'junegunn/limelight.vim'         " Only highlight current section in Goyo

" Language
Plug 'sheerun/vim-polyglot'           " Defaults for languages
Plug 'davidhalter/jedi-vim'           " Python autocompletion

call plug#end()


"""
""" Built-in Settings
"""
syntax on
colorscheme gruvbox
set encoding=UTF-8
set t_Co=256
set background=dark
if has('termguicolors')
 set termguicolors
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
set conceallevel=0

" Regex Engine
"set regexpengine=1

" Timeouts
set timeoutlen=1000
set ttimeoutlen=0

" Rulers
set colorcolumn=80

" Wrapping
set wrap!

" Indentation
set shiftwidth=0
set tabstop=4
set noexpandtab
set smarttab

" Leader
let mapleader = '<Space>'

" Live substitution
if has('nvim')
  set inccommand=nosplit
endif

" Relative line numbers
set number
set relativenumber

" Status
set showmode!

" Splits
set splitbelow
set splitright

" Sessions
let g:sessions_dir = '~/vim-sessions'

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

" Remove highlight
nnoremap <silent> <Esc> :nohlsearch<CR>

" Searching
set ignorecase
set smartcase

" Write current directory
nnoremap <Leader>L :!echo %:p:h > ~/.last-dir<CR><CR>

" Source
nnoremap <Leader>S :source $MYVIMRC<CR>

" Terminal
tnoremap <Leader><Esc> <C-\><C-n>
tnoremap <C-P> i<C-P>
tnoremap <C-H> <C-\><C-n><C-W><C-H>
tnoremap <C-J> <C-\><C-n><C-W><C-J>
tnoremap <C-K> <C-\><C-n><C-W><C-K>
tnoremap <C-L> <C-\><C-n><C-W><C-L>

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
noremap <C-p> :bprev<CR>
noremap <C-n> :bnext<CR>

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

nmap <silent> M :make<CR>



"""
""" Plugin Settings
"""
" Airline
if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_z = ' %#__accent_bold#%l/%L%#__restore__# : %2v '
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'c'  : 'C',
  \ 'i'  : 'I',
  \ 'ic' : 'I',
  \ 'ix' : 'I',
  \ 'n'  : 'N',
  \ 'ni' : 'N',
  \ 'no' : 'N',
  \ 'R'  : 'R',
  \ 'Rv' : 'R',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ 't'  : 'T',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ }
let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" FZF
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <Leader>s :Ag<CR>

" Sneak
let g:sneak#label = 1

" Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Mucomplete
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['path', 'ulti', 'omni', 'keyn', 'dict', 'uspl']
let g:mucomplete#cycle_with_trigger = "<C-d>"
imap <silent> <C-n> <plug>(MUcompleteFwd)
imap <expr> <down> mucomplete#extend_fwd("\<down>")
imap <silent> <expr> <CR> mucomplete#ultisnips#expand_snippet("\<CR>")

" Ultisnips
let g:UltiSnipsExpandTrigger = "<c-e>"
let g:UltiSnipsJumpForwardTrigger = "<c-f>"
let g:UltiSnipsJumpBackwardTrigger = "<c-b>"

" Easy Align
xmap ga <Plug>(EasyAlign)

" Indents
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#454545'
let g:indentLine_leadingSpaceChar = ' '
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_concealcursor = ''
let g:indentLine_conceallevel = 0

" Ultisnips
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = '<F5>'
let g:UltiSnipsJumpForwardTrigger = '<C-L>'
let g:UltiSnipsJumpBackwardTrigger = '<C-K>'

" Netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_localrmdir='rm -r'
function! Netrw(cmd)
  if exists('b:sid') | execute "call " . b:sid . a:cmd | endif
endfunction
function! NetrwBuf()
  " Find Netrw functions here:
  " https://github.com/vim/vim/blob/master/runtime/autoload/netrw.vim
  let b:sid = matchstr(maparg('%', 'n'), '<SNR>\d\+_')  " Netrw's <SID>
  nmap <buffer> t :call Netrw("NetrwOpenFile(1)")<CR>
endfunction

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
  nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
  nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
  nnoremap <expr> 0 g0
  nnoremap <expr> $ g$
endfunction
function! s:goyo_leave()
  if g:goyo_wrap == 0 | set nowrap | endif
  if g:goyo_linebreak == 0 | set linebreak | endif
  unmap j
  unmap k
  unmap 0
  unmap $
endfunction


"""
""" Functions
"""
function! TwoSpaceIndent()
  setlocal shiftwidth=2
  setlocal tabstop=2
  setlocal softtabstop=2
  setlocal expandtab
endfunction

"""
""" Autocmd Groups
"""
" File Types
augroup FILETYPES
  autocmd FileType netrw call NetrwBuf()
  autocmd FileType defx call DefxBuf()
  autocmd FileType vim call TwoSpaceIndent()
  autocmd FileType python call TwoSpaceIndent()
  autocmd FileType html call TwoSpaceIndent()
  autocmd FileType vue call TwoSpaceIndent()
  autocmd FileType json call TwoSpaceIndent()
augroup END

" Vim Events
augroup EVENTS
  autocmd FocusGained,VimResized * :redraw!
  autocmd User GoyoEnter nested call <SID>goyo_enter()
  autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END
