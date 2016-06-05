" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as 'evim' evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=10000		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Edit .vimrc"
nnoremap <Space>.	:<C-u>edit $MYVIMRC<Enter>
" Reload .vimrc"
nnoremap <Space>s.	:<C-u>source $MYVIMRC<Enter>

" 検索における大文字/小文字の区別削除"
set ignorecase
set smartcase

" 現在のモードの表示"
set showmode

" ヘルプモードのショートカット"
nnoremap <C-h>	:<C-u>help<space>
nnoremap <C-h><C-h>	:<C-u>help<Space><C-r><C-w><Enter>

" コマンドモードのショートカット"
noremap ; :
noremap : ;

" コマンド、検索履歴はCtrl-Fに統一
noremap q: <NOP>
noremap q/ <NOP>
noremap q? <NOP>

" 論理行移動と表示行移動のキーバインディング入れ替え"
noremap j	gj
noremap k	gk
noremap gj	j
noremap gk	k

" 日時の入力補完"
inoremap <expr> ,df	strftime('%Y-%m-%d %H:%M:%S')
inoremap <expr> ,dd	strftime('%Y-%m-%d')
inoremap <expr> ,dt	strftime('%Y:%m:%S')

" 最後に変更したテキストの選択"
nnoremap gc	`[v`]
vnoremap gc	:<C-u>nomal gc<Enter>
onoremap gc	:<C-u>nomal gc<Enter>

" シンタックスハイライトの色設定の上書き"
colorscheme desert
autocmd ColorScheme *
\ highlight TabLine
\	cterm=NONE
\	ctermfg=lightgray
\	ctermbg=darkgray
doautocmd ColorScheme _

" カレントウィンドウのカーソル行をハイライト"
autocmd WinEnter *	setlocal cursorline
autocmd WinLeave *	setlocal nocursorline

" 文字エンコーディングを指定しファイルを開く"
command! Cp932	edit ++enc=cp932
command! Eucjp	edit ++enc=ecu-jp
command! Iso2022jp	edit ++enc=iso-2022jp
command! Utf8	edit ++enc=utf-8
command! Jis	Iso2022jp
command! Sjis	Cp932

" オートインデント"
set autoindent

" 誤操作防止
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

" leaderを,とする
let mapleader = ","
noremap \ ,

" 正規表現
nnoremap / /\v
nnoremap ? ?\v
"" /の自動エスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
 
" NERDTreeを設定 
NeoBundle 'scrooloose/nerdtree' 
" 自動的に閉じ括弧を挿入
NeoBundle 'Townk/vim-autoclose' 
" phpqa
NeoBundle 'joonty/vim-phpqa'
" ctags
NeoBundle 'szw/vim-tags'
" tabbar
NeoBundle 'majutsushi/tagbar'
" vim-scripts/tagbar-phpctags
NeoBundle 'vim-scripts/tagbar-phpctags', {
  \ 'build' :{
  \   'others' : 'chmod +x bin/phpctags',
  \ },
  \}

" vim-ref
NeoBundle 'thinca/vim-ref'
" vim-markdown
NeoBundle 'godlygeek/tabular'
NeoBundle 'tpope/vim-markdown'
" TwitVim
NeoBundle 'vim-scripts/TwitVim'
" fugitive
NeoBundle 'tpope/vim-fugitive'
" neosnippet
NeoBundle 'Shougo/neocomplete.vim'
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'php' : $HOME.'/.vim/dict/php.dict'
\ }
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" Recommended key-mappings.
" " <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>""
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc',{
\	'build' : {
\     'mac' : 'make -f make_mac.mak',
\   },
\ }
" javascript
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'moll/vim-node'
NeoBundle 'ahayman/vim-nodejs-complete'
NeoBundle 'jaxbot/github-issues.vim'
" JSON
NeoBundle 'elzr/vim-json'
" preview Markdown
NeoBundle 'kannokanno/previm'
" ansible
NeoBundle 'chase/vim-ansible-yaml'
" textile
NeoBundle 'timcharper/textile.vim'
" xml.vim
NeoBundle 'othree/xml.vim'
" vim-node-dict
NeoBundle 'guileen/vim-node-dict'
" vim-scala
NeoBundle 'derekwyatt/vim-scala'
" golang
NeoBundle 'fatih/vim-go'

" Vdebug
NeoBundle 'joonty/vdebug'

" syntastic
NeoBundle 'scrooloose/syntastic'

" vim-endwise
"" 自動で閉じる
NeoBundle 'tpope/vim-endwise'

" Ruby
"" vim-ref-ri
NeoBundle 'yuku-t/vim-ref-ri'
"" rails.vim
NeoBundle 'rails.vim'
"" .や::を入力したときにオムニ補完が有効になるようにする
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.  *\t]\.\w*\|\h\w*::'

