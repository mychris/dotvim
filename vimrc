"
" ~/.vimrc
"

" Environment variables =========================================== {{{

if empty($XDG_CACHE_HOME)
  let $XDG_CACHE_HOME=expand("$HOME/.cache")
endif

" }}}

" Vundle configuration ============================================ {{{

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" plugins
Plugin 'tpope/vim-fugitive'
Plugin 'sjl/splice.vim'
Plugin 'rking/ag.vim'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'vim-scripts/Gundo'
Plugin 'vim-scripts/LustyJuggler'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'ciaranm/securemodelines'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-surround'
Plugin 'benmills/vimux'
Plugin 'majutsushi/tagbar'

" language plugins
Plugin 'rust-lang/rust.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'dag/vim-fish'
Plugin 'fatih/vim-go'
Plugin 'alisdair/vim-armasm'

" filetype plugins
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'vim-scripts/Markdown'
Plugin 'kurayama/systemd-vim-syntax'
Plugin 'mychris/vim-fstab'
Plugin 'jjrdn/vim-help'
Plugin 'vim-scripts/vim-json-bundle'
Plugin 'zeis/vim-kolor'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'cespare/vim-toml'
Plugin 'tfnico/vim-gradle'

call vundle#end()
filetype plugin indent on

" }}}

" General ========================================================= {{{

set encoding=utf-8
set showcmd
set showmode
set ttyfast
set ruler
set history=500
set laststatus=2
set autoindent
set hidden
set backspace=indent,eol,start
set visualbell

set notimeout
set ttimeout
set ttimeoutlen=10

set synmaxcol=600

set scrolloff=3
set sidescroll=1
set sidescrolloff=10

"set showbreak=↪

set cmdheight=2

set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

" disable modeline, use SecureModelines
set modelines=0
set nomodeline

" Autosave on focus lost
au FocusLost * silent! wa

" Resize on window resize
au VimResized * :wincmd =

" please, fix my typos!
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang E e<bang>

command! -bang Qa qa<bang>
command! -bang QA qa<bang>

command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" }}}

" Cursor Line ===================================================== {{{

" Only show cursorline in current win
augroup cursor_line
  au!
  au WinLeave,InsertEnter * set nocursorline
  au WinEnter,InsertLeave * set cursorline
augroup END

set cursorline

" }}}

" Line numbers ==================================================== {{{

augroup line_numbers
  au!
  au FocusGained,WinEnter,InsertLeave * call SaveRelative()
  au FocusLost,WinLeave,InsertEnter * call SaveNumber()
augroup END
set relativenumber

function! SaveRelative()
    if &number || &relativenumber
        set relativenumber
    endif
endfunction

function! SaveNumber()
    if &number || &relativenumber
        set number
    endif
endfunction

function! SaveToggleNumber()
    if &number || &relativenumber
        if &number
            set relativenumber
        elseif &relativenumber
            set number
        endif
    endif
endfunction

" }}}

" Line Return ===================================================== {{{

" Make sure Vim returns to the same line when you reopen a file.
" https://github.com/sjl/dotfiles/blob/master/vim/vimrc
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END

"}}}

" Whitespace, wrapping stuff ====================================== {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" long lines
set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=81

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:␣

augroup show_list
  au!
  au InsertEnter * set list
  au InsertLeave * set nolist
augroup END

" }}}

" Leader ========================================================== {{{

let mapleader = ","
let maplocalleader = "\\"

" }}}

" Basic Keybindings =============================================== {{{

nnoremap M K

nnoremap ; :
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"no need any more, use capslock, remap in X11
"inoremap jk <ESC>

