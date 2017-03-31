﻿" Plugins {{{

" set the runtime path to include Vundle and initialize
call plug#begin('~/.config/nvim/bundle')

Plug 'plasticboy/vim-markdown'
Plug 'chriskempson/base16-vim'
" tagbar
Plug 'majutsushi/tagbar'
" tests
Plug 'janko-m/vim-test'
" golang for vim
Plug 'fatih/vim-go', { 'for': 'go' }
" keyword completion system by maintaining a cache of keywords in the current buffer 
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
" status line
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" snippets stuff
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" python autocomplete + rename + goto definition
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" easy motion
Plug 'Lokaltog/vim-easymotion'
" auto pairs - [], {}, '' etc.
Plug 'jiangmiao/auto-pairs'
" unite all
Plug 'Shougo/vimproc.vim', { 'do': 'make'  }
Plug 'Shougo/unite.vim'
" Require exuberant-ctags
Plug 'Shougo/unite-outline'
Plug 'Shougo/unite-help'
Plug 'Shougo/neomru.vim'
Plug 'osyo-manga/unite-quickfix'
" GIT plugin
Plug 'tpope/vim-fugitive'
" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'timonv/vim-cargo', { 'for': 'rust' }
Plug 'rhysd/rust-doc.vim', { 'for': 'rust' }
" Diff
" Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" settings toggling + fast navigation (tabs, files)
Plug 'tpope/vim-unimpaired'
" Plug 'scrooloose/syntastic'
" Lint. Check syntax on :w ([l, [L for error traversing)
Plug 'neomake/neomake'
" Arduino 
Plug 'vim-scripts/Hardy', { 'for': 'arduino' }

call plug#end() " required
" }}}

set nocompatible
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
set number
set shiftwidth=4
set showcmd
set tabstop=4
set ts=4
set ttimeoutlen=50
set ttyfast
set virtualedit=all " allow the cursor to go in to 'invalid' places
set wildmenu

syntax on

" VIM Colors {{{
" colorscheme wombat256i
" set background=dark
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

hi Normal ctermbg=none
hi NonText ctermbg=none
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
    set undodir=~/.vim/undo,~/tmp,/tmp
    set undofile
endif

let mapleader=","
let maplocalleader="\\"

vnoremap <Leader>y "+y
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p==
nnoremap <Leader>P :set invpaste<CR>
nnoremap <Leader>qq :qa!<CR>

" fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>gl :Glog<CR>

" Make the Y behavior similar to D & C
nnoremap Y y$
nnoremap ' `
nnoremap ` '

nnoremap n nzz
nnoremap N Nzz
nnoremap gd gdzz

nnoremap zj m`o<Esc>``
nnoremap zk m`O<Esc>``
nnoremap gu gUiw`]

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
nnoremap <Leader>K <C-w>c           " window
nnoremap <silent><Leader>k :bd<CR>  " buffer

" Synonums
cab Wq wq


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
let g:jedi#usages_command = "<Space>u"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
" 1 - in popup, 2 in command line
let g:jedi#show_call_signatures = "2"
" }}}

let g:deoplete#enable_at_startup = 1

let g:neomru#file_mru_path = $HOME.'/.vim/tmp/neomru/file'
let g:neomru#directory_mru_path = $HOME.'/.vim/tmp/neomru/directory'

let g:JavaComplete_BaseDir = $HOME.'/.vim/tmp/java'
" Airline plugin config {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_oceanicnext'
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

augroup golang
    autocmd!
    autocmd FileType go nnoremap \r :GoRun<CR>
    autocmd FileType go nnoremap <Leader>f :GoFmt<CR>
    autocmd FileType go nnoremap <Leader>r :GoRename<CR>
    autocmd FileType go nnoremap <Leader>s :GoImplmenets<CR>
    autocmd FileType go nnoremap <Leader>I :GoInfo<CR>
    autocmd FileType go nnoremap <buffer> <leader>i :exe 'GoImport ' . expand('<cword>')<CR>
    autocmd FileType go nnoremap <Leader>b :GoBuild<CR>
    " autocmd FileType go nnoremap <Leader>c :GoCoverageToggle<CR>
augroup END
" }}}

" Rust config {{{
augroup rustlang
    autocmd!
    autocmd BufRead,BufNewFile *.rs compiler cargo
    autocmd FileType rust nnoremap gd :call racer#GoToDefinition()<CR>
    autocmd FileType rust nnoremap K :call racer#ShowDocumentation()<CR>

    autocmd FileType rust nnoremap \r :RustRun<CR>
    autocmd FileType rust nnoremap \c :CargoBuild<CR>
    autocmd FileType rust nnoremap <Leader>f :RustFmt<CR>

    autocmd FileType rust nnoremap <silent>[unite]k :<C-u>Unite -silent -start-insert rust/doc<CR>
    autocmd FileType rust nnoremap <silent>[unite]K :<C-u>Unite -silent -start-insert rust/doc:modules<CR>
augroup END

" Rust autocmplete
let g:rust_doc#downloaded_rust_doc_dir = '/home/shim/.rustup/toolchains/stable-x86_64-unknown-linux-gnu'
let g:rust_doc#define_map_K=0
let g:racer_cmd = 'racer'
let g:racer_experimental_completer = 1
" }}}

" Ranger file manager {{{
fun! RangerChooser()
    exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun
map <Leader>x :call RangerChooser()<CR>
" }}}

augroup MyAutoCmd
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd Filetype java setlocal omnifunc=javacomplete#Complete
augroup END

