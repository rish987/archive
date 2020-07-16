function Followln() 
  let rpos = searchpos('ln', 'bn')
  if rpos[0] == line(".")
    let rlist = matchlist(strpart(getline('.'), rpos[1] + 1), '\(.\{-}\){\(.\{-}\)}')
    let rtype = rlist[1]
    let rname = rlist[2]
    let rpath = expand('%:h')
    exe "!./follow.sh " . rtype . " " . rname . " " . rpath
    edit `=rpath . "/" . rtype . "/" . rname . "/" . rname . ".tex"`
    echo "Followed \"" . rname . "\"."
  endif
endfunction
map <leader>rf :call Followln()<CR>
map <leader>ru :edit `=expand('%:h:h:h') . '/' . expand('%:h:h:h:t'). '.tex'`<CR>
