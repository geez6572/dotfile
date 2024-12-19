" vimrc for other the vim plugin of other ide
" only contain some key mapping and some basic setting




"================== custome setting =======================
set autochdir
set exrc
set secure


let mapleader=" "
syntax on
set number
"set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu 
set hlsearch
exec "nohlsearch"
set ignorecase
set cursorline
set scrolloff=4

"jump the cursor to the last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
"silent !mkdir -p $HOME/.config/nvim/tmp/sessions
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.

" set vim using system clipboard
set clipboard=unnamedplus

"nvim快捷键的绑定设置


"将nvim普通模式下的光标移动 h,j,k,l 改成：
"     ^
"     i
" < j   l >
"     k
"     v
noremap i k
noremap k j
noremap j h

"i键原来已经使用，需要将他绑定到其快捷键上
noremap h i
noremap H I

noremap <LEADER><CR> :nohlsearch<CR>
noremap ; :

"================== inoremap ==============================
inoremap  jj   <esc>

map s <nop>
map S :w<CR>
map Q :q<CR>
map R :source $HOME/.config/nvim/init.vim<CR>


"split screen
map sj :set nosplitright<CR>:vsplit<CR>
map sl :set splitright<CR>:vsplit<CR>
map si :set nosplitbelow<CR>:split<CR>
map sk :set splitbelow<CR>:split<CR>

"move cursor to assign screen
map <LEADER>j <C-w>h
map <LEADER>l <C-w>l
map <LEADER>k <C-w>j
map <LEADER>i <C-w>k

"resize  screen size 
map <UP> :resize +3<CR>
map <DOWN> :resize -3<CR>
map <RIGHT> :vertical resize +5<CR>
map <LEFT> :vertical resize -5<CR>

"open new tab and move tab
map te :tabedit<CR>
map tj :-tabnext<CR>
map tl :+tabnext<CR>

"switch screen layout  bwtween split and vsplit
map sv <C-w>t<C-w>H
map sh <C-w>t<C-w>K

