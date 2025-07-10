set encoding=UTF-8

call plug#begin('~/.vim/plugged')

" Add colors to parentheses, brackets, etc
Plug 'luochen1990/rainbow'

" :Cppman <search term>
Plug 'gauteh/vim-cppman'

" Copilot-like using local LLM model
" Plug 'ggml-org/llama.vim'

" Use Copilot on a slow machine
Plug 'github/copilot.vim'

" Once activated with :AnyFoldActivate, use zo, zO, zc, za to fold/unfold
" :set foldlevel=0 to close all folds
" :set foldlevel=99 to open all folds
Plug 'pseewald/vim-anyfold'

" gS - split long line
" gJ - join short lines
Plug 'AndrewRadev/splitjoin.vim'

Plug 'liuchengxu/vim-which-key'

" ctags plugin
" Outline view of the current file
" :TagbarToggle
Plug 'majutsushi/tagbar'

" Use % to jump between matching text
Plug 'andymass/vim-matchup'

" Underline word under cursor
Plug 'dominikduda/vim_current_word'

" Useful when working with markdown table. eg :Tabularize /|
Plug 'godlygeek/tabular'

" Reopen files at your last edit position in Vim
Plug 'vladdoster/remember.nvim'

" smooth scrolling
Plug 'psliwka/vim-smoothie'

" Align text
Plug 'junegunn/vim-easy-align'

" vim for writers
Plug 'Ron89/thesaurus_query.vim'
Plug 'preservim/vim-litecorrect'
Plug 'preservim/vim-wordy'             ":Wordy weak

" Required by clojure code formatter - cljstyle
" Plug 'google/vim-maktaba'
" Plug 'google/vim-codefmt'

" Highlight whitespace
Plug 'ntpeters/vim-better-whitespace'

" Easy navigation with <leader><leader>w
Plug 'easymotion/vim-easymotion'

" Latex preview
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" {{{
" Clojure plugins
"
" clojure REPL integration
Plug 'Olical/conjure', {'tag': 'v3.3.0'}
" starts clojure REPL with :Lein
Plug 'clojure-vim/vim-jack-in'
Plug 'tpope/vim-dispatch'
" clojure paredit, required both below
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
" }}}

" Run any arbitrary git command
Plug 'tpope/vim-fugitive'               " Git blame

" Project-wide search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Linter/formatter
Plug 'dense-analysis/ale'

" Theme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" 1. Highlight
" 2. ctrl-n
" 3. Press c
" 4. Type the new text
Plug 'mg979/vim-visual-multi'             " multiple cursors editing

Plug 'christoomey/vim-tmux-navigator'     " navigate between windows
Plug 'Yggdroot/indentLine'                " show indent character
" Code comment ie highlight text then type gc
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'                 " add surrounding characters
Plug 'sheerun/vim-polyglot'               " syntax hightlighting
" Plug 'airblade/vim-gitgutter'             " display git hunk in gutter
Plug 'editorconfig/editorconfig-vim'      " respect .editorconfig

" NerdTree is used as project browser
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Workaround https://github.com/tiagofumo/vim-nerdtree-syntax-highlight/issues/53
Plug 'johnstef99/vim-nerdtree-syntax-highlight'

" Status line plugin
Plug 'itchyny/lightline.vim'
" Show git branch on lightline
Plug 'itchyny/vim-gitbranch'

" Enhance vim tab
Plug 'gcmt/taboo.vim'

" Window resizer using ctrl-e
Plug 'simeji/winresizer'

" Open a file with a specific line
" vim index.html:20
Plug 'bogado/file-line'

" Highlight JSON
Plug 'neoclide/jsonc.vim'

" File icons for Nerd Tree
Plug 'ryanoasis/vim-devicons'

call plug#end()

" NerdTree showing brackets so better to disable rainbow OOTB
let g:rainbow_active = 0 "set to 0 if you want to enable it later via :RainbowToggle

" Enable outline view with tagbar plugin
nmap <F7> :TagbarToggle<CR>

" Change highlighted text with spaces to dashes and run noh
vnoremap <Leader>h :s/ /-/g<CR>:noh<CR>

" Disable inline info
let g:llama_config = { 'show_info': 0 }

" coc-snippets {{{
"
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
" }}}

" coc-ansible
" set filetype for yml to yaml.ansible
" TODO: temporary disable
" autocmd BufRead,BufNewFile *.yml set filetype=yaml.ansible
" let g:coc_filetype_map = {
"   \ 'yaml.ansible': 'ansible',
"   \ }

" Set filetype for JSON to use jsonc
autocmd BufRead,BufNewFile *.json set filetype=jsonc

" nvim setup where you can't choose the flavour
" absolutepath - shows full path
" filename - shows only the filename
" https://github.com/itchyny/lightline.vim/issues/293
let g:lightline = {
      \ 'colorscheme': 'catppuccin',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'filename': 'LightlineFilename',
      \ },
      \ }
