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


" ESCをCtl-cにマッピング
inoremap <C-c> <ESc>

" 行数を表示
set number

" 検索における大文字/小文字の区別削除"
set ignorecase
set smartcase

" 現在のモードの表示"
set showmode

" ヘルプモードのショートカット"
nnoremap <C-h>	:<C-u>help<space>
nnoremap <C-h><C-h>	:<C-u>help<Space><C-r><C-w><Enter>
" 読むべき:helpドキュメント
"" tips ヒント
"" user-manual 目的別ユーザマニュアル
"" reference_toc 各機能の詳細を記したリファレンス
"" sys-file-list 環境固有の事情を記したドキュメント

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

" 構文チェックを有効化
syntax enable

"----
"Start dein
"----
let g:dein#install_log_filename = '~/dein.log'
let s:dein_toml = '~/.vim/rc/dein.toml'
let s:dein_lazy_toml = '~/.vim/rc/deinlazy.toml'
if &compatible
  set compatible
endif
set runtimepath+=$DEIN_DIR/repos/github.com/Shougo/dein.vim
if !dein#load_state($DEIN_DIR)
	finish
endif
call dein#begin($DEIN_DIR, [
	\ expand('<sfile>'), s:dein_toml, s:dein_lazy_toml
	\ ])
call dein#load_toml(s:dein_toml, {'lazy': 0})
call dein#load_toml(s:dein_lazy_toml, {'lazy': 1})
call dein#end()
call dein#save_state()
"----
"End dein
"----

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

" vim-tags
set exrc
set secure

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

" Powerline
let g:powerline_pycmd="python3"
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2
set showtabline=2
set noshowmode 



"" highlight
let g:go_hightlight_functions = 1
let g:go_hightlight_methods = 1
let g:go_hightlight_structs = 1
let g:go_hightlight_interfaces = 1
let g:go_hightlight_operators = 1
let g:go_hightlight_build_constraints = 1
"" GoFmt時にインポートするパッケージを整理
let g:go_fmt_command = "goimports"

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
"" Github Flavored Markdownの表記法に合わせる
let g:table_mode_corner = "|"

" 数値処理
"" 0がプレフィックスの数値を10進数として扱う
set nrformats=

" 画面分割に関するキーマップ
nnoremap s <Nop>
"" 画面分割
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
"" 分割した画面を移動
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sw <C-w>w
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sr <C-w>R
"" タブ操作
nnoremap st :<C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT

" JavaScript
"" indent for javascript
autocmd filetype coffee,javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
"" node.js辞書ファイル
au FileType javascript set dictionary+=$HOME/.vim/bundle/vim-node-dict/dict/node.dict
"" syntax highlighting
autocmd BufRead,BufNewFile *.{es6,js} setfiletype javascript

" shell script
"" indent for shell script
autocmd filetype sh setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

" ALE
"let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_emit_conflict_warnings = 0

" calendar.vim
let g:calendar_google_calendar = 1
let g:calendar_views = ['year','month','weekday','day','clock']

" 起動時の挙動
autocmd VimEnter * nested if @% == '' && s:GetBufByte() == 0 | edit $MYVIMRC | endif
function! s:GetBufByte()
  let byte = line2byte(line('$') + 1)
  if byte == -1
	return 0
  else
	return byte - 1
  endif
endfunction
