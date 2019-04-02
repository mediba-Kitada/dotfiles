if executable('ag')
	call denite#custom#var('file/rec', 'command',
		\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif

" Change default prompt
call denite#custom#option('default', 'prompt', '>')

" Change ignore_globs
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
	\ [ '.git/', '.ropeproject/', '__pycache__/',
	\   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

call denite#custom#map(
	\ 'insert',
	\ '<C-N>',
	\ '<denite:move_to_next_line>',
	\ 'noremap'
\)
call denite#custom#map(
	\ 'insert',
	\ '<C-P>',
	\ '<denite:move_to_previous_line>',
	\ 'noremap'
\)

" Ag command on grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
		\ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