" git コミットブラウザ agit.vim
NeoBundle 'cohama/agit.vim'

" open-browser.vim カーソル下のURIをブラウザで表示
NeoBundle 'tyru/open-browser.vim'
" open-browser-github.vim
NeoBundle 'tyru/open-browser-github.vim'

" tableを記述/整形
NeoBundle 'dhruvasagar/vim-table-mode'

call neobundle#end()
 
" Required:
filetype plugin indent on
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-------------------------

" CodeSnifferの設定をプロジェクト毎に読み込み
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand(':p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction '))

" PHP辞書ファイル
autocmd FileType php :set dictionary=~/.vim/dict/php.dict

" 拡張子phpのファイルを開いた際にtagsファイルを変更
au BufNewFile,BufRead *.php set tags+=$HOME/php.tags

" vim-tags tagsファイルを更新
au BufNewFile,BufRead *.php let g:vim_tags_project_tags_command = "ctags --languages=php -f $HOME/php.tags `pwd` 2>/dev/null &"

NeoBundleLazy 'vim-scripts/taglist.vim', {
\    'autoload' : {
\        'commands' : 'Tlist',},}
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let g:tlist_php_settings = 'php;c:class;f:function;d:constant'
nnoremap <Leader>tl :Tlist<CR>

" PHPマニュアル読み込み
let g:ref_cache_dir = $HOME.'/.vim/vim-ref/cache'
let g:ref_phpmanual_path = $HOME.'/.vim/vim-ref/php-chunked-xhtml'

" IDE for PHP
"autocmd FileType php :NERDTree
set number

" md as markdow
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" tab space
set tabstop=4
set shiftwidth=4

" swapファイルを利用しない
set noswapfile

" Exコマンド補完
set wildmenu
set wildmode=full

" unite.vim
" insert modeで開始
let g:unite_enable_start_insert = 1
" 大文字/小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
" grep検索
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep検索結果の再呼び出し
nnoremap <silent> ,r :<C-u>UniteResume search-buffer<CR>
" unite grep に ag(The Silver Searcher) を利用
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	let g:unite_source_grep_recursive_opt = ''
endif
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>

" indent for javascript
autocmd filetype coffee,javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

" crontab対策
"set backupskip=/tmp/*,/private/tmp/*

command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
  if 0 == a:0
    let l:arg = "."
  else
    let l:arg = a:1
  endif
endfunction

" active directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" node.js辞書ファイル
au FileType javascript set dictionary+=$HOME/.vim/bundle/vim-node-dict/dict/node.dict

" github-issues
let g:github_access_token = "e484054fa0b0737921ca878f45279ee6f391c422"

" page nation
"set scrolloff=5

" 検索結果のハイライトを消す
set hlsearch
nnoremap <ESC><ESC> :nohlsearch<CR>

" ビープ音off
set visualbell t_vb=
set noerrorbells

" 検索結果の中央表示
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" move command mode from insert mode
inoremap <silent> jj <ESC>

" 全角スペースの可視化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" copy clipboard yanked data
set clipboard=unnamed,autoselect

" TwitVim
let g:twitvim_browser_cmd = 'open -a Google\ Chrome'

" Powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2
set showtabline=2
set noshowmode 

" syntastic with Rubocop
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

" vim-go
"" mapping
""" go run
au FileType go nmap <Leader>gr <Plug>(go-run)
""" go test
au FileType go nmap <Leader>gt <Plug>(go-test)
"" highlight
let g:go_hightlight_functions = 1
let g:go_hightlight_methods = 1
let g:go_hightlight_structs = 1
let g:go_hightlight_interfaces = 1
let g:go_hightlight_operators = 1
let g:go_hightlight_build_constraints = 1
"" GoFmt時にインポートするパッケージを整理
"let g:go_fmt_command = "goimports"

" git
"" :Man 確認したいコマンド
runtime ftplugin/man.vim
"" :gi gitコマンド
nnoremap gi :<C-u>!git<Space>
"" スペルチェック
set spelllang=en,cjk
"" git commitの際に自動でスペルチェックを有効にする
autocmd FileType gitcommit setlocal spell
"" git commitの際は、挿入モード
autocmd FileType gitcommit startinsert

" github
"" open-browser-github.vim キーバインド
""" 編集中のファイルの最新のコミットをブラウザで表示
nnoremap gio :<C-u>OpenGithubFile<CR>
xnoremap gio :OpenGithubFile<CR>
"" Github Flavored Markdownの表記法に合わせる
let g:table_mode_corner = "|"
