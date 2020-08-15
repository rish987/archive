# --- core dependencies ---

FMTD := ${HOME}/texmf/tex/latex/rl_theory
FMTDL := format

source_basename_list = $(subst .tex,,$(shell find . -type d -name $(1) | xargs -i find "{}" -maxdepth 2 -mindepth 2 -name *.tex))
source_pdf_list = $(addsuffix .pdf,$(call source_basename_list,$(1)))
source_clean_list = $(addsuffix .clean,$(call source_basename_list,$(1)))

RL_T := rl_theory/rl_theory.pdf
RL_T_CLEAN := rl_theory/rl_theory.clean

D_TO = $(dir $@)
D_ABV = $(dir $@)/..
CD_TO = cd ${D_TO}
CD_ABV = cd ${D_ABV}

PROOFS := $(call source_pdf_list,proof)
PROOFS_CLEAN := $(call source_clean_list,proof)

formats := ${addprefix ${FMTD}/,notation.tex keywords.tex globals.sty} 

all : ${RL_T} ${PROOFS}

%.pdf : %.tex
	cd ${dir $@} && mkdir -p _tikz && pdflatex --shell-escape ${notdir $<}

${PROOFS} : ${formats} ${FMTD}/proof.cls
${RL_T} : ${formats} ${FMTD}/rl_theory.cls ${FMTD}/example_defs.tex 

${FMTD}/% : ${FMTDL}/% | ${FMTD}
	cp $< ${FMTD}

${FMTD} :
	mkdir -p ${FMTD}

test :
	echo ${PROOFS}
	echo ${PROOFS_CLEAN}

${PROOFS_CLEAN} : 
	-${CD_TO}; rm -rf *.aux *.out *.log *.fls *.pdf _tikz

${RL_T_CLEAN} : 
	-${CD_TO}; rm -rf *.aux *.out *.log *.fls *.pdf; rm -rf _input; rm -f parts/*.aux _tikz

clean : ${RL_T_CLEAN} ${PROOFS_CLEAN}
	-rm -rf ${FMTD}

# --- 

# --- auxilliary dependencies ---
# --- --- rl_theory --- ---
RL_T_INP := rl_theory/_input/
RL_T_CODE := rl_theory/code/
RL_T_INP_ACT := $(addprefix ${RL_T_INP},actions_1.tex actions_2.tex)
RL_T_INP_REW := $(addprefix ${RL_T_INP},rewards.tex)

RL_T_CODE_ACT := $(addprefix ${RL_T_CODE},actions.py)
RL_T_CODE_REW := $(addprefix ${RL_T_CODE},rewards.py)

${RL_T} : ${RL_T_INP_ACT} ${RL_T_INP_REW}

rl_theory/_input/actions_%.tex : ${RL_T_CODE_ACT} rl_theory/code/actions_%.dat | ${RL_T_INP}
	cd $(dir $<); python $(notdir $<) actions_$*

rl_theory/_input/rewards.tex : $(RL_T_CODE_REW) rl_theory/code/rewards.dat | ${RL_T_INP}
	cd $(dir $<); python $(notdir $<)

${RL_T_INP} :
	mkdir ${RL_T_INP}
# --- ---
# ---
