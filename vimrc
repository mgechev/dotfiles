"Sets nice colorscheme
colorscheme slate
"Starts the syntax
syntax on
"Sets smart indent
set smartindent
"Sets 4 spaces on tab
set tabstop=4
set shiftwidth=4
set expandtab
"Shows the lines number
set number
"Shows the found search results
set showmatch
"Shows the current line (where is the cursor at the moment)
set cursorline
"Highlights the current line in a better way
highlight CursorLine term=none cterm=none ctermbg=0xcccccc
"Stops vim from behaving like a strong vi compatible
set nocompatible
"Highlights all search matches
set hlsearch
"Shows the cursor position
set ruler
"Shows the current mode
set showmode
"Shows the current file at the title bar
set title

"Strips trailing whitespace
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace ()<CR>
set backspace=2
set nocp

"Stops the arrows
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

"Enables the filetype plugin
filetype plugin on
set ofu=syntaxcomplete#Complete

"call pathogen#infect()
set guioptions-=T
set guioptions-=r
set guioptions-=m
"gvim font size
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 11
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif
