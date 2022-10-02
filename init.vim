set nocompatible              " required
filetype off                  " required

" Work only with neovim with this path. 
call plug#begin(stdpath('data') . '/plugged')
" Put the plugins here, then :source % and :PlugInstall
  Plug 'Vimjas/vim-python-pep8-indent'
  Plug 'dense-analysis/ale'
  Plug 'preservim/nerdtree'
  Plug 'jiangmiao/auto-pairs'
  Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Theme
  Plug 'joshdick/onedark.vim'
  " Plug 'shaunsingh/oxocarbon.nvim', { 'do': './install.sh' }

" Plugin for HCL
  Plug 'hashivim/vim-terraform'
  Plug 'juliosueiras/vim-terraform-completion'

  " Telescope plugs
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  " C auto-completion
  Plug 'Shougo/deoplete.nvim'
  Plug 'zchee/deoplete-clang'

  " Initialize plugin system.
call plug#end()


" ------------------------
" ---------Option---------
" ------------------------

" color schemes
colorscheme  onedark 
" colorscheme oxocarbon

" set up python
" let g:python3_host_prog = '/opt/python-3.9.3-3/bin/python3.9'
let g:python3_host_prog = '/usr/local/bin/python3.10'
let g:python_host_prog = '/usr/bin/python2'

" flagging unnecessary whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" UTF-8 support
set encoding=utf-8

" syntax checking/highlighting
syntax on
syntax sync fromstart

" set relative line numbers on 
set relativenumber
set nu rnu

" set line number in statusbar
set ruler

" set columndisplay
set colorcolumn=88
			\
" make sure that spaces are use with tab button
set expandtab

" insert a n number of spaces, here n=4
set tabstop=4

" insert n number of spaces with << & >> commands
set shiftwidth=4


" ------------------------
" ----------Alias---------
" ------------------------

" tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tt :tabnew
map ts :tab split<CR>

" folding distraction with space instead of za.
nnoremap <space> za

" change leader key
let mapleader = ","


" ------------------------
" ------------C-----------
" ------------------------

" custom setting for clangformat
let g:neoformat_cpp_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['--style="{IndentWidth: 4}"']
            \}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']


" ------------------------
" --------Plugins---------
" ------------------------

" _______ALE_______

" config ALE plugin.<Paste>
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'javascript': ['eslint'],
      \   'cpp': ['clang'],
      \   'c': ['clang']
      \}

" Press F10 to active or save the current buffer.
let g:ale_fixers = {
      \    'python': ['black'],
      \}
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 0

" Show the total number of errors.
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
			  \   '😞 %dW %dE',
			  \   all_non_errors,
			  \   all_errors
			  \) 
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}


" _______NerdTree_______

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>


" _______COC_______
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


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


" HCL OPTIONS
" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0


" TELESCOP OPTIONS
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>



