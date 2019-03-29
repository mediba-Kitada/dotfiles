dein
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
