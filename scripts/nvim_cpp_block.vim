" Load this inside nvim:
" :source scripts/nvim_cpp_block.vim
"
" Commands:
" :CppBlock          -> inserts full runnable block below cursor
" :CppBlockSnippet   -> inserts minimal snippet block below cursor

function! s:InsertCppBlock(mode) abort
  let l:start = expand('%:p:h')
  if empty(l:start)
    let l:start = getcwd()
  endif
  let l:found = findfile('scripts/cpp_block_scaffold.sh', l:start . ';')
  if empty(l:found)
    let l:found = findfile('scripts/cpp_block_scaffold.sh', getcwd() . ';')
  endif
  if empty(l:found)
    echoerr 'missing script: scripts/cpp_block_scaffold.sh'
    return
  endif
  let l:script = fnamemodify(l:found, ':p')
  if executable(l:script) == 0
    echoerr 'missing script: ' . l:script
    return
  endif
  execute 'read !' . shellescape(l:script) . ' ' . a:mode
endfunction

command! CppBlock call <SID>InsertCppBlock('main')
command! CppBlockSnippet call <SID>InsertCppBlock('snippet')
