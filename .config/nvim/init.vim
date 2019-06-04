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
endif

" Completion
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                " Fuzzy file finder
Plug 'tpope/vim-vinegar'               " Netrw

" Snippets
Plug 'SirVer/ultisnips'                " Snippets engine
Plug 'honza/vim-snippets'              " Snippets

" Navigation
Plug 'rhysd/clever-f.vim'              " Extend f, t, F, T
Plug 'justinmk/vim-sneak'              " Easy cursor jumping; s/S
Plug 'christoomey/vim-tmux-navigator'  " Tmux split navigation

" Text
Plug 'tomtom/tcomment_vim'             " Commenting; [visual]gc
Plug 'tpope/vim-surround'              " Text surroundings
Plug 'junegunn/vim-easy-align'         " Text alignment; [visual]ga
Plug 'dyng/ctrlsf.vim'                 " Project search and replace

" Visual
Plug 'Yggdroot/indentLine'             " Space indentation
Plug 'romainl/vim-cool'                " Unhighlight searches
Plug 'luochen1990/rainbow'             " Rainbow parenthesis

" Git
Plug 'tpope/vim-fugitive'              " Git; :Gstatus, :Gcommit, ...
Plug 'tpope/vim-rhubarb'               " Fugitive extension, adds :Gbrowse
Plug 'idanarye/vim-merginal'           " Git branches
Plug 'rhysd/git-messenger.vim'         " Show git commit under line; <Leader>gm

" Themes
Plug 'chriskempson/base16-vim'         " Base16 theme architecture

" UI
Plug 'vim-airline/vim-airline'

" Functionality
Plug 'tpope/vim-repeat'                " Repeat for supported plugins
Plug 'tpope/vim-sleuth'                " Indentation detection
Plug 'tpope/vim-eunuch'                " Unix shell commands
Plug 'tpope/vim-obsession'             " Automatic sessions
Plug 'wellle/targets.vim'              " More text objects
Plug 'chrisbra/Recover.vim'            " Easier recovery
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Syntax
Plug 'sheerun/vim-polyglot'            " Defaults for languages


call plug#end()


"""
""" Built-in Settings
"""
syntax on
colorscheme base16-default-dark
set encoding=UTF-8
set t_Co=256
set background=dark
set hidden
if exists('+termguicolors')
  " let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  " let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Persistent Undo
if has('persistent_undo')
  let &undodir = expand('$HOME/.vim/undo')
  call system('mkdir -p ' . &undodir)
  se undofile
endif

" Cursor
set scrolloff=2
set sidescrolloff=1
set nocursorline
set updatetime=300

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
set nowrap

" Indentation
set shiftwidth=4
set tabstop=4
set expandtab
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
set noshowmode

" Splits
set splitbelow
set splitright

" Sessions
let g:sessions_dir = vimpath + '/sessions'

" Messages
set shortmess+=c

" Completion
set completeopt+=menuone,noinsert
set completeopt-=preview

" Searching
set ignorecase
set smartcase



"""
""" Built-in Mappings
"""
" Semi-colon as colon
nnoremap ; :

" Write current directory
nnoremap <Leader>L :!echo %:p:h > ~/.previous-dir<CR><CR>

" Visual
vnoremap // y/<C-R>"<CR>
xnoremap R y:%s/<C-r>"//g<Left><Left>

" Terminal
tnoremap <Leader><Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-W><C-H>
tnoremap <C-j> <C-\><C-n><C-W><C-J>
tnoremap <C-k> <C-\><C-n><C-W><C-K>
tnoremap <C-l> <C-\><C-n><C-W><C-L>

" Cut and Paste
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>P "+P

" Text
nnoremap c* *Ncgn

" Save
noremap <Space><Esc> :w<CR>

" Buffers
noremap <Leader>q :Bdelete<CR>
noremap <Tab> <c-^>

" Tabs
noremap <silent> <C-p> :tabprev<CR>
noremap <silent> <C-n> :tabnext<CR>


" Line navigation
nnoremap <S-h> _
nnoremap <S-l> g_
vnoremap <S-h> _
vnoremap <S-l> g_

nnoremap <CR> i<CR><Esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Split navigation
map <Leader> <Nop>
nnoremap <silent> <BS> :TmuxNavigateLeft<CR>

" Split resizing
nnoremap <C-w><C-y> :vertical resize -5<CR>
nnoremap <C-w><C-u> :resize -5<CR>
nnoremap <C-w><C-i> :resize +5<CR>
nnoremap <C-w><C-o> :vertical resize +5<CR>

" Stop accidents
nnoremap <S-k> <Nop>
inoremap <C-h> <Nop>
inoremap <C-j> <Nop>
inoremap <C-k> <Nop>
inoremap <C-l> <Nop>

"""
""" Plugin Settings
"""
" FZF
let rg_args = {'options': '--delimiter : --nth 4..'}
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading -g "!node_modules" --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview(rg_args, 'up:60%')
  \           : fzf#vim#with_preview(rg_args, 'right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <Leader>s :Ag<CR>

" fugitive
command! Gtdiff tabedit %|Gdiff
command! Gtstatus Gtabedit :

" netrw
let g:netrw_errorlvl = 2
let g:netrw_liststyle = 1
let g:netrw_sizestyle = 'H'
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

function! NetrwBuffer()
  noremap <buffer> t :norm %<CR>
  nunmap <buffer> <space>s
endfunction

" coc.nvim
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gs <Plug>(coc-action-workspaceSymbols)

let g:coc_global_extensions = [
  \  'coc-pairs', 'coc-lists', 'coc-highlight', 'coc-yank',
  \  'coc-tsserver', 'coc-json', 'coc-css', 'coc-vetur', 'coc-html',
  \  'coc-emmet', 'coc-snippets', 'coc-ultisnips', 'coc-emoji'
  \]

" NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>

" Sneak
let g:sneak#label = 1
let g:sneak#map_netrw = 0

" Ultisnips
let g:UltiSnipsJumpForwardTrigger = "<c-f>"
let g:UltiSnipsJumpBackwardTrigger = "<c-b>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" Easy Align
xmap ga <Plug>(EasyAlign)

" Indents
let g:indentLine_char = ''
let g:indentLine_leadingSpaceChar = ' '

" Highlightedyank
let g:highlightedyank_highlight_duration = 250

" Auto pairs
let g:AutoPairsMapCR = 0

" Vim-vue
let g:vue_disable_pre_processors = 1

" Rainbow parenthesis
let g:rainbow_active = 1

" vim-obsession
function! AutoloadSession()
  if !argc() && filereadable('Session.vim')
    source Session.vim
    Obsess! Session.vim
  endif
endfunction

" Markdown preview
let g:mkdp_auto_close = 0



"""
""" Autocmd Groups
"""
" File Types
augroup FILETYPES
  autocmd FileType netrw call NetrwBuffer()
  autocmd FileType vue syntax sync fromstart
  autocmd FileType vue,javascript autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd FileType markdown let b:indentLine_enabled = 0
augroup END

" Vim Events
augroup EVENTS
  autocmd FocusGained,VimResized * :redraw!
  autocmd VimEnter * nested call AutoloadSession()
augroup END