function! LightlineFilename()
    let root = fnamemodify(get(b:, 'gitbranch_path'), ':h:h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" Disable right button click popup-menu to avoid hyper terminal popup-menu
set mouse=

" emoji
" CocInstall coc-emoji markdown
set completefunc=emoji#complete

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Remove visual prefilled '<'> with ctrl-u
" vnoremap <silent> <leader>g :<C-U>Gpt3<cr>

" Lightweight auto-correction for Vim
augroup litecorrect
  autocmd!
  autocmd FileType markdown,mkd call litecorrect#init()
  autocmd FileType textile      call litecorrect#init()
  autocmd FileType text         call litecorrect#init()
augroup END

" Synonym using Ron89/thesaurus_query.vim
nnoremap <Leader>t :ThesaurusQueryReplaceCurrentWord<CR>

" Use :FormatLines to format a range of lines or use :FormatCode to format the
" entire buffer
" TODO: disabled for now, because it's shifting code around with ESC-j
" autocmd FileType clojure AutoFormatBuffer cljstyle

" vim-latex-live-preview plugin
" Use MacOS Preview as pdf viewer. Preview only updates if in focus :P
let g:livepreview_previewer='open -a Preview'
autocmd Filetype tex setl updatetime=1
" :Tex to launch Preview
command Tex LLPStartPreview

" Alias AnyFold
command AnyFold AnyFoldActivate
" There's also coc.nvim :Fold

" Alias Tagbar
command Tagbar TagbarToggle

" Markmap preview alias
" :CocInstall coc-markmap
command! Mm CocCommand markmap.watch

" F5 to launch chrome
nnoremap <F5> :w <Bar> !open -a "Google Chrome" %<CR>

" Don't save hidden, unloaded buffers or empty windows
set sessionoptions="curdir,folds,help,options,tabpages,winsize"

" Basic {{{
set ignorecase                 " search case insensitive

set cursorline                 " highlight current line

set nocompatible
filetype plugin on             " turn on filetype plugins

set noswapfile                 " no swapfile

let mapleader="\\"             " explicitely map \ as leader key. There's a
                               " 1000ms delay when a leader key is pressed
                               " so choose a key you're not likely to use
                               " often.

" Wrap Markdown files to 80 characters
" Manual wrap - select text, then gq
au BufRead,BufNewFile *.md setlocal textwidth=80

" File explorer navigation helper
set wildmode=full
" }}}

" Visual {{{
" Always show line numbers unless otherwise specified
set number
set numberwidth=5              " space width for the numbers
let g:indentLine_char = '|'    " show indent character

" JetBrains Mono and Fira Code support ligatures
set guifont=JetBrains\ Mono\ NF:15
" set guifont=Fira\ Code:15

" Show column line
set colorcolumn=80

" Show key pressed
set showcmd

" Don't show extra -- INSERT -- below lightline
set noshowmode
" }}}

" Writing essentials  {{{
set dictionary=/usr/share/dict/words " use dictionary for word completion

" http://www.gutenberg.org/files/3202/files/mthesaur.txt
" Invoke thesaurus in insert mode: <ctrl-x>Ctrl-t>
set thesaurus+="$HOME/thesaurus/mthesaur.txt"
" }}}

" Disable vim-markdown conceal for code blocks only
" https://github.com/plasticboy/vim-markdown#options
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" Navigation {{{

" Use home keys to jump between start and end of line
map H ^
map L $

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" }}}

" Disable pageup/pagedown
nnoremap <PageUp> <nop>
nnoremap <PageDown> <nop>

" Copy to system clipboard
vmap <leader>c :w !pbcopy<cr><cr>

" Plugins {{{

" Use ALE linters because these are not supported by coc.nvim extensions
let g:ale_sign_column_always = 1
let g:ale_lint_on_enter = 0                    " don't lint on open file
let g:ale_lint_on_text_changed = 'never'
" Disable (set to 0) since it's affecting inlay hint on save
let g:ale_lint_on_save = 0

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_linters               = {}
let g:ale_linters['c']          = ['cppcheck']
" Disable cspell
let g:ale_linters['markdown']   = ['vale']
let g:ale_linters['terraform']  = ['tflint', 'tfsec']
let g:ale_linters['ansible']    = ['ansible_lint']
let g:ale_linters['perl']       = ['perlcritic']
let g:ale_linters['go']         = ['golangci-lint', 'govet']
let g:ale_linters['text']       = ['proselint']
let g:ale_linters['dockerfile'] = ['hadolint']
let g:ale_linters['html']       = ['htmlhint']
" let g:ale_linters['yaml']     = ['yamllint']

" Code formaters
let g:ale_fixers               = {}
let g:ale_fixers['*']          = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers['c']          = ['clang-format']
let g:ale_fixers['cpp']        = ['clang-format']
let g:ale_fixers['go']         = ['gofmt', 'goimports']
let g:ale_fixers['rust']       = ['rustfmt']
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['perl']       = ['perltidy']
" pipx install the tools
let g:ale_fixers['python']     = ['black', 'ruff', 'autopep8']
let g:ale_fixers['sh']         = ['shfmt']
let g:ale_fixers['lua']        = ['stylua']
let g:ale_fixers['ruby']       = ['rubocop']
let g:ale_fixers['markdown']   = ['prettier']
let g:ale_fixers['yaml']       = ['prettier']

nnoremap <leader>ff :ALEFix<CR>            " run formatter
" }}}

" Color theme, type :Colors to change theme for the session
colorscheme catppuccin-macchiato

" https://github.com/ambv/.dot_files/blob/master/vimrc
"
set title "change the terminal title according to the currently active buffer
set incsearch "start searching while typing
" highlight current column
" set cursorcolumn

" Preview markdown in a browser
" User-defined alias Md
command Md MarkdownPreview

" Format JSON with jq
nnoremap <leader>jq :%!jq '.'<CR>

" Enable spelling check for Markdown
autocmd BufRead,BufNewFile *.md setlocal spell

" F8 to toggle spell check
" noremap <F8> :setlocal spelllang=en_us spell! spell?<CR>

" ]s to jump between spell mistakes
" 1z= to fix under cursor error
setlocal spell
set spelllang=en_gb
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
" }}}

" fzf {{{
" search word under cursor
nnoremap <silent><leader>/ :Rg <C-R>=expand("<cword>")<CR><CR>

" Customize Files and GFiles using 'bat' for syntax hightlighting in preview
" window
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

" ctrl-a to select all, ctrl-d to deselect all
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
\   {'options': fzf#vim#with_preview()["options"] + ['--bind', 'ctrl-a:select-all,ctrl-d:deselect-all']}, <bang>0)

" git grep search
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" Path completion in insert mode
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" Word completion in insert mode with custom spec with popup layout option
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
" }}}

" vim-better-whitespace {{{
" Strip trailing whitespace
nnoremap <leader>rw :StripWhitespace<CR>
" }}}

" File save
" TODO: won't work when working with ocaml-lsp
nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr>
" }}}

" ocaml switch
set rtp^="$HOME/.opam/cs3110-2022fa/share/ocp-indent/vim"

" Quit without saving
nnoremap <leader>q :qa!<cr>
inoremap <leader>q <C-c>:qa!<cr>
" }}}

" Select all
nnoremap <C-a> ggVG
" }}}

" Window switching
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Disable since we want to redraw immediately on opening file with ligatures
" set lazyredraw                 " redraw only when needed

" File finder using fzf search for all files in folder with ctrl-p
nnoremap <C-p> :GFiles<CR>

" Opens fzf windows/tabs list with ctrl-i
nnoremap <C-i> :Windows<CR>

" coc-go - organize import on save {{{
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
" }}}

" Run :Table to format markdown tables on save only if the [comment] found
autocmd BufWritePost *.md if search('\[table\]', 'nw') != 0 | execute ':Table' | endif

" NerdTree {{{
let NERDTreeShowHidden=1                          " Show hidden but hide ignore files
let NERDTreeIgnore=['\.DS_Store$', '\.git$']

" Show/hide project browser
nmap <F6> :NERDTreeToggle<CR>

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Auto refresh NERDTree when file structure is changed
autocmd BufEnter NERD_tree_* | execute 'normal R'
au CursorHold * if exists("t:NerdTreeBufName") | call <SNR>15_refreshRoot() | endif

" Start NerdTree and put cursor in the other window
autocmd VimEnter * NERDTree | wincmd p

" Speedup navigation on large git repo
let NERDTreeHighlightCursorline = 0
" }}}


" {{{
" Use WhichKey plugin to display a popup for rarely used key mappings
"
" Map leader to launch which_key
nnoremap <silent> <leader> :silent WhichKey ','<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual ','<CR>

let g:which_key_map =  {}
let g:which_key_sep = ': '
" Set a shorter timeout, default is 1000
" set timeoutlen=100

let g:which_key_use_floating_win = 1

" Single mappings
let g:which_key_map['h'] = [ ':MarkdownPreview' , 'markdown preview']
let g:which_key_map['S'] = [ ':LLPStartPreview' , 'preview tex' ]
let g:which_key_map['T'] = [ ':TagbarToggle'    , 'show outline view' ]
let g:which_key_map['f'] = [ ':ALEFix'          , 'format file']

" Configures sub-menu ie \ and s
" c is for cheatsheet
let g:which_key_map.c = {
      \ 'name' : '+cheatsheet'                     ,
      \ ';' : [':Commands'                         , 'commands']           ,
      \ 'c' : [':Commits'                          , 'git commits']            ,
      \ 'G' : [':GFiles?'                          , 'git status'] ,
      \ 'M' : [':Maps'                             , 'key maps']        ,
      \ 'P' : [':Tags'                             , 'project tags']       ,
      \ 's' : [':source ~/.config/nvim/init.vim'   , 'source vim']         ,
      \ 'y' : [':Colors'                           , 'color schemes']      ,
      \ }

" Register which key map
call which_key#register(',', "g:which_key_map")
" }}}

" coc.nvim {{{
" Straight copy and paste from https://github.com/neoclide/coc.nvim
" ---
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Code navigation
" gd - to jump to the symbol definition under your cursor
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
" Find all references under cursor project-wide
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Symbol refactoring
nmap <leader>rf <Plug>(coc-refactor)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" ---
" }}}
