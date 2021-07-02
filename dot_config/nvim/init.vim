"*************************************
"*  _       _ _         _            *
"* (_)_ __ (_) |___   _(_)_ __ ___   *
"* | | '_ \| | __\ \ / / | '_ ` _ \  *
"* | | | | | | |_ \ V /| | | | | | | *
"* |_|_| |_|_|\__(_)_/ |_|_| |_| |_| *
"*                                   *
"*************************************

let mapleader = ","

" Install the vim-plug if is not present
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
"Plug 'junegunn/goyo.vim'
Plug 'scrooloose/nerdtree'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'vifm/vifm.vim'
Plug 'mileszs/ack.vim'

"Plug 'jeetsukumaran/vim-buffergator'
Plug 'Shougo/denite.nvim'
Plug 'dracula/vim', { 'as': 'dracula' }  " template

" add support for unicode chars
Plug 'chrisbra/unicode.vim'

" COC = Conquer Of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Browser in VIM
Plug 'yuratomo/w3m.vim'

" Dart syntax plugin
Plug 'dart-lang/dart-vim-plugin'

call plug#end()

set bg=light
set go=a
set mouse=a
set scrolloff=999  " keeps the cursor vertically allined
set nohlsearch
set clipboard=unnamedplus
set noswapfile
set autowrite "save buffers automatically when switching

" Tabs as a ninja
set tabstop=4
set shiftwidth=4
set expandtab

map <F2> :NERDTreeToggle<CR>
"map <F4> :BuffergatorToggle<CR>
map <leader>r :echo "reloading vimrc..."<CR>:so $MYVIMRC<CR>

" nice navigation
map <a-h> :bp<cr>
map <a-l> :bn<cr>
map <a-H> :bfirst<cr>
map <a-L> :blast<cr>
map <a-x> :bdelete<cr>

" use the clipboard 
noremap <leader>y "+y
noremap <leader>Y "+Y
noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>q :bdelete<CR>

" Some basics:
nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
vnoremap <C-c> "+y
map <C-p> "+P

" vim-airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

" Save the file as sudo
cmap w!! w !sudo tee > /dev/null %

" COC configuration

" Correct comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

" User tab and shift tab to navigate the completation
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" User CR to confirm the completation
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

try
" ==== Denite ====
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Open file commands
call denite#custom#map('insert,normal', "<C-t>", '<denite:do_action:tabopen>')
call denite#custom#map('insert,normal', "<C-v>", '<denite:do_action:vsplit>')
call denite#custom#map('insert,normal', "<C-h>", '<denite:do_action:split>')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
    \ 'split': 'floating',
    \ 'start_filter': 1,
    \ 'auto_resize': 1,
    \ 'source_names': 'short',
    \ 'prompt': 'λ:',
    \ 'statusline': 0,
    \ 'highlight_matched_char': 'WildMenu',
    \ 'highlight_matched_range': 'Visual',
    \ 'highlight_window_background': 'Visual',
    \ 'highlight_filter_background': 'StatusLine',
    \ 'highlight_prompt': 'StatusLine',
    \ 'winrow': 1,
    \ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" === Coc.nvim === "
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" === NERDTree === "
" Show hidden files/directories
let g:NERDTreeShowHidden = 0

" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1

" Custom icons for expandable/expanded directories
let g:NERDTreeDirArrowExpandable = '⬏'
let g:NERDTreeDirArrowCollapsible = '⬎'

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" === Vim airline ==== "
" Enable extensions
try
    "let g:airline_extensions = ['branch', 'coc']

    " Update section z to just have line number
    "let g:airline_section_z = airline#section#create(['linenr'])

    " Do not draw separators for empty sections (only for the active window) >
    "let g:airline_skip_empty_sections = 1

    " Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
    "let g:airline#extensions#tabline#formatter = 'unique_tail'

    " Custom setup that removes filetype/whitespace from default vim airline bar
    " let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

    let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'

    let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

    " Configure error/warning section to use coc.nvim
    "let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
    "let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

    " Hide the Nerdtree status line to avoid clutter
    "let g:NERDTreeStatusline = ''

    " Disable vim-airline in preview mode
    "let g:airline_exclude_preview = 1

    " Enable powerline fonts
    let g:airline_powerline_fonts = 1

    " Enable caching of syntax highlighting groups
   " let g:airline_highlighting_cache = 1

    " Define custom airline symbols
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif

    " Don't show git changes to current file in airline
    " let g:airline#extensions#hunks#enabled=0

    catch
      echo 'Airline not installed. It should work after running :PlugInstall'
endtry

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Enable true color support
set termguicolors

"Editor theme
set background=light

try
    colorscheme dracula
catch
    colorscheme desert
endtry

" Vim airline theme
let g:airline_theme='wombat'

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom
set splitbelow

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" Set floating window to be slightly transparent
set winbl=10

" coc.nvim color changes
hi! link CocErrorSign WarningMsg
hi! link CocWarningSign Number
hi! link CocInfoSign Type

" Try to hide vertical spit and end of buffer symbol
hi! VertSplit gui=NONE guifg=#17252c guibg=#17252c
hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=#17252c guifg=#17252c

" Customize NERDTree directory
hi! NERDTreeCWD guifg=#99c794

" ============= Bash
augroup filetype_bash
    autocmd!
    autocmd FileType sh nnoremap <F5> :w !sh<CR>
    au FileType sh let g:sh_fold_enabled=5
    au FileType sh let g:is_bash=1
    au FileType sh set foldmethod=syntax
augroup END
"
" ============= END

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Tab>
  \ denite#do_map('open_filter_buffer')
endfunction

" === Nerdtree shorcuts === "
"  <leader>n - Toggle NERDTree on/off
"  <leader>f - Opens current file location in NERDTree
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

"   <Space> - PageDown
"   -       - PageUp
noremap <Space> <PageDown>
noremap - <PageUp>

" === coc.nvim === "
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

" === vim-better-whitespace === "
"   <leader>y - Automatically remove trailing whitespace
"nmap <leader>y :StripWhitespace<CR>

" === Search shorcuts === "
"   <leader>h - Find and replace
"   <leader>/ - Claer highlighted search terms while preserving history
map <leader>h :%s///<left><left>
nmap <silent> <leader>/ :nohlsearch<CR>

nnoremap <leader>e :badd $HOME/.config/nvim/init.vim<CR>

" ACK
"
"
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" ============================================================================ "
" ===                                 LANG.                                === "
" ============================================================================ "
" automatic Dart file type detection
au BufRead,BufNewFile *.dart set filetype=dart


" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automatically re-read file if a change was detected outside of vim
set autoread

" Enable line numbers
set number
