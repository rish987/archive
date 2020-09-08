# --- core dependencies ---
SOURCE_DIR := src
OUTPUT_DIR := output
BUILD_DIR := build
BUILD_SOURCE_DIR := ${BUILD_DIR}/src
BUILD_BASENAME := ref
BUILD_DEFS_BASENAME := defs

# TODO wrapper

SOURCE_LIST = $(subst ./,,$(shell cd ${SOURCE_DIR} && find \. -type f \( ! -name '.*.sw*' \)))
BUILD_SOURCE_LIST = $(addprefix ${BUILD_SOURCE_DIR}/,${SOURCE_LIST})

get_dir_list = $(subst ./,,$(subst .tex,,$(shell cd ${SOURCE_DIR} && { find \. -type d -name "$(1)" | xargs -i find "{}" -maxdepth 1 -mindepth 1; })))

get_out_list = $(addsuffix /ref.pdf,$(addprefix ${OUTPUT_DIR}/,$(call get_dir_list,$(1))))
get_defs_list = $(addsuffix /defs.pdf,$(addprefix ${OUTPUT_DIR}/,$(call get_dir_list,$(1))))

D_TO = $(dir $@)
D_ABV = $(dir $@)/..
CD_TO = cd ${D_TO}
CD_ABV = cd ${D_ABV}

ARCHIVES := ${OUTPUT_DIR}/archives/ref.pdf
PROOFS := $(call get_out_list,proof)
NOTES := $(call get_out_list,note)
TOPICS := $(call get_out_list,topic)
DEFINITIONS := $(call get_out_list,definition)

ARCHIVES_D := ${OUTPUT_DIR}/archives/defs.pdf
PROOFS_D := $(call get_defs_list,proof)
NOTES_D := $(call get_defs_list,note)
TOPICS_D := $(call get_defs_list,topic)
DEFINITIONS_D := $(call get_defs_list,definition)

ARCHIVES_F := ${OUTPUT_DIR}/full.pdf
ARCHIVES_F_SRC := ${BUILD_SOURCE_DIR}/full.tex

TREE := ${ARCHIVES} ${PROOFS} ${NOTES} ${TOPICS} ${DEFINITIONS}
DEFS := ${ARCHIVES_D} ${PROOFS_D} ${NOTES_D} ${TOPICS_D} ${DEFINITIONS_D}

TREE_WRAPPER := ${BUILD_SOURCE_DIR}/wrappers/tree.m4
FULL_WRAPPER := ${BUILD_SOURCE_DIR}/wrappers/full.m4
DEFS_WRAPPER := ${BUILD_SOURCE_DIR}/wrappers/defs.m4

scripts := $(addprefix ${BUILD_SOURCE_DIR}/scripts/,defs_inheritance.sh relpathln.py defs_inheritance.py path_fmt.py format_defs.sh)

all : tree full
tree : ${TREE}
full : ${ARCHIVES_F}
defs : ${DEFS}

.SECONDEXPANSION :

${OUTPUT_DIR}/%/ref.pdf: $$(addprefix $${BUILD_SOURCE_DIR}/,$$(shell scripts/get_deps.sh $$*)) | ${BUILD_DIR} ${OUTPUT_DIR} ${BUILD_SOURCE_DIR}
	find ${BUILD_DIR} -maxdepth 1 -type f | xargs rm -f
	m4 -Dinput_ref="$*" ${TREE_WRAPPER} > ${BUILD_DIR}/${BUILD_BASENAME}.tex
	cd ${BUILD_DIR} && pdflatex --halt-on-error --shell-escape ${BUILD_BASENAME}.tex
	mkdir -p $(dir $@) && cp ${BUILD_DIR}/${BUILD_BASENAME}.pdf $@

