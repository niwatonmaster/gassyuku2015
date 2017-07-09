" 初回起動時のみruntimepathにneobundleのパスを指定する
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" NeoBundleを初期化
call neobundle#begin(expand('~/.vim/bundle/'))
" インストールするプラグインをここに記述
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/neomru.vim'
  NeoBundle 'Shougo/vimfiler'
  NeoBundle 'vim-jp/vimdoc-ja'
  NeoBundle 'junegunn/seoul256.vim'
  NeoBundle 'scrooloose/nerdtree'
  " Ruby向けにendを自動挿入してくれる
  NeoBundle 'tpope/vim-endwise'
  " コメントON/OFFを手軽に実行(ctr+--)
  NeoBundle 'tomtom/tcomment_vim'
  NeoBundle 'open-browser.vim'
  NeoBundle 'basyura/twibill.vim'
  NeoBundle 'TwitVim'
  NeoBundle 'basyura/TweetVim'
call neobundle#end()

" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on

set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

"行数表示する。	
:set number
"右下に桁数表示する。
:set ruler
"コメント行の高さを2行に変更する。
:set cmdheight=2
"構文強調表示を開始する。
:syntax enable
"文字コード
:set encoding=utf-8
:set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp,default,latin

"検索
"検索、置換時に大文字小文字の区別をする。	
:set ignorecase
"検索時に検索にヒットする部分を色付け表示する。
:set hlsearch
"検索する言葉を入力する際、その入力値に該当する直近の結果をハイライトする。
:set incsearch

"編集
"新しい行作成時に、一つ上の行のインデントを保持するかの設定する。
:set autoindent
"挿入モードでBackSpaceキーで削除できる項目の決定する。
:set backspace=indent,eol,start
"行末間の移動を行えるようにする。
:set whichwrap=b,s,[,],<,>,~
"マウスの動作をオンにする
:set mouse=a
"インクリメント検索
:set incsearch
:set wildmenu wildmode=list:longest

"背景色黒
:highlight Normal ctermbg=black ctermfg=grey
:highlight StatusLine term=none cterm=none ctermfg=black ctermbg=grey
:highlight CursorLine term=none cterm=none ctermfg=none ctermbg=darkgray

"インデント幅
:set tabstop=2
:set shiftwidth=2
:set expandtab
:set clipboard=unnamed
nnoremap <leader>rv :source $MYVIMRC<CR>

"挿入モードでステータスラインの色を変更する
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

imap jj <esc>


" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
" """"""""""""""""""""""""""""""
" " Unit.vimの設定
" """"""""""""""""""""""""""""""
" " 入力モードで開始する
 let g:unite_enable_start_insert=1
" " バッファ一覧
 noremap <C-P> :Unite buffer<CR>
" " ファイル一覧
 noremap <C-N> :Unite -buffer-name=file file<CR>
" " 最近使ったファイルの一覧
 noremap <C-Z> :Unite file_mru<CR>
" " sourcesを「今開いているファイルのディレクトリ」とする
 noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" " ウィンドウを分割して開く
 au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
 au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" " ウィンドウを縦に分割して開く
 au FileType unite nnoremap <silent> <buffer> <expr> <C-K>
" unite#do_action('vsplit')
 au FileType unite inoremap <silent> <buffer> <expr> <C-K>
" unite#do_action('vsplit')
" " ESCキーを2回押すと終了する
 au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
 au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" """"""""""""""""""""""""""""""
"
" http://inari.hatenablog.com/entry/2014/05/05/231307
" """"""""""""""""""""""""""""""
" " 全角スペースの表示
" """"""""""""""""""""""""""""""
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray 
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""


""twitvim用
let twitvim_browser_cmd = '/Applications/Google Chrome.app'
let twitvim_count = 40
