set nocompatible
filetype off

" Vundle Plugins {{{

" No NerdTree, as ranger is used

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" my preffered colorscheme
Plugin 'michalbachowski/vim-wombat256mod'
Plugin 'w0ng/vim-hybrid'
" golang for vim
Plugin 'fatih/vim-go'
" keyword completion system by maintaining a cache of keywords in the current buffer 
" require 'vim-nox' system package
Plugin 'Shougo/neocomplete.vim'
" status line
Plugin 'bling/vim-airline'
" snippets stuff
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" python autocomplete + rename + goto definition
Plugin 'davidhalter/jedi-vim'
" Tagbar (require ctags)
" Plugin 'majutsushi/tagbar'
" comment plugin
Plugin 'scrooloose/nerdcommenter'
" easy motion
Plugin 'Lokaltog/vim-easymotion'
" auto pairs - [], {}, '' etc.
Plugin 'jiangmiao/auto-pairs'
" unite all
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
" Require ctags
Plugin 'Shougo/unite-outline'
Plugin 'Shougo/unite-help'
Plugin 'Shougo/neomru.vim'
Plugin 'osyo-manga/unite-quickfix'
" GIT plugin
Plugin 'tpope/vim-fugitive'
" Rust
Plugin 'rust-lang/rust.vim'
Plugin 'phildawes/racer'
" Diff
Plugin 'Shougo/javacomplete'
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
" settings togglin + fast navigation (tabs, filse)
Plugin 'tpope/vim-unimpaired'
" Check syntax on :w ([l, [L for error traversing)
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/Hardy'
Plugin 'jplaut/vim-arduino-ino'

" All of your Plugins must be added before the following line
call vundle#end() " required
" }}}

"filetype plugin indent on
filetype on

set autoread
set cursorline
"set cursorcolumn
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

" VIM Colors {{{
set t_Co=256
set background=dark
colorscheme wombat256mod
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

syntax on
"
let mapleader=","
let maplocalleader="\\"

nnoremap <Leader>y "+y
nnoremap <Leader>p "*p==
nnoremap <Leader>P :set invpaste<CR>
nnoremap <Leader>qq :qa!<CR>

" Make the Y behavior similar to D & C
nnoremap Y y$
nnoremap ' `
nnoremap ` '

nnoremap zj m`o<Esc>``
nnoremap zk m`O<Esc>``
nnoremap gu gUiw`]

" Manage .vimrc file {{{
nnoremap <Leader>ev :e $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>
" }}}

let g:snips_author="Shimanski Sergei"
let g:snips_email="shimanski.sergei@gmail.com"

au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

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
    autocmd FileType python setlocal foldmethod=indent smartindent nocindent
    autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
augroup END
" }}}

let g:jedi#auto_initialization = 1
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
" 1 - in popup, 2 in command line
let g:jedi#show_call_signatures = "2"

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#max_list = 30
let g:neocomplete#min_keyword_length = 2
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#data_directory = $HOME.'/.vim/tmp/neocomplete'
let g:neocomplete#enable_auto_select = 0

let g:neomru#file_mru_path = $HOME.'/.vim/tmp/neomru/file'
let g:neomru#directory_mru_path = $HOME.'/.vim/tmp/neomru/directory'

" Airline plugin config {{{

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" old vim-powerline symbols
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

let g:airline_theme='powerlineish'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" pip install flake8
let g:syntastic_python_checkers = ['flake8']

let g:syntastic_error_symbol  = '⚡'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol  = 'SE'
let g:syntastic_style_warning_symbol = 'SW'

vmap <tab> >gv
vmap <s-tab> <gv

nnoremap j gj
nnoremap k gk

" Window movements
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h
map <C-S-h> :bprevious<CR>
map <C-S-l> :bnext<CR>
map vv ggVG
nnoremap <Leader>v <C-w>v<C-w>w
nnoremap <Leader>h <C-w>s<C-w>w

" Fast window/buffer kill
nnoremap <Leader>K <C-w>c           " window
nnoremap <silent><Leader>k :bd<CR>  " buffer

