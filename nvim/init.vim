" Plugins {{{

" set the runtime path to include Vundle and initialize
call plug#begin('~/.config/nvim/bundle')

" Collection of common configurations for the Nvim (>= 0.5) built-in LSP client. Provides an easy to use API to register and configure your language servers for Neovim's LSP client
Plug 'neovim/nvim-lspconfig'
" A very lightweight companion plugin for nvim-lspconfig. It adds the missing :LspInstall <language> command to conveniently install language servers to `:echo stdpath("data")` (/home/sshimanski/.local/share/nvim)
" See https://ka.codes/posts/nvim-lspinstall#nvim-lspinstall
Plug 'kabouzeid/nvim-lspinstall'
" exchange
Plug 'tommcdo/vim-exchange'
" file explorer
Plug 'preservim/nerdtree'
" docs
Plug 'rhysd/vim-grammarous'
" Plug 'lervag/vimtex'

Plug 'plasticboy/vim-markdown'
Plug 'chriskempson/base16-vim'
Plug 'kshenoy/vim-signature'

" tagbar
" snippets stuff
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" tests
Plug 'janko-m/vim-test'
" golang for vim
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" keyword completion system by maintaining a cache of keywords in the current buffer 
" status line
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" auto pairs - [], {}, '' etc.
Plug 'jiangmiao/auto-pairs'
" colorful brackets
Plug 'frazrepo/vim-rainbow'
" GIT plugin
Plug 'tpope/vim-fugitive'
" Rust file detection, syntax highlighting, formatting, Syntastic integration, and more
" Plug 'rust-lang/rust.vim', { 'for': 'rust' } " install universal-ctags for denite::outline
" Rust docs
" Plug 'rhysd/rust-doc.vim', { 'for': 'rust' }
" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Misc
" Plug 'Yggdroot/indentLine' ", { 'on': 'IndentLinesEnable' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" settings toggling + fast navigation (tabs, files)
Plug 'tpope/vim-unimpaired'
" Lint. Check syntax on :w ([l, [L for error traversing)
Plug 'neomake/neomake'

call plug#end() " required
" }}}

" set script encoding

" Set completeopt to have a better completion experience
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
" Avoid showing extra messages when using completion
set shortmess+=c

scriptencoding utf-8

set nocompatible
set number
syntax on

set autoread
set cursorline
set encoding=utf-8  " Necessary to show Unicode glyphs                   
set expandtab
set hidden
set history=100
set laststatus=2    " Always show the statusline
set nobackup
set nofoldenable
set noswapfile
set wrap
set relativenumber
set shiftwidth=4
set showcmd
set tabstop=4
set ts=4
set ttimeoutlen=50
set ttyfast
set virtualedit=all " allow the cursor to go in to 'invalid' places
set wildmenu


" VIM Colors {{{
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

highlight Visual ctermbg=DarkGrey
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight CursorLine ctermbg=none cterm=bold
highlight CursorLineNr ctermbg=none
highlight VertSplit ctermbg=none
highlight Folded ctermbg=none
highlight Pmenu ctermbg=none
highlight PmenuSel cterm=bold
highlight PmenuSbar ctermbg=none
" }}}

" VIM Search {{{
set incsearch
" show the matching part of the pair for [] {} and ()
set showmatch
set hlsearch
set smartcase
set ignorecase
" }}}

if has('persistent_undo')
    set undodir=~/.config/nvim/tmp/undo,~/tmp,/tmp
    set undofile
endif

au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=200, on_visual=true}

let mapleader=","
let maplocalleader="\\"

vnoremap <Leader>y "+y
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P :set invpaste<CR>
nnoremap <Leader>qq :qa!<CR>

" fugitive
nnoremap <Leader>gs :Git status<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>gl :Git log<CR>

" Make the Y behavior similar to D & C
nnoremap Y y$

" zz
nnoremap n nzz
nnoremap N Nzz
nnoremap gd gdzz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

nnoremap zj m`o<Esc>``
nnoremap zk m`O<Esc>``

vmap <tab> >gv
vmap <s-tab> <gv

nnoremap j gj
nnoremap k gk

" Window movements
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

map vv ggVG

" Fast window/buffer kill
nnoremap <silent><Leader>K :bd!<CR>  " buffer do not save
nnoremap <silent><Leader>k :bd<CR>  " buffer

" Synonums
cab Wq wq

nnoremap <Leader>f :Autoformat<CR>
" Manage .vimrc file {{{
nnoremap <Leader>ev :e $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>
" }}}

let g:snips_author="Shimanski Sergei"
let g:snips_email="shimanski.sergei@gmail.com"
let g:snips_github="https://github.com/sshimanski"

