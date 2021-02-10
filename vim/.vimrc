set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"*******************
" INSTALL PLUGINS HERE 
Plugin 'frazrepo/vim-rainbow'
Plugin 'itchyny/lightline.vim'
Plugin 'preservim/nerdtree'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
"*******************
"
"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confir
"
"***************** 
" Plug installer
"specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
"   " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'kyoz/purify', { 'rtp': 'vim' }

" Initialize plugin system
call plug#end()


" *** OPTIONS ***
:syntax enable
:syntax on
:map <C-n> :NERDTreeToggle<CR>
:set mouse=a
:set number
:set numberwidth=1
:set background=dark
:colorscheme dracula
":colorscheme molokai
:set cursorline
:set laststatus=2
:set tabstop=4
:set shiftwidth=4
:set expandtab
:set softtabstop=4


let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

"*** Tabs OPTIONS ***
:map <C-t><up> :tabr<cr>
:map <C-t><down> :tabl<cr>
:map <C-t><left> :tabp<cr>
:map <C-t><right> :tabn<cr>



" *** CURSOR OPTIONS ***
let &t_SI = "\e[6 q"
let &t_EI = "\e[1 q"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
autocmd InsertEnter * "\e[5 q"
augroup END

