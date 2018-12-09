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
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }  " Completion
  Plug 'Shougo/defx.nvim',     { 'do': ':UpdateRemotePlugins' }  " File manager
else
  Plug 'Shougo/deoplete.nvim'     " Completion
  Plug 'Shougo/defx.nvim'         " File manager
  Plug 'roxma/nvim-yarp'          " Remote plugin support for Vim 8
  Plug 'roxma/vim-hug-neovim-rpc' " Neovim rpc client compatibility for Vim 8
  Plug 'tpope/vim-sensible'       " Sensible defaults
  Plug 'markonm/traces.vim'       " Live substitute for vim
endif

" Functionality
Plug 'Shougo/denite.nvim'             " Helm for vim
Plug 'Shougo/echodoc.vim'             " Docs in echo area
Plug 'Shougo/neosnippet.vim'          " Snippet engine
Plug 'Shougo/neosnippet-snippets'     " Snippets
Plug 'tpope/vim-surround'             " Surround text; [visual]S <p>
Plug 'tpope/vim-commentary'           " Commenting; [visual]gc
Plug 'tpope/vim-fugitive'             " Git; :Gstatus, :Gcommit, ...
Plug 'tpope/vim-repeat'               " Repeat for supported plugins
Plug 'tpope/vim-sleuth'               " Indentation detection
Plug 'mhinz/vim-startify'             " Vim start screen
Plug 'junegunn/vim-easy-align'        " Text alignment; [visual]ga
Plug 'justinmk/vim-sneak'             " Easy cursor jumping; s/S
Plug 'tommcdo/vim-exchange'           " Swap selections of code
Plug 'machakann/vim-highlightedyank'  " Briefly highlight yanked text
Plug 'christoomey/vim-tmux-navigator' " Tmux split navigation
Plug 'moll/vim-bbye'                  " Close buffer; :Bdelete
Plug 'majutsushi/tagbar'              " Class outline viewer

" UI
Plug 'morhetz/gruvbox'                " Gruvbox colorscheme
Plug 'vim-airline/vim-airline'        " Status line
Plug 'vim-airline/vim-airline-themes' " Status line themes
Plug 'ryanoasis/vim-devicons'         " File icons
Plug 'kristijanhusak/defx-icons'      " File icons for Defx
Plug 'Yggdroot/indentLine'            " Space indentation
Plug 'junegunn/goyo.vim'              " Distraction free writing
Plug 'junegunn/limelight.vim'         " Only highlight current section in Goyo

" Language
Plug 'sheerun/vim-polyglot'           " Defaults for languages
Plug 'posva/vim-vue'                  " Vue syntax highlighting
Plug 'zchee/deoplete-jedi'            " Python completion for deoplete
Plug 'zchee/deoplete-clang'           " Clang completions

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
set cursorline
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"

" List
set list
set listchars=tab:\ ,trail:\ ,precedes:^,extends:$,eol:¬

" Commands
set showcmd

" Speed
" set regexpengine=1

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
" Indentation
nnoremap <Tab> a<Tab><Esc>
nnoremap <S-Tab> i<Tab><Esc>
vnoremap <Tab> >><Esc>'[V']
vnoremap <S-Tab> <<<Esc>'[V']

" New lines
nnoremap <Enter> i<Enter><Esc>

" Remove highlight
nnoremap <silent> <Esc> :nohlsearch<CR>

" Searching
set ignorecase
set smartcase

" Write current directory
nnoremap <Space>L :!echo %:p:h > ~/.last-dir<CR><CR>

" Source
nnoremap <Space>S :source $MYVIMRC<CR>

" Terminal
tnoremap <Space><Esc> <C-\><C-n>
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

nmap <silent> M :make<CR>



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
noremap <silent> ' :Denite buffer<CR>
noremap <silent> <Space>b :Denite buffer<CR>
noremap <silent> <Space>g :Denite grep<CR>
noremap <silent> <Space>f :Denite buffer file<CR>
noremap <silent> <Space>m :Denite mark<CR>
noremap <silent> <Space>t :Denite tag<CR>
noremap <silent> <Space>r :Denite register<CR>
noremap <silent> <Space>d :Denite dictionary<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><C-g> deoplete#undo_completion()
inoremap <expr><C-n> deoplete#manual_complete()
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <expr><silent><CR> pumvisible() ? deoplete#mappings#close_popup() .
  \ '<Plug>(neosnippet_jump_or_expand)' : '<CR>'
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? 
  \ '<Plug>(neosnippet_expand_or_jump)' : '<TAB>'

" Defx
let g:defx_icons_enable_syntax_highlight = 0
nnoremap <silent> - :Defx `expand('%:p:h')` -search=`expand('%:p')` -columns=icons:filename:type<CR>
function! DefxBuf()
  " Goto
  nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
  " Vinegar Navigation
  nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
  nnoremap <silent><buffer><expr> - defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> gh defx#do_action('change_vim_cwd')
  " Selection
  nnoremap <silent><buffer><expr> v defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> V defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> zh defx#do_action('toggle_ignored_files')
  " Manipulation
  nnoremap <silent><buffer><expr> yy defx#do_action('copy')
  nnoremap <silent><buffer><expr> pp defx#do_action('paste')
  nnoremap <silent><buffer><expr> A defx#do_action('rename')
  nnoremap <silent><buffer><expr> dD defx#do_action('remove')
  nnoremap <silent><buffer><expr> DD defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> X defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> Y defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> i defx#do_action('drop')
  nnoremap <silent><buffer><expr> t defx#do_action('new_file')
  nnoremap <silent><buffer><expr> o defx#do_action('new_directory')
endfunction

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
"
" Ultisnips
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = '<F5>'
let g:UltiSnipsJumpForwardTrigger = '<C-L>'
let g:UltiSnipsJumpBackwardTrigger = '<C-K>'

" Tagbar
nnoremap <Space>T :TagbarToggle<CR>

" Highlightedyank
let g:highlightedyank_highlight_duration = 250

" Goyo
nmap <silent> <Space>G :Goyo<CR>
let g:goyo_linenr = 1
function! s:goyo_enter()
  let g:goyo_wrap = &wrap  " Store previous wrap setting.
  set wrap
  Limelight
endfunction
function! s:goyo_leave()
  if g:goyo_wrap == 0 | set nowrap | endif  " Restore previous wrap setting.
  Limelight!
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
