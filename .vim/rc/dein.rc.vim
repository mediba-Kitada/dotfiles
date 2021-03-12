"dein Scripts-----------------------------
if &compatible
set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/kitada/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/kitada/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/Users/kitada/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
"
" dein configurations

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