" Haskell config {{{
augroup haskell
    autocmd!
    autocmd Filetype haskell nnoremap <Leader>hc :GhcModCheck<CR>
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END
" }}}

" Python config {{{
augroup python
    autocmd!
    autocmd FileType python setlocal omnifunc=jedi#completions
    autocmd FileType python setlocal et sta sw=4 sts=4
    autocmd FileType python setlocal foldmethod=syntax smartindent nocindent
    autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
augroup END

let g:jedi#auto_initialization = 1
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1
let g:jedi#goto_assignments_command = "<Leader>g"
let g:jedi#goto_definitions_command = "gd"
let g:jedi#usages_command = "tu"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
" 1 - in popup, 2 in command line
let g:jedi#show_call_signatures = "2"
" }}}

let g:rainbow_active = 1

" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('omni_patterns', {
"             \ 'go': '[^. *\t]\.\w*',
"             \})
" call deoplete#custom#option({
"             \ 'auto_complete_delay': 200,
"             \ 'smart_case': v:true,
"             \ })
" close preview window
autocmd CompleteDone * silent! pclose!

let g:neomru#file_mru_path = $HOME.'/.config/nvim/tmp/neomru/file'
let g:neomru#directory_mru_path = $HOME.'/.config/nvim/tmp/neomru/directory'
" do not ignore mnt
let g:neomru#file_mru_ignore_pattern =
      \'\~$\|\.\%(o\|exe\|dll\|bak\|zwc\|pyc\|sw[po]\)$'.
      \'\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)'.
      \'\|^\%(\\\\\|/media/\|/temp/\|/tmp/\|\%(/private\)\=/var/folders/\)'.
      \'\|\%(^\%(fugitive\)://\)'

let g:JavaComplete_BaseDir = $HOME.'/.config/nvim/tmp/java'
" Airline plugin config {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}

" Tests {{{
let test#strategy = "neovim"
nmap <silent> \tn :TestNearest<CR>
nmap <silent> \tf :TestFile<CR>
nmap <silent> \ts :TestSuite<CR>
nmap <silent> \tl :TestLast<CR>
nmap <silent> \tv :TestVisit<CR>
" }}}

" NeoMake {{{
" Automatically open error list if errors exists
" let g:neomake_open_list = 2
let g:neomake_haskell_enabled_makers = ['ghcmod', 'hlint']
let g:neomake_python_enabled_makers = ['pylint', 'flake8']
" Change gutter formatting for errors and warnings
highlight NeomakeErrorMsg ctermfg=196
let g:neomake_error_sign={'text': '✖︎', 'texthl': 'NeomakeErrorMsg'}

highlight NeomakeWarningMsg ctermfg=226
let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeWarningMsg'}

autocmd! BufWritePost * Neomake
" noremap <leader>c :Neomake<CR>

" }}}

" Syntastic configuration {{{
" noremap <leader>c :SyntasticCheck<CR>

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" " pip install flake8
" let g:syntastic_python_checkers = ['flake8']

" let g:syntastic_error_symbol  = '⚡'
" let g:syntastic_warning_symbol = '⚠'
" let g:syntastic_style_error_symbol  = 'SE'
" let g:syntastic_style_warning_symbol = 'SW'
" }}}

let g:auto_save = 1  " enable AutoSave on Vim startup

" UltiSnips confg {{{
nnoremap <Leader>eU :UltiSnipsEdit<CR>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetsDir=$HOME."/.config/nvim/UltiSnips"
let g:UltiSnipsEditSplit="horizontal"
" }}}

" Go config {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
" Completion with native LSP
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

augroup golang
    autocmd!
    autocmd FileType go nnoremap \r :GoRun<CR>
    autocmd FileType go nnoremap \d :GoDebugStart<CR>
    autocmd FileType go nnoremap \t :GoTest<CR>
    " to test
    autocmd FileType go nnoremap tt :GoAlternate<CR>
    " to type def
    autocmd FileType go nnoremap td :GoDefType<CR>
    " to implementations
    autocmd FileType go nnoremap ti :GoImplements<CR>
    " optimize imports
    autocmd FileType go nnoremap <Leader>o :GoImports<CR>
    autocmd FileType go nnoremap <Leader>f :GoFmt<CR>
    autocmd FileType go nnoremap <Leader>r :GoRename<CR>
    autocmd FileType go nnoremap <Leader>I :GoInfo<CR>
    autocmd FileType go nnoremap <buffer> <leader>i :exe 'GoImport ' . expand('<cword>')<CR>
    autocmd FileType go nnoremap <Leader>b :GoBuild<CR>
    " autocmd FileType go nnoremap <Leader>c :GoCoverageToggle<CR>
augroup END
" }}}

" Rust config {{{

" Use LSP omni-completion in Rust files
" autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

