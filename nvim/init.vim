" Plugins
call plug#begin(stdpath('data') . '/plugged')
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'mattn/vim-lsp-settings'
    Plug 'morhetz/gruvbox'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'ptzz/lf.vim'
    Plug 'rbgrouleff/bclose.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'vimwiki/vimwiki'
call plug#end()

" Settings
let mapleader = ' '

let g:gruvbox_contrast_dark = 'hard'
let g:lf_replace_netrw = 1
let g:vimwiki_list = []
let g:vimwiki_list = g:vimwiki_list + [{'path': '~/Documents/Notes/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_list = g:vimwiki_list + [{'path': '~/projects/stem/docs/', 'syntax': 'markdown', 'ext': '.md'}]

set clipboard+=unnamedplus
set expandtab
set list
set listchars=eol:$,tab:-⇥,trail:~,extends:>,precedes:<
set mouse=a
set number
set relativenumber
set sts=4
set sw=4
set ts=4
set wildignore+=*\\target\\*,*\\.svn\\*,*\\.git\\*,*\\workspace\\*

" Key mappings
imap jj <Esc>
inoremap <S-Tab> <C-D>
nmap <Leader>F :split<CR>:Lf<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Lf<CR>
nmap <Leader>g :GFiles<CR>
nnoremap <S-Tab> <<_
nnoremap <Tab> >>_
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

colorscheme gruvbox
