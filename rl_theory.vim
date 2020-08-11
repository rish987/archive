function Followln() 
  let rpos = searchpos('ln', 'bn')
  if rpos[0] == line(".")
    let rlist = matchlist(strpart(getline('.'), rpos[1] + 1), '\(.\{-}\){\(.\{-}\)}')
    let rtype = rlist[1]
    let rname = rlist[2]
    let rpath = expand('%:h')
    let filepath = trim(system("./scripts/follow.sh " . rtype . " " . rname . " " . rpath))
    if v:shell_error == 0
        edit `=filepath`
        echo "Followed \"" . rname . "\"."
    endif
  endif
endfunction

map <leader>rf :call Followln()<CR>
map <leader>ru :edit `=expand('%:h:h:h') . '/' . expand('%:h:h:h:t'). '.tex'`<CR>
map <leader>rl :execute "!./scripts/load_format.sh"<CR>

edit rl_theory/rl_theory.tex
tabedit defs/keywords.tex
split defs/notation.tex
tabedit format/globals.sty

tabfirst
