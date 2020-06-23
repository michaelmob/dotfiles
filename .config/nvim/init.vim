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
Plug 'alvan/vim-closetag'             " Automatic HTML tag closing
Plug 'brooth/far.vim'                 " Find and replace :Far
Plug 'christoomey/vim-tmux-navigator' " Window navigation
Plug 'unblevable/quick-scope'         " Visual f/t
Plug 'easymotion/vim-easymotion'      " Faster motions
Plug 'editorconfig/editorconfig-vim'  " Consistent code styles
Plug 'haishanh/night-owl.vim'         " Night owl colorscheme
Plug 'honza/vim-snippets'             " Snippets source
Plug 'janko/vim-test'                 " Test runners
Plug 'jiangmiao/auto-pairs'           " Automatic bracket/paren/quote pairs
Plug 'justinmk/vim-dirvish'           " File browser
Plug 'junegunn/vim-easy-align'        " Text alignment
Plug 'junegunn/vim-peekaboo'          " Register/macro viewer
Plug 'junegunn/goyo.vim'              " Distraction-free writing
Plug 'junegunn/limelight.vim'         " Focused writing
Plug 'lifepillar/vim-cheat40'         " Keybindings popup
Plug 'ludovicchabant/vim-gutentags'   " Automatic ctags
Plug 'kkoomen/vim-doge'               " Documentation generator
Plug 'machakann/vim-sandwich'         " Surroundings
Plug 'markstory/vim-zoomwin'          " Window-zoom
Plug 'mbbill/undotree'                " Undo tree
Plug 'lukelbd/vim-tabline'            " Tabline enhancements
Plug 'reedes/vim-litecorrect'         " Autocorrection
Plug 'reedes/vim-pencil'              " Writing mode
Plug 'romainl/vim-cool'               " Search highlighting
Plug 'sheerun/vim-polyglot'           " Syntax language pack
Plug 'skywind3000/asyncrun.vim'       " Dispatching
Plug 'svermeulen/vim-yoink'           " Yank-history cycling
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

" Completions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy Finders
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Text Editing
Plug 'iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#install()}}
call plug#end()
" ----------------
" }}}


" Plugin Settings {{{
" ----------------
" vim-sandwich
runtime macros/sandwich/keymap/surround.vim

" vim-easy-align
let g:easy_align_delimiters = {
\  '/': { 'pattern': '/' }, '\': { 'pattern': '\\' },
\  ';': { 'pattern': ';' }, "'": { 'pattern': "'" },
\  '?': { 'pattern': '?' }, '+': { 'pattern': '+' },
\  '~': { 'pattern': '~' }, '`': { 'pattern': '`' },
\  '<': { 'pattern': '<' }, '>': { 'pattern': '>' },
\  '[': { 'pattern': '[' }, ']': { 'pattern': ']' },
\  '(': { 'pattern': '(' }, ')': { 'pattern': ')' }
\}

" vim-peekaboo
let g:peekaboo_window = 'vert bo 40new'

" markdown-preview.nvim
let g:mkdp_auto_close = 1
let g:mkdp_echo_preview_url = 1
let g:mkdp_open_to_the_world = 1
let g:mkdp_port = 50000

" indentLine
let g:indentLine_fileTypeExclude = [
\  'help', 'terminal', 'markdown', 'vim', 'vim-plug'
\]
let g:indentLine_char = '▏'
let g:indentLine_first_char = g:indentLine_char
let g:indentLine_showFirstIndentLevel = 1

" vim-dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'

" vim-doge
let g:doge_mapping = 'gcd'
let g:doge_mapping_comment_jump_forward = '<c-j>'
let g:doge_mapping_comment_jump_backward = '<c-k>'
let g:doge_filetype_aliases = { 'javascript': ['vue'] }

" vim-closetag
let g:closetag_filetypes = 'html,xhtml,phtml,vue'

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

" vim-cheat40
let g:cheat40_use_default = 0
let g:cheat40_foldlevel = 0

" vim-easymotion
let g:EasyMotion_do_mapping = 0

" vim-quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" vim-yoink
let g:yoinkSavePersistently = 1
let g:EasyClipAutoFormat = 1

" vim-autopairs
let g:AutoPairsMultilineClose = 0
" ----------------
" }}}


" Vim Settings {{{
" ----------------
syntax enable
colorscheme night-owl
filetype plugin indent on

