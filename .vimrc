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
set history=50		" keep 50 lines of command line history
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
" ねこ
NeoBundle 'nefo-mi/nyan-modoki.vim'
" phpcs
NeoBundle 'bpearson/vim-phpcs'
" php-cs-fixer
NeoBundle 'stephpy/vim-php-cs-fixer'
" ctags
NeoBundle 'szw/vim-tags'

call neobundle#end()
 
" Required:
filetype plugin indent on
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-------------------------

" ねこ
set laststatus=2
set statusline=%{g:NyanModoki()}
let g:nyan_modoki_select_cat_face_number = 2

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

" tabの可視化
set list
set listchars=tab:>-
set shiftwidth=4

" PHP辞書ファイル
autocmd FileType php :set dictionary=~/.vim/dict/php.dict

" ctags
autocmd BufNewFile,BufRead $HOME/vagrants/lucky-aws/kittyhawk/tokuten.auone.jp/*.php setlocal tags=$HOME/.vim/tags/kittyhawk.tags
NeoBundleLazy 'vim-scripts/taglist.vim', {
\    'autoload' : {
\        'commands' : 'Tlist',},}
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let g:tlist_php_settings = 'php;c:class;f:function;d:constant'
nnoremap <Leader>t :Tlist<CR>
