# --- core dependencies ---
SOURCE_DIR := src
OUTPUT_DIR := output
BUILD_DIR := build
BUILD_SOURCE_DIR := ${BUILD_DIR}/src
BUILD_BASENAME := temp

# TODO wrapper

SOURCE_LIST = $(subst ./,,$(shell cd ${SOURCE_DIR} && find \. -type f \( ! -name '.*.sw*' \)))
BUILD_SOURCE_LIST = $(addprefix ${BUILD_SOURCE_DIR}/,${SOURCE_LIST})

get_dir_list = $(subst ./,,$(subst .tex,,$(shell cd ${SOURCE_DIR} && { find \. -type d -name "$(1)" | xargs -i find "{}" -maxdepth 1 -mindepth 1; })))

D_TO = $(dir $@)
D_ABV = $(dir $@)/..
CD_TO = cd ${D_TO}
CD_ABV = cd ${D_ABV}

RL_T := ${OUTPUT_DIR}/rl_theory/ref.pdf
RL_T_F := ${OUTPUT_DIR}/full.pdf
RL_T_F_SRC := ${BUILD_SOURCE_DIR}/full.tex
PROOFS := $(addsuffix /ref.pdf,$(addprefix ${OUTPUT_DIR}/,$(call get_dir_list,proof)))
NOTES := $(addsuffix /ref.pdf,$(addprefix ${OUTPUT_DIR}/,$(call get_dir_list,note)))

TREE_WRAPPER := ${BUILD_SOURCE_DIR}/wrappers/tree.m4
FULL_WRAPPER := ${BUILD_SOURCE_DIR}/wrappers/full.m4

scripts := $(addprefix ${BUILD_SOURCE_DIR}/scripts/,defs_inheritance.sh relpathln.py defs_inheritance.py path_fmt.py)

all : ${RL_T_F} ${RL_T} ${PROOFS} ${NOTES}

.SECONDEXPANSION :

${OUTPUT_DIR}/%/ref.pdf: $$(addprefix $${BUILD_SOURCE_DIR}/,$$(shell python scripts/get_deps.py $$*)) | ${BUILD_DIR} ${OUTPUT_DIR} ${BUILD_SOURCE_DIR}
	find ${BUILD_DIR} -maxdepth 1 -type f | xargs rm -f
	m4 -Dinput_ref="$*" ${TREE_WRAPPER} > ${BUILD_DIR}/${BUILD_BASENAME}.tex
	cd ${BUILD_DIR} && latexmk --pdf --shell-escape ${BUILD_BASENAME}.tex
	mkdir -p $(dir $@) && cp ${BUILD_DIR}/${BUILD_BASENAME}.pdf $@

${RL_T_F} : ${RL_T_F_SRC} ${BUILD_SOURCE_LIST} | ${BUILD_DIR} ${OUTPUT_DIR} ${BUILD_SOURCE_DIR}
	m4 -Dinput=${RL_T_F_SRC} ${FULL_WRAPPER} > ${BUILD_DIR}/${BUILD_BASENAME}.tex
	cd ${BUILD_DIR} && latexmk --pdf --shell-escape ${BUILD_BASENAME}.tex
	mkdir -p $(dir $@) && cp ${BUILD_DIR}/${BUILD_BASENAME}.pdf $@

${RL_T_F_SRC} : | ${BUILD_SOURCE_DIR}
	{ echo "\\\\fulltrue\n\includereference{rl_theory}"; for path in $$(cd ${SOURCE_DIR} && find . -type d -a \( -name proof -o -name note \) | xargs -i find "{}" -maxdepth 1 -mindepth 1); do echo "\includereference{$$(echo $$path | cut -f2- -d/)}"; done; } > ${RL_T_F_SRC}

${BUILD_SOURCE_LIST} : $${SOURCE_DIR}/$$(shell echo "$$@" | cut -d'/' -f3-) | ${BUILD_DIR}
	mkdir -p $(dir $@)
	cp $< $(dir $@)

${BUILD_DIR} ${OUTPUT_DIR} ${BUILD_SOURCE_DIR}:
	mkdir -p $@

${RL_T} ${RL_T_F} ${PROOFS} ${NOTES} : ${BUILD_SOURCE_DIR}/rl_theory.cls ${scripts}

clean : 
	-rm -rf build output
# --- 

# --- auxilliary dependencies ---
# --- --- rl_theory --- ---
RL_T_INP := ${BUILD_SOURCE_DIR}/rl_theory/_input/
RL_T_CODE := ${BUILD_SOURCE_DIR}/rl_theory/code/
RL_T_INP_ACT := $(addprefix ${RL_T_INP},actions_1.tex actions_2.tex)
RL_T_INP_REW := $(addprefix ${RL_T_INP},rewards.tex)

RL_T_CODE_ACT := $(addprefix ${RL_T_CODE},actions.py)
RL_T_CODE_REW := $(addprefix ${RL_T_CODE},rewards.py)

${RL_T} ${RL_T_F}: ${RL_T_INP_ACT} ${RL_T_INP_REW} $(addprefix ${BUILD_SOURCE_DIR}/rl_theory/parts/,notation.tex example.tex)

${BUILD_SOURCE_DIR}/rl_theory/_input/actions_%.tex : ${RL_T_CODE_ACT} ${BUILD_SOURCE_DIR}/rl_theory/code/actions_%.dat | ${RL_T_INP}
	cd $(dir $<); python $(notdir $<) actions_$*

${BUILD_SOURCE_DIR}/rl_theory/_input/rewards.tex : ${RL_T_CODE_REW} ${BUILD_SOURCE_DIR}/rl_theory/code/rewards.dat | ${RL_T_INP}
	cd $(dir $<); python $(notdir $<)

${RL_T_INP} :
	mkdir -p ${RL_T_INP}
# --- ---
# ---
