call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

set number
autocmd VimEnter * NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeWinPos="right"