" Unite plugin config {{{
call unite#custom#source('file_rec', 'sorters', 'sorter_reverse')
call unite#custom#source('buffer,file_rec,file_rec/async', 'matchers',
  \ ['converter_tail', 'matcher_fuzzy'])
" call unite#custom#source('file_mru', 'matchers',
  " \ ['matcher_project_files', 'matcher_hide_hidden_files'])
call unite#custom#source('file', 'matchers',
  \ ['matcher_fuzzy', 'matcher_hide_hidden_files'])
call unite#custom#source('file_rec/async,file_mru', 'converters',
  \ ['converter_file_directory'])

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

autocmd MyAutoCmd FileType unite call s:unite_my_settings()

function! s:unite_my_settings()
    nmap <buffer> <ESC> <Plug>(unite_exit)
    nmap <buffer> <C-r> <Plug>(unite_redraw)
    imap <buffer>  jj        <Plug>(unite_insert_leave)
    imap <buffer>  <Tab>     <Plug>(unite_complete)
    nnoremap <silent><buffer><expr>p unite#do_action('persist_open')
endfunction

let g:unite_data_directory = $HOME.'/.vim/tmp/unite'
let g:unite_winheight = 10
let g:unite_candidate_icon="▸ "
let g:unite_source_history_yank_enable = 1

" Default configuration.
let default_context = {
      \'prompt':'▸ ',
      \ 'vertical' : 0,
      \ }
call unite#custom#profile('default', 'context', default_context)

nnoremap <silent>gm :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent>gM :<C-u>Unite -silent -buffer-name=bookmarked bookmark<CR>

noremap [unite] <Nop>
map     <Space> [unite]
" Git
" nnoremap <silent>[unite]gg :exe 'silent Ggrep -i '.input("Pattern: ")<Bar> Unite -toggle quickfix<CR>
nnoremap <silent>[unite]gl :exe 'silent Glog'<BAR> Unite -toggle quickfix<CR>
nnoremap <silent>[unite]gf :<C-u>UniteWithProjectDir -start-insert -silent -toggle file_rec/git<CR>

nnoremap <silent>[unite]b :<C-u>Unite -buffer-name=buffers/bookmarks -silent -start-insert buffer<CR>
nnoremap <silent>[unite]f :<C-u>UniteWithProjectDir -silent -start-insert -buffer-name=project_files file_rec/async:!<cr>
nnoremap <silent>[unite]d :<C-u>UniteWithBufferDir -silent -start-insert -buffer-name=directory file<CR>
nnoremap <silent>[unite]r :<C-u>Unite -silent -buffer-name=mru file_mru -start-insert<CR>
nnoremap <silent>[unite]l :<C-u>Unite -silent -no-split -auto-preview -start-insert line<CR>
" grep word in current working directory
nnoremap <silent>[unite]g :<C-u>UniteWithProjectDir -silent -buffer-name=grep -no-quit grep<CR>
" grep word under the cursor in current working directory
nnoremap <silent>[unite]w :<C-u>UniteWithCursorWord -silent -no-quit grep<CR>
nnoremap <silent>[unite]y :<C-u>Unite -silent -no-quit history/yank<CR>
" nnoremap <silent>[unite]m :<C-u>Unite -toggle -silent -vertical -start-insert -buffer-name=outline -winwidth=50 -direction=botright outline<CR>
nnoremap <silent>[unite]m :<C-u>Unite -toggle -silent -start-insert -buffer-name=outline outline<CR>
nnoremap <silent>[unite]R :<C-u>UniteResume<CR>
nnoremap <silent>[unite]q :<C-u>Unite -toggle quickfix<CR>
" grep in vim help
nnoremap <silent>[unite]h :<C-u>Unite -start-insert -buffer-name=help help<CR>

" Ignore wildignore
call unite#custom#source('file_rec', 'ignore_globs', split(&wildignore, ','))
call unite#custom#source('file_rec/async', 'ignore_globs', split(&wildignore, ','))

if executable("ag")
    " the silver search                    
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column --follow --smart-case --nocolor'
    let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
endif

" TODO init menu
nnoremap [menu] <Nop>
nmap <LocalLeader> [menu]
nnoremap <silent>[menu]m :Unite -buffer-name=menus -silent -winheight=20 menu<CR>

let g:unite_source_menu_menus = {}
let g:unite_source_menu_menus.navigate = { 'description' : 'navigate in buffers, files, yank history, marks etc.'}

let g:unite_source_menu_menus.navigate.command_candidates = [
    \['▷ open buffer                                                  <Space>b',
        \'Unite -buffer-name=buffers -silent buffer'],
    \]
nnoremap <silent>[menu]n :Unite -buffer-name=navigate -silent menu:navigate<CR>

" }}} Unite plugin config

" IndentLine plugin config {{{
map <silent> <Leader>L :IndentLinesToggle<CR>
let g:indentLine_enabled = 0
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
" Plugin key-mappings.
" inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
  " For no inserting <CR> key.
  " return pumvisible() ? neocomplete#close_popup() : "\<CR>"
" endfunction

" <C-h>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplete#close_popup()
" inoremap <expr><C-e>  neocomplete#cancel_popup()

" inoremap <expr><C-space> neocomplete#start_manual_complete()
imap <C-@> <C-Space>

" Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim set foldenable
    autocmd FileType vim set foldmethod=marker
augroup END
" }}}

let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
nmap <leader><leader> <Plug>(easymotion-s)