" augroup rustlang
"     autocmd!
"     autocmd BufRead,BufNewFile *.rs compiler cargo

"     autocmd FileType rust nnoremap \r :Cargo run<CR>
"     autocmd FileType rust nnoremap \c :CargoBuild<CR>
"     autocmd FileType rust nnoremap <Leader>f :RustFmt<CR>

"     autocmd FileType rust nnoremap <silent>[denite]k :<C-u>Denite rust/doc<CR>
"     autocmd FileType rust nnoremap <silent>[denite]K :<C-u>Denite rust/doc:modules<CR>
" augroup END

" Rust autocmplete
" let g:rustfmt_autosave = 1
" let g:rust_doc#downloaded_rust_doc_dir = '/home/sshimanski/.rustup/toolchains/stable-x86_64-unknown-linux-gnu'
" let g:rust_doc#define_map_K=0
" }}}

" LaTeX config {{{
let g:tex_conceal = ''
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'zathura'
" }}}

map <Leader>x :Ranger<CR>
let g:neoranger_viewmode='miller'

map <C-_> :NERDTreeToggle<CR>

augroup MyAutoCmd
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd Filetype java setlocal omnifunc=javacomplete#Complete
augroup END

" Denite plugin config {{{
" nnoremap    [denite]   <Nop>
" nmap     <Space> [denite]

" nnoremap <silent> [denite]b         :<C-u>Denite buffer<CR>
" nnoremap <silent> [denite]c         :<C-u>Denite change<CR>
" nnoremap <silent> [denite]d         :<C-u>DeniteBufferDir file/rec<CR>
" nnoremap <silent> [denite]f         :<C-u>DeniteProjectDir file/rec<CR>
" nnoremap <silent> [denite]gg        :<C-u>DeniteProjectDir grep<CR>
" nnoremap <silent> [denite]gw        :<C-u>DeniteCursorWord grep<CR>
" nnoremap <silent> [denite]h         :<C-u>Denite help<CR>
" nnoremap <silent> [denite]l         :<C-u>Denite line<CR>
" nnoremap <silent> [denite]m         :<C-u>Denite outline<CR>
" nnoremap <silent> [denite]r         :<C-u>Denite file_mru<CR>
" nnoremap <silent> [denite]/         :<C-u>Denite buffer grep<CR>

" autocmd FileType denite call s:denite_my_settings()
" function! s:denite_my_settings() abort
"   nnoremap <silent><buffer><expr> <CR>
"   \ denite#do_map('do_action')
"   nnoremap <silent><buffer><expr> d
"   \ denite#do_map('do_action', 'delete')
"   nnoremap <silent><buffer><expr> p
"   \ denite#do_map('do_action', 'preview')
"   nnoremap <silent><buffer><expr> q
"   \ denite#do_map('quit')
"   nnoremap <silent><buffer><expr> i
"   \ denite#do_map('open_filter_buffer')
"   nnoremap <silent><buffer><expr> <Space>
"   \ denite#do_map('toggle_select').'j'
" endfunction

" autocmd FileType denite-filter call s:denite_filter_my_settings()
" function! s:denite_filter_my_settings() abort
"   imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
" endfunction

" call denite#custom#source('buffer,file_mru,file_mru', 'sorters', ['sorter_sublime'])
" call denite#custom#source('buffer,file_mru,file_mru', 'matchers', ['matcher_substring', 'matcher_ignore_globs'])

" call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
" call denite#custom#var('grep', 'command', ['ag'])
" call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
" call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('grep', 'pattern_opt', [])
" call denite#custom#var('grep', 'separator', ['--'])
" call denite#custom#var('grep', 'final_opts', [])

" call denite#custom#option('default', 'prompt', '❯')
" call denite#custom#option('default', 'highlight_matched_char', 'Debug')
" call denite#custom#option('default', 'highlight_matched_range', 'Normal')

" " Change mappings.
" call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
" call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
" }}} Unite plugin config

" IndentLine plugin config {{{
map <silent> <Leader>L :IndentLinesToggle<CR>
let g:indentLine_enabled = 1
let g:indentLine_char = '┊'
let g:indentLine_color_term = 239
" }}} IndentLine plugin config

" Java config {{{
let g:java_highlight_functions = 'style'
let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_allow_cpp_keywords=1
let g:java_space_errors=1
" }}}

nmap <F8> :TagbarToggle<CR>

" Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim set foldenable
    autocmd FileType vim set foldmethod=marker
augroup END
" }}}

let g:EasyMotion_smartcase = 1
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0

set conceallevel=0

" let g:EasyMotion_do_mapping = 0
" nmap <leader><leader> <Plug>(easymotion-s)

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF

require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end

require('rust-tools').setup({})

EOF

