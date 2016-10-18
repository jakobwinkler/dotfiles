" I don't think this does anything for recent vim (or neovim)
set nocompatible

"
" plugin managers (actually, vundle)
"

filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'                  " plugin manager
Plugin 'scrooloose/nerdtree'                " ctrl-e opens explorer
Plugin 'Valloric/YouCompleteMe'             " c/++ clang completion
Plugin 'derekwyatt/vim-fswitch'             " f8 toggles between .h/.c(pp)
Plugin 'derekwyatt/vim-protodef'            " <Leader>PP implements functions from header
Plugin 'SirVer/ultisnips'                   " snippets engine (tab toggles)
Plugin 'honza/vim-snippets'                 " snippets files for ^
Plugin 'kien/ctrlp.vim'                     " ctrl-p fuzzy file finder
Plugin 'altercation/vim-colors-solarized'   " color scheme, duh.
Plugin 'tpope/vim-fugitive'                 " git plugin (use <Leader>-g-something
Plugin 'myusuf3/numbers.vim'                " relative/absolute line numbers combined
Plugin 'bling/vim-airline'                  " status line at the bottom <3 (needs powerline fonts)
Plugin 'lervag/vimtex'                      " tex compilation/folding
Plugin 'flazz/vim-colorschemes'             " more colors
Plugin 'tpope/vim-markdown'                 " markdown support
Plugin 'scrooloose/syntastic'               " linting and auto-compiling (in use with vcom for vhdl)
Plugin 'ervandew/supertab'                  " used for syntastic
Plugin 'mhinz/vim-startify'                 " splash screen :)
Plugin 'wikitopian/hardmode'                " disable hjkl, arrow keys

call vundle#end()

" hard mode.
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

"
" Configuration for YouCompleteMe. The extra_conf file sets compiler flags
" (mainly for c++11 and include paths for my usual directory/project structure
"
let g:ycm_global_ycm_extra_conf = '/home/erpfi/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" 'better' (more IDE-like) key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"
" syntastic error display settings
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" syntax checking config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" checkers to use
let g:syntastic_vhdl_checkers = ['vcom']
let g:tlist_vhdl_settings   = 'vhdl;d:package declarations;b:package bodies;e:entities;a:architecture specifications;t:type declarations;p:processes;f:functions;r:procedures'

"
" ctrlp
"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" gcc output
set wildignore+=*.o
" vcom output
set wildignore+=_info
set wildignore+=_vmake
set wildignore+=*.qdb
set wildignore+=*.qtl
set wildignore+=*.qpg

" don't show line numbers where it doesn't make sense (nerdtree, shells, …)
let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'nerdtree']

let g:airline_powerline_fonts = 1
set laststatus=2

"
" general settings
"

filetype plugin indent on
syntax on
" I'm a spaces kinda guy
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set shiftround
set autoindent
set smartindent

" I hate those backup files that never seem to get deleted
set nobackup
set nowritebackup
set noswapfile

set hidden
set autoread

" search settings
set ignorecase
set smartcase
set incsearch
set showmatch
set nohlsearch
set gdefault

" Some rarer settings - explained by yours truly
set showmode                    " Display the current mode
set cursorline                  " Highlight current line

set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight 'problematic' whitespace

map <Space> <Leader>            " The leader key is used in some shortcuts and is ',' by default which sucks
set showcmd                     " Shows commands I'm hitting in the bottom right

set virtualedit+=block

" If my terminal is super dumb, suggest colors
set t_Co=256
set background=dark

"
" word delimiters stolen from spf (for w, b, e, ...)
"
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])


" Fugitive {
if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    " Mnemonic _i_nteractive
    nnoremap <silent> <leader>gi :Git add -p %<CR>
    nnoremap <silent> <leader>gg :SignifyToggle<CR>
endif
"}


"
" Keymaps
"

" I'm a strong independent programmer who don't need no help
" Also, I always hit F1 when I want to Esc
map <F1> <Nop>
map! <F1> <Nop>

" File switch and nerd tree
map <C-e> :NERDTreeToggle<CR>
map <F9> :FSHere<CR>

" use ntrd to switch splits (I use the neo keyboard layout)
nmap <silent> <C-t> :wincmd k<CR>
nmap <silent> <C-r> :wincmd j<CR>
nmap <silent> <C-n> :wincmd h<CR>
nmap <silent> <C-d> :wincmd l<CR>

" indent all and go back to original position
map <F8> mzgg=G`z

" jump: definition using ycm
nnoremap <leader>jd :YcmCompleter GoTo<CR>

" compile/run without debugging
map <F5> :make<CR>:make run<CR>
map <F6> :make clean<CR>

if has('nvim')
    " use ctrl-escape to get out of terminal programs
    tnoremap <C-Esc> <C-\><C-n>

    " nvim-uber-debugging.
    " terminal allows fancy interactive debugging and pretty colors
    map <F5> :wa<CR>:terminal make && ./bin/out<CR>

    " f29 is ctrl-f5
    map <F29> :wa<CR>:terminal make && cgdb ./bin/out<CR>
    map <F6> :terminal make clean<CR>
    map <F7> :terminal make && valgrind ./bin/out<CR>
endif
