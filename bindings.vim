function Followln() 
  let rpos = searchpos('ln', 'bn')
  if rpos[0] == line(".")
    let rname = matchlist(strpart(getline('.'), rpos[1] + 2), '{\(.\{-}\)}')[1]
    exe "!./follow.sh " . rname
    echo "Followed \"" . rname . "\"."
  endif
endfunction
map <leader>f :call Followln()<CR>
