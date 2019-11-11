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

Plug 'tpope/vim-rsi'  " Readline
Plug 'tpope/vim-eunuch'  " Unix helper commands
Plug 'tpope/vim-sleuth'  " Detect and set buffer options
Plug 'tpope/vim-repeat'  " Repeating
Plug 'tpope/vim-apathy'  " Paths
Plug 'tpope/vim-vinegar'  " Netrw Enhancements
Plug 'tpope/vim-fugitive'  " Git wrapper
Plug 'tpope/vim-surround'  " Text surroundings
Plug 'tpope/vim-dispatch'  " Async dispatching
Plug 'tpope/vim-obsession'  " Sessions

Plug 'honza/vim-snippets'  " Snippets source
Plug 'wellle/targets.vim'  " Enhanced text objects
Plug 'junegunn/vim-slash'  " Enhanced buffer search
Plug 'airblade/vim-rooter'  " Set cwd to projects root dir
Plug 'Yggdroot/indentLine'  " Space-indentation levels
Plug 'tomtom/tcomment_vim'  " Comments
Plug 'jiangmiao/auto-pairs'  " Automatic bracket, paren, quotes pairing
Plug 'chrisbra/Recover.vim'  " Swap-file Compare
Plug 'sheerun/vim-polyglot'  " Syntax language pack
Plug 'chriskempson/base16-vim'  " Base16 colorschemes
Plug 'junegunn/vim-easy-align'  " Text alignment
Plug 'AndrewRadev/splitjoin.vim'  " Single-line <--> Multi-line
Plug 'christoomey/vim-tmux-navigator'  " Window navigation
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'  " Fzf wrapper

Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}  " Autocomplete


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
" indentLine
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" coc.nvim
let g:coc_global_extensions = [
  \   'coc-snippets', 'coc-word', 'coc-emoji', 'coc-json',
  \   'coc-tsserver', 'coc-vetur'
  \ ]


let g:coc_user_config = {
  \ }

" markdown-preview
let g:mkdp_auto_close = 0

" indentLine
let g:indentLine_fileTypeExclude = ['text', 'sh', 'markdown']

" vim-vue (vim-polyglot)
let g:vue_pre_processors = []

" autopairs
let g:AutoPairsMultilineClose = 0

" fzf
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case ' . shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Dirs call fzf#run(fzf#wrap({'source': 'find * -type d 2>/dev/null'}))
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

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

" ----------------
" }}}



" Vim Settings {{{
" ----------------
" Colors
set termguicolors
colorscheme base16-monokai
syntax enable

" Text
set nowrap

" Indentation
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

" Netrw / :help netrw-P19
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro rnu'
" ----------------
" }}}



" Commands {{{
" ----------------
" Fugitive
command! Gdifftab tabedit %|Gvdiffsplit

" fzf
command! -bang -nargs=* GGrep call fzf#vim#grep(
  \ 'git grep --line-number '.shellescape(<q-args>), 0,
  \ { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
" ----------------
" }}}



" Keybindings {{{
" ----------------
let mapleader = "\<Space>"

" Save
nmap <Space><Esc> :w<CR>

" Undo/Redo
inoremap <expr> <silent> <C-u> '<C-o>u'
inoremap <expr> <silent> <C-r> '<C-o><C-r>'

" Tab control
nmap <silent> tc :tabclose<CR>
nmap <silent> tn :tabnext<CR>
nmap <silent> tp :tabprev<CR>

" Yank/Pasting
map <Leader>p "+p
map <Leader>P "+P
map <Leader>y "+y

" Fuzzy Finders
nmap <silent> <Leader>c :Colors<CR>
nmap <silent> <Leader>f :Files<CR>
nmap <silent> <Leader>f :GFiles --exclude-standard --others --cached<CR>
nmap <silent> <Leader>d :Dirs<CR>
nmap <silent> <Leader><Leader>f :Files<CR>
nmap <silent> <Leader>b :Buffers<CR>
nmap <silent> <Leader>/ :Rg<CR>
nmap <silent> <Leader><Leader>/ :GGrep<CR>

" Popup Menu (pum)
inoremap <expr> <silent> <CR> pumvisible() ? '<C-y>' : '<C-g>u<CR>'

" Search
nmap <plug>(slash-after) zz

" Line Navigation
map <S-h> ^
map <S-l> g_

" Counterpart to <S-j>
nmap <S-k> DO<Esc>p==

" Fugitive
nmap <Leader>gs :tab Gstatus<CR>
nmap <Leader>gd :Gdifftab<CR>
nmap <Leader>gc :Gcommit -v<CR>

" Surround
vmap <CR> S<C-J>jVj=$

" Easy align
xmap ga <Plug>(EasyAlign)
nmap <Leader>at vipga*\|  " Align Table

" Netrw
function! NetrwMappings()
  silent! unmap <buffer> <C-l>
endfunction

" ----------------
" }}}



" Filetypes {{{
" ----------------
augroup FILETYPES
  autocmd!
  autocmd FileType javascript let b:dispatch = 'npm test -- %'
  autocmd FileType vue syntax sync fromstart
  autocmd FileType markdown setlocal textwidth=80

  "autocmd FileType netrw unmap <buffer> <C-L> | map <buffer> <C-R>
  autocmd FileType NetrwMessage,help,qf,vim-plug nmap <silent><buffer> <Esc> :q<CR>
  autocmd filetype netrw call NetrwMappings()
augroup END
" ----------------
" }}}



" Events {{{
" ----------------
augroup EVENTS

  autocmd BufWritePre <buffer> %s/\s\+$//e

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
