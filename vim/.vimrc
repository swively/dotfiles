
set nocompatible              " be iMproved, required
filetype off                  " required

set number
set ruler
set equalalways
set clipboard=unnamed,unnamedplus
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'thoughtbot/vim-rspec'
Plugin 'int3/vim-extradite'
Plugin 'zacanger/angr.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'joshdick/onedark.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-fugitive'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'mxw/vim-jsx'
Plugin 'leafgarland/typescript-vim'
Plugin 'keith/rspec.vim'

set noswapfile
call vundle#end()            " required
filetype plugin indent on    " required
set background=dark
filetype plugin on

syntax on
set t_Co=256
" colorscheme parsec
colorscheme angr
" colorscheme jellybeans
" colorscheme solarized
" colorscheme atom-dark
" colorscheme srcery
" colors happy_hacking
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

" read coffee and es6 files as javascript god damnit
autocmd BufRead,BufNewFile *.coffee setfiletype javascript
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

set scrolloff=11
set expandtab
set tabstop=2
set shiftwidth=2
set laststatus=2
set backspace=indent,eol,start

" 'normal' vim stuff
if !has('nvim')
  set nocompatible
  set autoread
  set backspace=indent,eol,start
  set encoding=utf-8
  set history=1000
  set laststatus=2
  set ttyfast
  set incsearch
  set hlsearch
endif

function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction

nnoremap <leader>e :call FzyCommand("ag . --silent -l -g ''", ":e")<cr>
nnoremap <leader>v :call FzyCommand("ag . --silent -l -g ''", ":vs")<cr>
nnoremap <leader>s :call FzyCommand("ag . --silent -l -g ''", ":sp")<cr>
nnoremap <leader>h :call FzyCommand("ag . --silent -l -g ''", ":sp")<cr>
nnoremap <leader>g :call FzyCommand("ag . -l -g '' $(bundle show $(bundle list \| tail -n +2 \| cut -f 4 -d' ' \| fzy) \| tail -1)", ":vs")<cr>

" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

"RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>n :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Fix old hash rocket to new hash syntax
map <leader>: :%s/:\(\w\+\)\(\s*=>\s*\)/\1: /gc

let g:rspec_command="!bundle exec rspec {spec}"

set mouse+=a
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

" vim-jsx
let g:jsx_ext_required = 0


" synstastic stuff
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_haml_checkers = ['haml_lint']
let g:syntastic_mode_map = { "mode": "passive" }

function! Rockets()
  lllll
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STUFF FROM RICKY ~~~~
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" create directories required for a file to save
" " if they don't exist already

" function s:MkNonExDir(file, buf)
"     if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
"         let dir=fnamemodify(a:file, ':h')
"         if !isdirectory(dir)
"             call mkdir(dir, 'p')
"         endif
"     endif
" endfunction

" augroup BWCCreateDir
"     autocmd!
"     autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
" augroup END

" " rename current file
" function! RenameFile()
"     let old_name = expand('%')
"     let new_name = input('New file name: ', expand('%'), 'file')
"     if new_name != '' && new_name != old_name
"         exec ':saveas ' . new_name
"         exec ':silent !rm ' . old_name
"         redraw!
"     endif
" endfunction
" map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" vim swap window stuff. \mw  \pw
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

nnoremap <leader>g :call FzyCommand("ag . -l -g '' $(bundle show $(bundle list \| tail -n +2 \| cut -f 4 -d' ' \| fzy) \| tail -1)", ":vs")<cr>

