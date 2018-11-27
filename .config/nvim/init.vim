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
call plug#begin('~/.local/share/nvim/plugged')

" Neovim-specific or Vim-specific
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Completion
else
  Plug 'Shougo/deoplete.nvim'     " Completion
  Plug 'roxma/nvim-yarp'          " Remote plugin support for Vim 8
  Plug 'roxma/vim-hug-neovim-rpc' " Neovim rpc client compatibility for Vim 8
endif

" Functionality
Plug 'Shougo/denite.nvim'             " Helm for vim
Plug 'Shougo/echodoc.vim'             " Docs in echo area
Plug 'Shougo/neosnippet.vim'          " Snippet engine
Plug 'Shougo/neosnippet-snippets'     " Snippets
Plug 'zchee/deoplete-jedi'            " Python completion for deoplete
Plug 'tpope/vim-surround'             " Surround text; [visual]S <p>
Plug 'tpope/vim-vinegar'              " Make netrw usable
Plug 'tpope/vim-commentary'           " Commenting; [visual]gc
Plug 'tpope/vim-fugitive'             " Git; :Gstatus, :Gcommit, ...
Plug 'tpope/vim-repeat'               " Repeat for supported plugins
Plug 'tpope/vim-sleuth'               " Indentation detection
Plug 'mhinz/vim-startify'             " Vim start screen
Plug 'sheerun/vim-polyglot'           " Defaults for languages
Plug 'junegunn/vim-easy-align'        " Text alignment; [visual]ga
Plug 'justinmk/vim-sneak'             " Easy cursor jumping; s/S
Plug 'christoomey/vim-tmux-navigator' " Tmux split navigation
Plug 'moll/vim-bbye'                  " Close buffer; :Bdelete
Plug 'majutsushi/tagbar'              " Class outline viewer

" UI
Plug 'morhetz/gruvbox'                " Gruvbox colorscheme
Plug 'vim-airline/vim-airline'        " Status line
Plug 'vim-airline/vim-airline-themes' " Status line themes
Plug 'ryanoasis/vim-devicons'         " File icons
Plug 'Yggdroot/indentLine'            " Space indentation
Plug 'junegunn/goyo.vim'              " Distraction free writing

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
" set mouse=a

" Cursor
set scrolloff=2

" List
set list
set listchars=tab:\ ,trail:\ ,precedes:^,extends:$,eol:¬

" Commands
set showcmd

" Speed
set regexpengine=1

" Timeouts
set timeoutlen=1000
set ttimeoutlen=0

" Rulers
set colorcolumn=80

" Wrapping
set wrap!

" Indentation
set shiftwidth=2
set tabstop=4
set softtabstop=4
set smarttab
set expandtab

" Relative line numbers
set number
set relativenumber

" Status
"set cmdheight=2
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
" Commands
nmap ; :

" Indentation
nnoremap <Tab> a<Tab><Esc>
nnoremap <S-Tab> i<Tab><Esc>
vnoremap <Tab> >><Esc>'[V']
vnoremap <S-Tab> <<<Esc>'[V']

" New lines
nnoremap <Enter> i<Enter><Esc>

" Remove highlight
nnoremap <silent> <Esc> :nohlsearch<CR>

" Write current directory
nnoremap <leader>L :!echo %:p:h > ~/.last-dir<CR><CR>

" Source
nnoremap <leader>S :source $MYVIMRC<CR>

" Terminal
tnoremap <leader><Esc> <C-\><C-n>
tnoremap <C-P> i<C-P>
tnoremap <C-H> <C-\><C-n><C-W><C-H>
tnoremap <C-J> <C-\><C-n><C-W><C-J>
tnoremap <C-K> <C-\><C-n><C-W><C-K>
tnoremap <C-L> <C-\><C-n><C-W><C-L>

" Cut and Paste
noremap <Space>y "+y
noremap <Space>p "+p
noremap <Space>P "+P

" Save
noremap <Space><Esc> :w<CR>
noremap <C-s> :w<CR>

" Line navigation
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Split navigation
map <Space> <Nop>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Buffer navigation
noremap <Space>j :bprev<CR>
noremap <Space>k :bnext<CR>
noremap <Space>q :Bdelete<CR>

" Tab navigation
noremap <Space>h :tabp<CR>
noremap <Space>l :tabn<CR>

" Visual 
vnoremap - g_


"""
""" Plugin Settings
"""
" Airline
let g:airline_powerline_fonts = 1

" Netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" Sneak
let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Denite
noremap <Space>b :Denite buffer<CR>
noremap <Space>g :Denite grep<CR>
noremap <Space>f :Denite buffer file<CR>
noremap <Space>m :Denite mark<CR>
noremap <Space>t :Denite tag<CR>
noremap <Space>r :Denite register<CR>
noremap <Space>d :Denite dictionary<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><C-g> deoplete#undo_completion()
inoremap <expr><C-n> deoplete#manual_complete()
imap <expr><silent><CR> pumvisible() ? deoplete#mappings#close_popup() .
  \ '<Plug>(neosnippet_jump_or_expand)' : '<CR>'
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? 
  \ '<Plug>(neosnippet_expand_or_jump)' : '<TAB>'

" Echodoc
let g:echodoc#enable_at_startup = 1

" Easy Align
xmap ga <Plug>(EasyAlign)

" Indents
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#454545'
let g:indentLine_leadingSpaceChar = ' '
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_concealcursor = ''

" Ultisnips
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = '<F5>'
let g:UltiSnipsJumpForwardTrigger = '<C-L>'
let g:UltiSnipsJumpBackwardTrigger = '<C-K>'

" Netrw
let g:netrw_localrmdir='rm -r'
function! NetrwBuf()
  "let b:netrw_sid = matchstr(maparg('%', 'n'), '<SNR>\d\+_')  " Get <SID> of netrw
  "nmap d :call <C-r>=b:netrw_sid<CR>NetrwMakeDir('')<CR>
  nmap <buffer> <silent> <nowait> t %
endfunction

" Tagbar
nnoremap <Space>e :TagbarToggle<CR>


"""
""" Autocmd Groups
"""
" File Types
augroup FILETYPES
  autocmd FileType netrw call NetrwBuf()
  autocmd FileType c setlocal shiftwidth=4
  autocmd FileType cpp setlocal shiftwidth=4
  autocmd FileType py setlocal shiftwidth=4
  autocmd FileType go setlocal shiftwidth=4
augroup END

" Vim Events
augroup EVENTS
  autocmd FocusGained,VimResized * :redraw!
augroup END
