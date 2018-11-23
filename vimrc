" the .vimrc
"
" big chunk taken from Ian Langworth's https://statico.github.io/vim3.html
"
"     (@_   ------- {yo!}
"   \\\_\
"   <____)
"
"


" options
syntax on
set autoindent              " Carry over indenting from previous line
set autowrite               " Write on :next/:prev/^Z
set cursorline
set encoding=utf-8
set expandtab
set hlsearch                " Hilight searching
set incsearch               " Search as you type
set laststatus=2
set list                    " Show whitespace as special chars - see listchars
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:· " Unicode characters for various things
set nocompatible
set number
set showmatch               " Hilight matching braces/parens/etc.
set shiftwidth=2
set smartcase               " Lets you search for ALL CAPS
set softtabstop=0
set suffixes+=.pyc          " Ignore these files when tab-completing
set tabstop=2
set visualbell t_vb=        " No flashing or beeping at all

if &term =~ '256color'
" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
 set t_ut=
endif

" enable filetype detection and plugin loading
filetype plugin on

" leader
let mapleader = ","
let maplocalleader = ","

set clipboard=unnamed


" Resize panes when window/terminal gets resize
autocmd VimResized * :wincmd =


" key mappings
imap <Tab> <C-P>


" foldmethod
nnoremap <leader>zi :set foldmethod=indent<CR>


" file-type specific formatting
autocmd FileType make set noexpandtab
autocmd Filetype gitcommit setlocal spell textwidth=72


" easier window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" more natural new window position
set splitbelow
set splitright


" Useful macros
nmap \q :nohlsearch<CR>
nmap \x :cclose<CR>
nmap \o :copen<CR>

inoremap jk <ESC>
nmap <leader>s :w<CR>


" fzf
nmap <Leader>w :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>a :Ag<CR>


" Move between open buffers.
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>


" Switch between buffers
nmap <C-e> :e#<CR>

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'dermusikman/sonicpi.vim'
Plug 'fatih/vim-go'
Plug 'hwayne/tla.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'leshill/vim-json'
Plug 'janko-m/vim-test'
Plug 'junegunn/goyo.vim'
Plug 'lukerandall/haskellmode-vim'
Plug 'mileszs/ack.vim'
Plug 'morhetz/gruvbox'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'thoughtbot/vim-rspec'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'vim-ruby/vim-ruby'
Plug 'w0rp/ale'
call plug#end()

" quicklist
autocmd FileType qf wincmd J
autocmd FileType qf setlocal number nolist scrolloff=0


" ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


" ale config
let g:ale_enabled = 0
let g:ale_echo_cursor = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_completion_enabled = 0
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title
nmap ]l :ALENextWrap<CR>
nmap [l :ALEPreviousWrap<CR>

" Disable old regex engine
" Fix for lag with Ruby
set re=1

" completor.vim
let g:completor_auto_trigger = 0


" vim-gitgutter
set signcolumn=yes


" GitGutter styling to use · instead of +/-
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'


" vim-test configuration
let test#strategy = "asyncrun"
let test#python#runner = "pytest"
nmap <silent> t<C-n> :TestNearest<CR> 
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>


" Golang configuration

autocmd FileType go nmap <silent> t<C-a> :AsyncRun make integtest<CR>

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

let g:go_fmt_command = "goimports"
let g:go_fmt_options = {
  \ 'gofmt': '-s',
  \ 'goimports': '-local github.com',
\ }

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

" sonic-pi
let g:sonicpi_command = 'sonic-pi-tool'
let g:sonicpi_send = 'eval-stdin'
let g:sonicpi_stop = 'stop'
let g:vim_redraw = 1

nmap <leader>c :SonicPiSendBuffer<CR>
nmap <leader>m :SonicPiStop<CR>
nmap <leader>g :SonicPiStop<CR>:SonicPiSendBuffer<CR>

" not very extensible, i know TODO: change!
nnoremap <leader>p :AsyncRun pandoc -f gfm -t html ALGORITHM.md > alg.html<CR>

" haskellmode-vim
let g:haddock_browser = "/usr/bin/firefox"

" haskell-vimmode
au BufEnter *.hs compiler ghc

