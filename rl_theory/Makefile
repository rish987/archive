FMTD = ${HOME}/texmf/tex/latex/rl_theory
FMTDLD = ../defs
FMTDLF = ../format

global_defs = ${FMTD}/notation.tex ${FMTD}/keywords.tex ${FMTD}/example_defs.tex 
global_styles = ${FMTD}/globals.sty ${FMTD}/rl_theory.cls

rl_theory.pdf : rl_theory.tex parts/example.tex parts/notation.tex \
	_input/rewards.tex _input/actions_1.tex _input/actions_2.tex \
	${global_defs} ${global_styles}
	pdflatex --shell-escape rl_theory.tex

${global_defs} ${global_styles} : ${FMTD}

${FMTD} :
	mkdir -p ${FMTD}

.SECONDEXPANSION :

${global_defs} : ${FMTDLD}/$$(notdir $$@)
	cp $< ${FMTD}

${global_styles} : ${FMTDLF}/$$(notdir $$@)
	cp $< ${FMTD}

_input/actions_%.tex : code/actions.py actions_%.dat
	python $< actions_$*

_input/rewards.tex : code/rewards.py rewards.dat
	python $<

code/actions.py code/rewards.py : _input/

_input/ :
	mkdir _input

clean :
	-rm *.aux *.out *.log *.fls *.pdf
	-rm -rf _input
	-rm -rf ${FMTD}
	-rm parts/*.aux
