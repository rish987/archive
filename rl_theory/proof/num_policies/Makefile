FMTD := ${HOME}/texmf/tex/latex/rl_theory
TOP := $(shell git rev-parse --show-toplevel | tr -d "\n")
FMTDLD := ${TOP}/defs
FMTDLF := ${TOP}/format

global_defs := ${FMTD}/notation.tex ${FMTD}/keywords.tex
global_styles := ${FMTD}/globals.sty ${FMTD}/proof.cls 

num_policies.pdf : num_policies.tex ${global_defs} ${global_styles}
	pdflatex --shell-escape $<

${global_defs} ${global_styles} : ${FMTD}

${FMTD} :
	mkdir -p ${FMTD}

.SECONDEXPANSION :

${global_defs} : ${FMTDLD}/$$(notdir $$@)
	cp $< ${FMTD}

${global_styles} : ${FMTDLF}/$$(notdir $$@)
	cp $< ${FMTD}

clean :
	-rm *.aux *.out *.log *.fls *.pdf
	-rm -rf ${FMTD}
