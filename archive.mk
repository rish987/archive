# --- auxilliary dependencies ---
# --- --- rl_theory --- ---
RL_T_D := ${BUILD_SOURCE_DIR}/archive/topic/rl_theory
RL_T_INP := ${RL_T_D}/_input/
RL_T_CODE := ${RL_T_D}/code/
RL_T_INP_ACT := $(addprefix ${RL_T_INP},actions_1.tex actions_2.tex)
RL_T_INP_REW := $(addprefix ${RL_T_INP},rewards.tex)

RL_T_CODE_ACT := $(addprefix ${RL_T_CODE},actions.py)
RL_T_CODE_REW := $(addprefix ${RL_T_CODE},rewards.py)

${OUTPUT_DIR}/tree/archive/topic/rl_theory/tree.pdf ${OUTPUT_DIR}/tree_online/archive/topic/rl_theory/tree_online.pdf ${OUTPUT_DIR}/full/archive/full.pdf ${OUTPUT_DIR}/full_compact/archive/full_compact.pdf : ${RL_T_INP_ACT} ${RL_T_INP_REW} $(addprefix ${RL_T_D}/parts/,notation.tex example.tex preliminaries.tex)

${RL_T_D}/_input/actions_%.tex : ${RL_T_CODE_ACT} ${RL_T_D}/code/actions_%.dat | ${RL_T_INP}
	cd $(dir $<); python $(notdir $<) actions_$*

${RL_T_D}/_input/rewards.tex : ${RL_T_CODE_REW} ${RL_T_D}/code/rewards.dat | ${RL_T_INP}
	cd $(dir $<); python $(notdir $<)

${RL_T_INP} :
	mkdir -p ${RL_T_INP}
# --- ---
# ---
