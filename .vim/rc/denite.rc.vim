autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> a
  \ denite#do_map('do_action', 'add')
  nnoremap <silent><buffer><expr> r
  \ denite#do_map('do_action', 'reset')
  nnoremap <silent><buffer><expr> c
  \ denite#do_map('choose_action')
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  imap <silent><buffer> <C-c> <Plug>(denite_filter_quit)
endfunction

" Change default action.
call denite#custom#kind('file', 'default_action', 'split')

if executable('ag')
	call denite#custom#var('file/rec', 'command',
		\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
	" Ag command on grep source
	call denite#custom#var('grep', 'command', ['ag'])
	call denite#custom#var('grep', 'default_opts',
			\ ['-i', '--vimgrep'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', [])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
endif

" Change ignore_globs
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
	\ [ '.git/', '.ropeproject/', '__pycache__/',
	\   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

