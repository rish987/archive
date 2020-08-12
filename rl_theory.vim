function Followln() 
  let rpos = searchpos('ln', 'bn')
  if rpos[0] == line(".")
    let rlist = matchlist(strpart(getline('.'), rpos[1] + 1), '\(.\{-}\){\(.\{-}\)}')
    let rtype = rlist[1]
    let rname = rlist[2]
    let rpath = expand('%:h')
    silent let output = trim(system("./scripts/follow.sh " . rtype . " " . rname . " " . rpath))
    if v:shell_error == 0
        edit `=output`
    else
        echo "Error following \"" . rname . "\": " . output . ""
    endif
  endif
endfunction

map <leader>rf :call Followln()<CR>

edit rl_theory/rl_theory.tex
tabedit defs/keywords.tex
split defs/notation.tex
tabedit format/globals.sty

tabfirst
