"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""" This is Con_Humi's VIM Settings File. """""""""""
"""""""""""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"------------------------------------------------------------
"Pure Vim Settings
set clipboard+=unnnamed
set number
set backup
set backupdir=/tmp
set directory=/tmp
set undodir=/tmp
set tabstop=4
set shiftwidth=4
set softtabstop=0
set autoindent
set nowrap
set fenc=utf-8
syntax on

" ESCでハイライトをオフ
nnoremap <silent> <ESC> <ESC>:noh<CR>

"End Pure Vim Settings
"------------------------------------------------------------

"------------------------------------------------------------
"Color Scheme Setting
"
colorscheme molokai
"
"End Color Scheme Setting
"------------------------------------------------------------

"------------------------------------------------------------
"NeoBundle Scripts
if has('vim_starting')
	set nocompatible               " Be iMproved

	" Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'marijnh/tern_for_vim', {'build':{'others':'npm install'}}
NeoBundle 'https://github.com/fuenor/im_control.vimhttps://github.com/fuenor/im_control.vim'
" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts
"------------------------------------------------------------

"neocomplete の設定
" ------------------------------------------------------------
"if neobundle#tap('neocomplete')
"	call neobundle#config({"autoload": {"insert": 1}})
"	function! neobundle#tapped.hooks.on_source(bundle)
""""""""""""""" NeoCompleteの設定 
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
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
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return neocomplete#close_popup() . "\<CR>"
	" For no inserting <CR> key.
	"return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

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
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"	endfunction
"	call neobundle#untap()
"endif
" ------------------------------------------------------------
  
" ------------------------------------------------------------
" NeoSnippetの設定
if neobundle#tap('neosnippet.vim')
	call neobundle#config({"autoload": {"insert": 1}})
	function! neobundle#tapped.hooks.on_source(bundle)
		" Plugin key-mappings.
		imap <C-k>     <Plug>(neosnippet_expand_or_jump)
		smap <C-k>     <Plug>(neosnippet_expand_or_jump)
		xmap <C-k>     <Plug>(neosnippet_expand_target)
		" SuperTab like snippets behavior.
		imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": pumvisible() ? "\<C-n>" : "\<TAB>"
		smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": "\<TAB>"
		" For snippet_complete marker.
		if has('conceal')
			set conceallevel=2 concealcursor=i
		endif
	endfunction
	call neobundle#untap()
endif
" End NeoSnippetの設定
" ------------------------------------------------------------

"------------------------------------------------------------
" im_control.vim の設定
" 「日本語入力固定モード」の動作モード
let IM_CtrlMode = 1
" 「日本語入力固定モード」切替キー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>

" IBus 1.5以降
function! IMCtrl(cmd)
  let cmd = a:cmd
  if cmd == 'On'
    let res = system('ibus engine "mozc-jp"')
  elseif cmd == 'Off'
    let res = system('ibus engine "xkb:jp::jpn"')
  endif
  return ''
endfunction

" <ESC>押下後のIM切替開始までの反応が遅い場合はttimeoutlenを短く設定してみてください。
" IMCtrl()のsystem()コマンド実行時に&を付けて非同期で実行するという方法でも体感速度が上がる場合があります。
set timeout timeoutlen=3000 ttimeoutlen=100 "
"------------------------------------------------------------

"------------------------------------------------------------
"Add New Setting
"
"------------------------------------------------------------