" Don't move cursor!
nnoremap J mzJ`z

" surround with whitespace
map <leader><SPACE> ysiw(ds)
" surround with "
map <leader>" ysiw"

" save
nnoremap <leader>s :w!<CR>

" hex
nnoremap <Leader>hon :%!xxd<CR>
nnoremap <Leader>hof :%!xxd -r<CR>

" }}}

" Movement ======================================================== {{{

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <PageUp> <nop>
nnoremap <PageDown> <nop>
nnoremap <Home> <nop>
nnoremap <End> <nop>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <PageUp> <nop>
inoremap <PageDown> <nop>
inoremap <Home> <nop>
inoremap <End> <nop>

noremap j gj
noremap k gk
noremap gj j
noremap gk k

noremap H ^
noremap L $
vnoremap L g_

" center
nnoremap g, g,zz
nnoremap g; g;zz

" }}}

" Searching ======================================================= {{{

set incsearch
set ignorecase
set smartcase
set showmatch
set hlsearch
set gdefault

nnoremap / /\v
vnoremap / /\v

nnoremap <silent> <leader>, :noh<CR>

" Keep search in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" don't move!
nnoremap * *<C-o>

" search files for word under cursor
nnoremap <C-f> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
nnoremap <leader>k :cn<CR>
nnoremap <leader>j :cp<CR>

" }}}

" Windows =================================================== {{{

nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>w <C-w>s<C-w>j

nmap <left> :3wincmd <<CR>
nmap <right> :3wincmd ><CR>
nmap <up> :3wincmd +<CR>
nmap <down> :3wincmd -<CR>

nmap <C-left> :wincmd h<CR>
nmap <C-right> :wincmd l<CR>
nmap <C-up> :wincmd k<CR>
nmap <C-down> :wincmd j<CR>

nmap <S-left> <C-w>H
nmap <S-right> <C-w>L
nmap <S-up> <C-w>K
nmap <S-down> <C-w>j

" }}}

" Quickfix ======================================================== {{{

" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
nmap <silent><leader>q :QFix<CR>

" }}}

" Backups ========================================================= {{{

set backup
set backupext=.bak
set noswapfile
set undofile
set undoreload=10000

set viminfo+=n$XDG_CACHE_HOME/vim/viminfo

set undodir=$XDG_CACHE_HOME/vim/undofiles
set backupdir=$XDG_CACHE_HOME/vim/backup
set directory=$XDG_CACHE_HOME/vim
set viewdir=$XDG_CACHE_HOME/vim/viewfiles

" create directories
if !isdirectory(&undodir)
  call mkdir(&undodir, "p")
endif
if !isdirectory(&backupdir)
  call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
  call mkdir(&directory, "p")
endif
if !isdirectory(&viewdir)
  call mkdir(&viewdir, "p")
endif

" }}}

" Colors / Font / Statusline ====================================== {{{

syntax on

if has("gui_running")
"  colorscheme zenburn
  colorscheme kolor
  set guifont=Hack\ 10
else
  colorscheme railscasts
"  colorscheme kolor
endif

hi User1 guifg=#eea040 guibg=#303030 ctermfg=172 ctermbg=236
hi User2 guifg=#dd3333 guibg=#303030 ctermfg=196 ctermbg=236
hi User3 guifg=#4682b4 guibg=#303030 ctermfg=12 ctermbg=236
hi User4 guifg=#a0ee40 guibg=#303030 ctermfg=70 ctermbg=236
hi User5 guifg=#eeee40 guibg=#303030 ctermfg=184 ctermbg=236

set statusline=
set statusline +=%1*\ %n\ %*                          "buffer number
set statusline +=%5*%{&ff}%*                          "file format
set statusline +=%1*\ (%{strlen(&fenc)?&fenc:'none'}) "file encoding
set statusline +=%3*\ %y%*                            "file type
set statusline +=%4*\ %<%F%*                          "full path
set statusline +=%2*%m%*                              "modified flag
set statusline +=%1*%=%5l%*                           "current line
set statusline +=%2*/%L%*                             "total lines
set statusline +=%1*%4v\ %*                           "virtual column number
set statusline +=%2*0x%04B\ %*                        "character under cursor

" }}}

" Folding ========================================================= {{{

set foldlevelstart=99

" toggle folds
nnoremap <silent> <Space> za
vnoremap <silent> <Space> za

" close all
nnoremap ZC zC
vnoremap ZC zC

" open all
nnoremap ZM zM
vnoremap ZM zM

" toggle recursive
nnoremap ZA zA
vnoremap ZA zA

" save and reload folds
au BufWinLeave * mkview
au BufWinEnter * silent loadview

set viewoptions=folds,cursor

" }}}

" Wildmenu ======================================================== {{{

set wildmenu
set wildmode=list:longest

set wildignore+=*.aux,*.out,*.toc,*.bbl             " latex
set wildignore+=*.pyc                               " python

" }}}

" Abbreviations =================================================== {{{

" }}}

" Filetype stuff ================================================== {{{

" c {{{
augroup ft_c
  au!
  au FileType c setlocal ts=4 sts=4 shiftwidth=4 noet tw=120 cc=121
  au FileType c setlocal foldmethod=syntax
augroup END
" }}}
" cpp {{{
augroup ft_cpp
  au!
  au FileType cpp setlocal ts=4 sts=4 shiftwidth=4 noet tw=120 cc=121
  au FileType cpp setlocal foldmethod=syntax
augroup END
" }}}
" armasm {{{
augroup ft_armasm
  au!
  au FileType armasm let g:syntastic_asm_compiler="arm-none-eabi-gcc"
augroup END
" }}}
" go {{{
augroup ft_go
  au!
  au FileType go setlocal ts=8 sts=8 sw=8 tw=120 cc=121 noet
  au FileType go setlocal foldmethod=syntax
  au FileType go nnoremap <C-F> :GoFmt<CR>
  au FileType go noremap <C-F5> :GoTest<CR>
augroup END
" }}}
" python {{{
augroup ft_python
  au!
  au FileType python setlocal ts=4 sts=4 shiftwidth=4
  au FileType python setlocal foldmethod=indent foldlevel=99
  au FileType python setlocal ofu=pythoncomplete#Complete cot=menuone,longest
augroup END
" }}}
" ruby {{{
augroup ft_ruby
  au!
  au FileType ruby setlocal ts=2 sts=2 shiftwidth=2
augroup END
" }}}
" javascript {{{
augroup ft_javascript
  au!
  au FileType javascript setlocal ts=2 sts=2 shiftwidth=2 expandtab
augroup END
" }}}
" Version control {{{
augroup ft_commit
  au!
  au FileType svn,*commit* setlocal spell spelllang=en
augroup END
" }}}
" vim {{{
augroup ft_vim
  au!
  au FileType vim setlocal foldmethod=marker foldmarker={{{,}}}
augroup END
" }}}
" mail {{{
augroup ft_mail
  au!
  au FileType mail setlocal spell spelllang=en,de
augroup END
" }}}
" tex {{{
augroup ft_tex
  au!
  let g:tex_flavor='latex'
  au FileType tex setlocal spell spelllang=de,en foldmethod=manual
  au FileType tex setlocal tw=120 cc=121
augroup END
" }}}
" bashrc {{{
augroup ft_bashrc
  au!
  au FileType bashrc setlocal syntax=sh foldmethod=marker foldmarker={{{,}}}
augroup END
" }}}
" zsh {{{
augroup ft_zsh
  au!
  au FileType zsh setlocal syntax=sh foldmethod=marker foldmarker={{{,}}}
augroup END
" }}}
" conf {{{
augroup ft_conf
  au!
  au FileType conf setlocal foldmethod=marker foldmarker={{{,}}}
augroup END
" }}}
" i3 {{{
augroup ft_i3
  au!
  au FileType i3 setlocal foldmethod=marker foldmarker={{{,}}}
augroup END
" }}}
" xdefaults {{{
augroup ft_xdefaults
  au!
  au FileType xdefaults setlocal foldmethod=marker foldmarker={{{,}}}
augroup END
" }}}
" sml {{{
augroup ft_sml
  au!
  au FileType sml setlocal textwidth=120 colorcolumn=121
augroup END
" }}}
" fstab {{{
augroup ft_fstab
  au!
  au FileType fstab setlocal colorcolumn=0
augroup END
" }}}
" sh {{{
augroup ft_sh
  au!
  au FileType sh setlocal syntax=sh foldmethod=marker foldmarker={{{,}}}
augroup END
" }}}
" }}}

" Plugins ========================================================= {{{

" SecureModelines {{{
" https://github.com/ciaranm/securemodelines
let g:secure_modelines_verbose = 1
let g:secure_modelines_modelines = 5
let g:secure_modelines_allowed_items = [
  \"textwidth", "tw",
  \"softtabstop", "sts",
  \"tabstop", "ts",
  \"shiftwidth", "sw",
  \"expandtab", "et",
  \"noexpandtab", "noet",
  \"autoindent", "ai",
  \"noautoindent", "noai",
  \"filetype", "ft",
  \"fileformat", "ff",
  \"fold", "fo",
  \"rightleft", "rl",
  \"norightleft", "norl",
  \"foldmethod", "fdm",
  \"colorcolumn", "cc",
  \"fileencoding", "fenc"
  \]
" }}}

" Command-T {{{
" https://github.com/wincent/Command-T
nnoremap <leader>t :CommandT<CR>

" Max height of window
let g:CommandTMaxHeight=80
" Min height of window
let g:CommandTMinHeight=5
" Never scan into dot directories
let g:CommandTScanDotDirectories=0
" }}}

" NERDTree {{{
" https://github.com/scrooloose/nerdtree
noremap <F2> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
inoremap <F2> <ESC>:NERDTreeToggle<CR>:NERDTreeMirror<CR>

let NERDTreeShowBookmarks = 1
let NERDTreeIgnore = ['\.pyc', '\~$', '\.swo$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode = 2
let NERDTreeQuitOnOpen = 0
let NERDTreeShowHidden = 0
let NERDTreeKeepTreeInNewTab = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeMinimalUI = 0
let NERDTreeShowLineNumbers = 0

" start NERDTree automatically when vim starts and no file is specified
augroup nerd_tree
  au!
  au VimEnter * if !argc() | NERDTree | endif
  au BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END
" }}}

" Tagbar {{{
" https://github.com/majutsushi/tagbar
noremap <F3> :TagbarToggle<CR>
inoremap <F3> <ESC>:TagbarToggle<CR>
" }}}

" Gundo {{{
" https://github.com/sjl/gundo.vim
noremap <F4> :GundoToggle<CR>
inoremap <F4> <ESC>:GundoToggle<CR>

" width of the graph
let g:gundo_width = 45
" height of the preview window
let g:gundo_preview_height = 20
" show preview window below current window, not below the graph
let g:gundo_preview_bottom = 1
" }}}

" LustyJuggler {{{
" https://github.com/vim-scripts/LustyJuggler
nnoremap <leader>b :LustyJuggler<CR>
" }}}

" syntastic {{{
" https://github.com/scrooloose/syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_python_checker_args = ""
" }}}

" Scratch {{{
" https://github.com/vim-scripts/scratch.vim
nnoremap <leader><Tab> :Scratch<CR>
" }}}

" SuperTab {{{
" https://github.com/ervandew/supertab
let g:SuperTabDefaultCompletionType = "context"
" }}}

" Ack {{{
" https://github.com/mileszs/ack.vim
nnoremap <leader>a :NERDTreeClose<CR>:Ack <cword><CR>
" }}}

" }}}

" Quick file editing ============================================== {{{

nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>ex :vsplit ~/.xinitrc<cr>
nnoremap <leader>eb :vsplit ~/.bashrc<cr>
nnoremap <leader>eg :vsplit ~/.gitconfig<cr>
nnoremap <leader>ei :vsplit ~/.i3/config<cr>

" }}}

" vim: set ft=vim softtabstop=2 tabstop=2 shiftwidth=2 expandtab:
