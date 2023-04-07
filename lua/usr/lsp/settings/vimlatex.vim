" Follow for setup info
" https://www.ejmastnak.com/tutorials/vim-latex/pdf-reader/#ensure-zathura-synctex
"
" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This will only work if `vim --version` includes `+clientserver`!
if empty(v:servername) && exists('*remote_startserver')
	call remote_startserver('VIM')
endif

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
" syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_forward_search_on_start = 1
let g:vimtex_view_enabled = 1
let g:vimtex_view_method = 'zathura'

" " Or with a generic interface:
let g:vimtex_view_general_viewer = 'zathura'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexrun'
let g:vimtex_compiler_latexrun = {
	\ 'build_dir' : 'build',
	\ 'options' : [
	\   '-verbose-cmds',
	\   '--latex-args="-synctex=1"',
	\ ],
	\}

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
" let maplocalleader = ","
