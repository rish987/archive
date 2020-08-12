FMTD := ${HOME}/texmf/tex/latex/rl_theory
TOP := $(shell git rev-parse --show-toplevel | tr -d "\n")
FMTDLD := ${TOP}/defs
FMTDLF := ${TOP}/format
NAME := $(shell basename `pwd`)

global_defs := ${addprefix ${FMTD}/,notation.tex keywords.tex}
global_styles := ${FMTD}/globals.sty 

global_styles := ${global_styles} ${FMTD}/proof.cls 

${NAME}.pdf : ${NAME}.tex ${global_defs} ${global_styles}
	pdflatex --shell-escape $<

.SECONDEXPANSION :

${global_defs} : ${FMTDLD}/$$(notdir $$@) | ${FMTD}
	cp $< ${FMTD}

${global_styles} : ${FMTDLF}/$$(notdir $$@) | ${FMTD}
	cp $< ${FMTD}

${FMTD} :
	mkdir -p ${FMTD}

clean :
	-rm *.aux *.out *.log *.fls *.pdf
	-rm -rf ${FMTD}