" Synonums
cab Wq wq

let g:auto_save = 1  " enable AutoSave on Vim startup

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" vim-go plugin config {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
" }}}

" Golang config {{{
augroup golang
    autocmd!
    autocmd FileType go nnoremap <Leader>s <Plug>(go-implements)
    autocmd FileType go nnoremap <Leader>i <Plug>(go-info)
    autocmd FileType go nnoremap <Leader>r <Plug>(go-run)
    autocmd FileType go nnoremap <Leader>b <Plug>(go-build)
    autocmd FileType go nnoremap <Leader>t <Plug>(go-test)
    autocmd FileType go nnoremap <Leader>c <Plug>(go-coverage)
    autocmd FileType go nnoremap <Leader>e <Plug>(go-rename)
    autocmd FileType go nnoremap <Leader>f :GoFmt<CR>
augroup END
" }}}

" Rust config {{{
augroup rustlang
    autocmd!
    autocmd FileType rust nnoremap <Leader>r :RustRun<CR>
augroup END

" Rust autocmplete
let g:racer_cmd = "/home/sshimansky/work/apps/rust/racer/bin/racer"
let $RUST_SRC_PATH="/home/sshimansky/work/apps/rust/rust-nightly-i686-unknown-linux-gnu"

" }}}

" ranger file manager
fun! RangerChooser()
    exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun
map <Leader>x :call RangerChooser()<CR>

augroup MyAutoCmd
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd Filetype java setlocal omnifunc=javacomplete#Complete
augroup END

" Unite plugin config {{{
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

autocmd MyAutoCmd FileType unite call s:unite_my_settings()

function! s:unite_my_settings()
    nmap <buffer> <ESC> <Plug>(unite_exit)
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
nnoremap <silent>[unite]gg :exe 'silent Ggrep -i '.input("Pattern: ")<Bar> Unite -toggle quickfix<CR>
nnoremap <silent>[unite]gl :exe 'silent Glog'<BAR> Unite -toggle quickfix<CR>
nnoremap <silent>[unite]gf :<C-u>UniteWithProjectDir -silent -toggle file_rec/git<CR>

nnoremap <silent>[unite]b :<C-u>Unite -buffer-name=buffers/bookmarks -silent buffer<CR>
nnoremap <silent>[unite]f :<C-u>UniteWithProjectDir -silent -buffer-name=files file_rec/async:!<cr>
nnoremap <silent>[unite]F :<C-u>UniteWithBufferDir -silent -buffer-name=currdir file<CR>
nnoremap <silent>[unite]c :<C-u>UniteWithProjectDir -silent -buffer-name=classes -ignorecase -input=**.java file_rec/async:!<CR>
nnoremap <silent>[unite]m :<C-u>Unite -silent -buffer-name=mru file_mru<CR>
nnoremap <silent>[unite]l :<C-u>Unite -silent -no-split -auto-preview -start-insert line<CR>
nnoremap <silent>[unite]g :<C-u>Unite -silent -buffer-name=grep -no-quit grep<CR>
nnoremap <silent>[unite]w :<C-u>UniteWithCursorWord -silent -no-quit grep<CR>
nnoremap <silent>[unite]y :<C-u>Unite -silent -no-quit history/yank<CR>
nnoremap <silent>[unite]o :<C-u>Unite -toggle -silent -vertical -buffer-name=outline -winwidth=40 -direction=botright outline<CR>
nnoremap <silent>[unite]r :<C-u>UniteResume<CR>
nnoremap <silent>[unite]q :<C-u>Unite -toggle quickfix<CR>

if executable("ag")
    " the silver search
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
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

" Java
let g:java_highlight_functions = 'style'
let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_allow_cpp_keywords=1
let g:java_space_errors=1


" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <C-h>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

inoremap <expr><C-space> neocomplete#start_manual_complete()
imap <C-@> <C-Space>

" Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim set foldenable
    autocmd FileType vim set foldmethod=marker
augroup END
" }}}

nmap <leader><leader> <Plug>(easymotion-s)
