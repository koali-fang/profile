syntax on
set nocompatible
set number
set autoindent
"set smartindent
set expandtab   
set ts=4 
set shiftwidth=4
set cursorline
set nobackup
" just for encode
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set fileformats=unix
set encoding=utf-8
set hlsearch
" set foldmethod
set fdm=indent
"set completeopt=longest
ab COMMENT_F /** */
ab JAVASCRIPT <script type="text/javascript" src=""></script>
ab HTML <html><CR><head><CR></head><CR><body><CR></body><CR></html>
"set paste


set completeopt=longest,menu

function AddPHPFuncList()
    set dictionary-=~/.vim/tools/php/functions.txt  dictionary+=~/.vim/tools/php/functions.txt 
    set complete-=k complete+=k
endfunction
au FileType php call AddPHPFuncList()

function AddPythonFuncList()
    set dictionary-=~/.vim/tools/python/complete-dict dictionary+=~/.vim/tools/python/complete-dict
    set complete-=k complete+=k
endfunction
au FileType python call AddPythonFuncList()

"colorscheme darkblue 

filetype on
filetype plugin on
filetype indent on

autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif

autocmd BufNewFile *.c 0r ~/.vim/template/cconfig.c
autocmd BufNewFile *.php 0r ~/.vim/template/phpconfig.php