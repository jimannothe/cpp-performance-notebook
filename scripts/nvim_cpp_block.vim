" Load this inside nvim:
" :source /home/jman/cpp-performance-notebook/scripts/nvim_cpp_block.vim
"
" Commands:
" :CppBlock          -> inserts full runnable block below cursor
" :CppBlockSnippet   -> inserts minimal snippet block below cursor

function! s:InsertCppBlock(mode) abort
  let l:script = '/home/jman/cpp-performance-notebook/scripts/cpp_block_scaffold.sh'
  if executable(l:script) == 0
    echoerr 'missing script: ' . l:script
    return
  endif
  execute 'read !' . shellescape(l:script) . ' ' . a:mode
endfunction

command! CppBlock call <SID>InsertCppBlock('main')
command! CppBlockSnippet call <SID>InsertCppBlock('snippet')
