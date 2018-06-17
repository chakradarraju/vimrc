filetype plugin on
set cindent
set tabstop=2
set shiftwidth=2
set expandtab
set hls
set ic
set incsearch

" Ctrl-X for close buffer
map <C-X> :q<CR>

" switch on linenumber by default
set nu
" F5 for toggling linenumber
nmap <F5> :set nu!<CR>

" F4 for toggling search highlight
nmap <F4> :set hls!<CR>

" MRU
nnoremap <C-O> :MRU<CR>
" Don't open a stupid new buffer
let MRU_Use_Current_Window = 1
" Fix for MRU window filetype unknown error when syntax=on
au BufNewFile,BufRead __MRU_Files__ set filetype=mru

" Making horizontal
nnoremap <C-U> <C-W>t<C-W>K

" Making vertical
nnoremap <C-I> <C-W>t<C-W>H

" Move between buffers
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h

" Close every other buffers
nnoremap <C-.> <C-W>o

" Open new buffer vert, hori
nnoremap <C-N> <C-W>v<C-W><C-X><C-W>l:MRU<CR>
nnoremap <C-M> <C-W>s<C-W><C-X><C-W>j:MRU<CR>

nnoremap <C-B> :enew<CR>

nnoremap <C-S> :w<CR>

nnoremap <space> zz

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Search within selected visual rage
function! RangeSearch(direction)
  call inputsave()
  let g:srchstr = input(a:direction)
  call inputrestore()
  if strlen(g:srchstr) > 0
    let g:srchstr = g:srchstr.
          \ '\%>'.(line("'<")-1).'l'.
          \ '\%<'.(line("'>")+1).'l'
  else
    let g:srchstr = ''
  endif
endfunction
vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>

" Command to save readonly file
cmap w!! %!sudo tee > /dev/null %

" If no file is open from commandline open MRU plugin
if argc() == 0
  autocmd VimEnter * MRU
endif

" To highlight only active buffer
au BufEnter * setlocal syntax=on
au BufLeave * setlocal syntax=off

" To reload vimrc
nnoremap <C-F12> :source $MYVIMRC<CR>

nnoremap ; :

set runtimepath^=~/.vim/bundle/ctrlp.vim
