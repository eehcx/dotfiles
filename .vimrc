call plug#begin('~/.vim/plugged')       " plugin manager init


" ====== PLUGINS ======


Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox' 
" Soporte mejorado para yank/copy
Plug 'ojroques/vim-oscyank'
" Mejora el portapapeles entre terminal/tmux
Plug 'christoomey/vim-system-copy'
Plug 'github/copilot.vim'


call plug#end()                         " plugins section ended


" ====== GENERAL CONFIG ======


set nocompatible
filetype off
syntax on                               " Syntax highlighting.
filetype plugin indent on
set modelines=0                         " Turn off modelines
set number                              " Show lines number
set relativenumber
set cursorline
set mouse=a                             " Mouse support
set ttyfast
set scrolloff=5
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set termguicolors
colorscheme gruvbox
set background=dark

highlight Normal guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE

vnoremap <C-c> "+y


" ====== SCRIPTS ======


" Save the last session

if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Map <leader>n para abrir/cerrar NERDTree

let mapleader = " "
nnoremap <leader>n :NERDTreeToggle<CR>


" ===== GITHUB COPILOT =====


autocmd FileType markdown,text,python,js,ts,tsx,jsx,html,css,sh,zsh,rust,cpp,c Copilot enable

" Map <leader>c para activar/desactivar GitHub Copilot



