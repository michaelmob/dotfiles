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

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                " Fuzzy finder
Plug 'tpope/vim-vinegar'               " Netrw

" Snippets
Plug 'SirVer/ultisnips'                " Snippets engine
Plug 'honza/vim-snippets'              " Snippets

" Navigation
Plug 'rhysd/clever-f.vim'              " Extend f, t, F, T
Plug 'justinmk/vim-sneak'              " Easy cursor jumping; s/S
Plug 'christoomey/vim-tmux-navigator'  " Tmux split navigation

" Typography
Plug 'tomtom/tcomment_vim'             " Commenting; [visual]gc
Plug 'tpope/vim-surround'              " Text surroundings
Plug 'junegunn/vim-easy-align'         " Text alignment; [visual]ga
Plug 'dyng/ctrlsf.vim'                 " Project search and replace
Plug 'wellle/targets.vim'              " More text objects
Plug 'andymass/vim-matchup'            " Improved %
Plug 'SidOfc/mkdx'                     " Markdown enhancements
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Visual
Plug 'Yggdroot/indentLine'             " Space indentation
Plug 'romainl/vim-cool'                " Unhighlight searches

" Git
Plug 'tpope/vim-fugitive'              " Git; :Gstatus, :Gcommit, ...
Plug 'tpope/vim-rhubarb'               " GitHub extension for fugitive, :Gbrowse
Plug 'idanarye/vim-merginal'           " Git branches
Plug 'rhysd/git-messenger.vim'         " Show git commit under line; <Leader>gm

" Themes
Plug 'chriskempson/base16-vim'         " Base16 theme architecture

" Functionality
Plug 'tpope/vim-repeat'                " Repeat for supported plugins
Plug 'tpope/vim-sleuth'                " Indentation detection
Plug 'tpope/vim-eunuch'                " Unix shell commands
Plug 'tpope/vim-obsession'             " Automatic sessions
Plug 'tpope/vim-dispatch'              " Async make
Plug 'chrisbra/Recover.vim'            " Easier recovery
Plug 'junegunn/vim-peekaboo'

" Syntax
Plug 'sheerun/vim-polyglot'            " Defaults for languages

" Only for Neovim
if has('nvim')
  Plug 'adenling/vim-dispatch-neovim'  " Depends on 'tpope/vim-dispatch'

" Only for Vim
else
  Plug 'tpope/vim-sensible'            " Sensible defaults
  Plug 'markonm/traces.vim'            " Live substitute for Vim 8
endif


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
  set termguicolors
endif

" Persistent Undo
if has('persistent_undo')
  let &undodir = expand(vimpath . '/undo')
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
""" Custom Mappings
"""

"nnoremap <Leader>r :%y+\|silent !~/.scripts/kwin_load_script<CR>


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

" Formatting
noremap gf gq}

" Save
noremap <Space><Esc> :w<CR>

" Buffers
noremap <Leader>q :bdelete<CR>

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

" Counterpart of 'J'
nnoremap K vg_"txO<Esc>"tp==j:s/\s\+$//e<CR>$

" Stop accidents
inoremap <C-h> <Nop>
inoremap <C-j> <Nop>
inoremap <C-k> <Nop>
inoremap <C-l> <Nop>

" {action} word
nnoremap vw viw

"""
""" Plugin Settings
"""
" FZF
let g:fzf_action = {
  \  'ctrl-s': 'split',
  \  'ctrl-v': 'vsplit'
  \}

let rg_args = {'options': '--delimiter : --nth 4..'}
let rg_flags = '--column --line-number --no-heading --color=always --smart-case'
let rg_ignore = '-g "!node_modules" -g "!tags" -g "!package-lock.json"'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg ' . rg_flags . ' ' . rg_ignore . ' ' . shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(rg_args))
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <Leader>F :Files<CR>
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <Leader>s :Rg<CR>

" coc.nvim
inoremap <expr> <CR> pumvisible() ? "\<c-y>" : "\<c-g>u\<CR>"
inoremap <expr> <CR> pumvisible() ? "\<c-y>" : "\<c-g>u\<CR>"

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

" git/fugitive
noremap <leader>gs :Gstatus<CR>
noremap <leader>gt :Gtstatus<CR>
noremap <leader>gc :Gcommit -v<CR>

let g:coc_global_extensions = [
  \  'coc-pairs', 'coc-highlight', 'coc-yank', 'coc-tsserver', 'coc-eslint',
  \  'coc-json', 'coc-css', 'coc-html', 'coc-emmet', 'coc-snippets',
  \  'coc-ultisnips', 'coc-emoji', 'coc-word'
  \]

" mkdx
vmap <leader>ml <Plug>(mkdx-wrap-link-v)

" CtrlSF
nnoremap <leader>a :CtrlSF<space>

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

" Match up
let g:loaded_matchit = 1



"""
""" Autocmd Groups
"""
" File Types
augroup FILETYPES
  autocmd FileType netrw call NetrwBuffer()
  autocmd FileType vue syntax sync fromstart
  autocmd FileType vue,javascript autocmd BufWritePre <buffer> %s/\s\+$//e
  autocmd FileType markdown
    \ let b:indentLine_enabled = 0 |
    \ setlocal conceallevel=0

  autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" Vim Events
augroup EVENTS
  autocmd FocusGained,VimResized * :redraw!
  autocmd VimEnter * nested call AutoloadSession()
  autocmd BufWritePre <buffer> %s/\s\+$//e
augroup END