set nowrap
set inccommand=nosplit
set updatetime=300
set splitbelow
set splitright
set termguicolors
set expandtab
set tabstop=4
set shiftwidth=2
set wildoptions=pum
set wildignore+=*/vendor/*,*/node_modules/*
set pumheight=15
set pumblend=5
"set number
"set relativenumber
set colorcolumn=81
set scrolloff=2
set sidescrolloff=2
set undofile
set undodir=$sharedir/undo
set timeoutlen=500
set fsync
" ----------------
" }}}


" Functions {{{
" ----------------
function! AutoloadSession()
  if !argc() && filereadable('Session.vim')
    source Session.vim
    Obsess! Session.vim
  endif
endfunction
" ----------------
" }}}


" Commands {{{
" ----------------
command! -nargs=1 Swap :normal! mA<c-w><args>mB'A<c-w>p'B<c-w>p

command! -nargs=1 Tabs :set ts=<args> sts=<args> sw=<args> noexpandtab
command! -nargs=1 Spaces :set ts=<args> sts=<args> sw=<args> expandtab

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
imap jk <Esc>

" Windows
nmap <leader>w  <c-w>
nmap <leader>ws <c-w>s-
nmap <leader>wv <c-w>v-
nmap <silent> <leader>wc :enew\|bd#<cr>

" Swap window buffers
nmap <silent> <c-w>H :Swap h<cr>
nmap <silent> <c-w>J :Swap j<cr>
nmap <silent> <c-w>K :Swap k<cr>
nmap <silent> <c-w>L :Swap l<cr>

" Files
nmap <leader>j :w<CR>

" Text
nnoremap vw viw
nnoremap cw ciw

" Indentation
xnoremap > >gv
xnoremap < <gv

" Wrap visual
xmap v LS

" Line Navigation
noremap H ^
noremap L g_

" Tests
nmap <silent> <leader>tn :TestNearest<cr>
nmap <silent> <leader>tf :TestFile<cr>
nmap <silent> <leader>ts :TestSuite<cr>
nmap <silent> <leader>tl :TestLast<cr>
nmap <silent> <leader>tv :TestVisit<cr>

" Surround
nmap S viwS
map Sc Sfconsole.log<cr>
map Sd Sfconsole.debug<cr>
map Sj SfJSON.stringify<cr>

" Clipboard
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
map <leader>p "+p
map <leader>P "+P
map <leader>y "+y

" Finders
nmap <leader><leader> :Tags<cr>
nmap <leader>f :Files<cr>
nmap <leader>d :Dirs<cr>
nmap <leader>s :Rg<cr>
nmap <leader>/ :Rg<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>h :History<cr>
nmap <leader>tc :Colors<cr>

" LSP
" nnoremap <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap gh    <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap gI    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap gk    <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap gD    <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" Completion
"inoremap <expr> <cr> pumvisible() && !(empty(v:completed_item)) ? '<c-y>' : '<cr>'

" Quickfix
nmap <silent> <leader>] :cnext<cr>
nmap <silent> <leader>[ :cprevious<cr>

" Git
nmap <leader>gc :Commits<cr>
nmap <leader>gg :Gstatus<cr>

" Formating
nmap ga <plug>(EasyAlign)
xmap ga <plug>(EasyAlign)

" Terminal
tmap <c-o> <c-\><c-n>
tmap <c-u> <c-\><c-n><c-u>

" splitjoin
nmap <leader>J :SplitjoinJoin<cr>
nmap <leader>K :SplitjoinSplit<cr>

" EasyMotion
map s <plug>(easymotion-overwin-f2)

" vim-zoomwin
nmap <silent> <C-w>m :ZoomToggle<cr>
" ----------------
" }}}


" Filetypes {{{
" ----------------
augroup FILETYPES
  " autocmd! Filetype    *    setlocal omnifunc=v:lua.vim.lsp.omnifunc
  autocmd! FileType   vue   syntax sync fromstart
  autocmd! FileType help,qf nmap <buffer> <esc> :q<cr>
augroup END
" ----------------
" }}}


" Events {{{
" ----------------
augroup EVENTS
  autocmd! VimEnter        *     nested call AutoloadSession()
  autocmd! BufWritePre  <buffer> %s/\s\+$//e
  autocmd! BufWritePost $MYVIMRC source $MYVIMRC
  autocmd! BufEnter   *.txt,*.md setlocal nofen tw=80 "fo=aw2tq
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END
" ----------------
" }}}
