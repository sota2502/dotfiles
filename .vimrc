syntax on

highlight LineNr ctermfg=darkyellow
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<, 

"set tab
set expandtab
set ts=4
set softtabstop=4
set sw=4

"set list
set number
set laststatus=2
"set backspace=indent,eol,start
"set formatoptions+=m
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v(ASCII=%03.3b,HEX=%02.2B)\ %l/%L(%P)%m

set mouse=a
set ttymouse=xterm2

hi StatusLine term=NONE cterm=NONE ctermfg=white ctermbg=blue

map ,pt <Esc>:'<,'>!perltidy

"set encoding=euc-jp
"set fileencoding=euc-jp
"set fileencodings=iso-2022-jp,utf-8,sjis

" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    "let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_euc . "," . s:enc_jis .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    "if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      "set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"JsLint 20090604
fun! JsLint()
    w%
    let file = getcwd()."/".expand("%")
    execute ":Scratch"
    execute ":0,%delete"
    if has('mac')
        execute "r !/opt/local/bin/js ~/bin/jslint.js ".file." \"`cat ".file."`\""
    elseif has('unix')
        execute "r !/usr/bin/js ~/bin/js/jslint.js ".file." \"`cat ".file."`\""
    endif
endfun

noremap fg :call Search_pm('vne')<ENTER>
noremap ff :call Search_pm('e')<ENTER>
noremap fd :call Search_pm('sp')<ENTER>
noremap ft :call Search_pm('tabe')<ENTER>