${OUTPUT_DIR}/%/defs.pdf: $$(addprefix $${BUILD_SOURCE_DIR}/,$$(shell scripts/get_deps_defs.sh $$*)) | ${BUILD_DIR} ${OUTPUT_DIR} ${BUILD_SOURCE_DIR}
	find ${BUILD_DIR} -maxdepth 1 -type f | xargs rm -f
	m4 -Dinput_ref="$*" ${DEFS_WRAPPER} > ${BUILD_DIR}/${BUILD_DEFS_BASENAME}.tex
	cd ${BUILD_DIR} && pdflatex --halt-on-error --shell-escape ${BUILD_DEFS_BASENAME}.tex
	mkdir -p $(dir $@) && cp ${BUILD_DIR}/${BUILD_DEFS_BASENAME}.pdf $@

${ARCHIVES_F} : ${ARCHIVES_F_SRC} ${BUILD_SOURCE_LIST} | ${BUILD_DIR} ${OUTPUT_DIR} ${BUILD_SOURCE_DIR}
	find ${BUILD_DIR} -maxdepth 1 -type f | xargs rm -f
	m4 -Dinput=${ARCHIVES_F_SRC} ${FULL_WRAPPER} > ${BUILD_DIR}/${BUILD_BASENAME}.tex
	cd ${BUILD_DIR} && latexmk --halt-on-error --pdf --shell-escape ${BUILD_BASENAME}.tex
	mkdir -p $(dir $@) && cp ${BUILD_DIR}/${BUILD_BASENAME}.pdf $@

${ARCHIVES_F_SRC} : ${BUILD_SOURCE_LIST} | ${BUILD_SOURCE_DIR}
	{ echo "\includereference{archives}"; for path in $$(cd ${BUILD_SOURCE_DIR} && find . -type d -a \( -name proof -o -name note -o -name topic -o -name definition \) | xargs -i find "{}" -maxdepth 1 -mindepth 1); do echo "\includereference{$$(echo $$path | cut -f2- -d/)}"; done; } > ${ARCHIVES_F_SRC}

${BUILD_SOURCE_LIST} : $${SOURCE_DIR}/$$(shell echo "$$@" | cut -d'/' -f3-) | ${BUILD_DIR}
	mkdir -p $(dir $@)
	cp $< $(dir $@)

${BUILD_DIR} ${OUTPUT_DIR} ${BUILD_SOURCE_DIR}:
	mkdir -p $@

${ARCHIVES_F} ${TREE} ${DEFS} : ${BUILD_SOURCE_DIR}/archives.cls ${scripts}
${ARCHIVES_F} : ${FULL_WRAPPER}
${TREE} : ${TREE_WRAPPER}
${DEFS} : ${DEFS_WRAPPER}

clean : 
	-rm -rf build output
# --- 

# --- auxilliary dependencies ---
# --- --- rl_theory --- ---
RL_T_D := ${BUILD_SOURCE_DIR}/archives/topic/rl_theory
RL_T_INP := ${RL_T_D}/_input/
RL_T_CODE := ${RL_T_D}/code/
RL_T_INP_ACT := $(addprefix ${RL_T_INP},actions_1.tex actions_2.tex)
RL_T_INP_REW := $(addprefix ${RL_T_INP},rewards.tex)

RL_T_CODE_ACT := $(addprefix ${RL_T_CODE},actions.py)
RL_T_CODE_REW := $(addprefix ${RL_T_CODE},rewards.py)

output/archives/topic/rl_theory/ref.pdf ${ARCHIVES_F}: ${RL_T_INP_ACT} ${RL_T_INP_REW} $(addprefix ${RL_T_D}/parts/,notation.tex example.tex preliminaries.tex)

${RL_T_D}/_input/actions_%.tex : ${RL_T_CODE_ACT} ${RL_T_D}/code/actions_%.dat | ${RL_T_INP}
	cd $(dir $<); python $(notdir $<) actions_$*

${RL_T_D}/_input/rewards.tex : ${RL_T_CODE_REW} ${RL_T_D}/code/rewards.dat | ${RL_T_INP}
	cd $(dir $<); python $(notdir $<)

${RL_T_INP} :
	mkdir -p ${RL_T_INP}
# --- ---
# ---
