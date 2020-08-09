RL_THEORY_FMT_DIR = "${HOME}/texmf/tex/latex/rl_theory"

rl_theory.pdf : rl_theory.tex parts/example.tex parts/notation.tex _input/rewards.tex _input/actions_1.tex _input/actions_2.tex 
	pdflatex --shell-escape rl_theory.tex


_input/actions_1.tex : code/actions.py actions_1.dat
	python code/actions.py actions_1

_input/actions_2.tex : code/actions.py actions_2.dat
	python code/actions.py actions_2

code/actions.py : _input/

code/rewards.py : _input/

_input/ :
	mkdir _input

_input/rewards.tex : code/rewards.py rewards.dat
	python code/rewards.py

clean :
	rm *.aux *.out *.log *.fls
	rm -rf _input
	rm parts/*.aux
