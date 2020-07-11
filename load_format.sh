RL_THEORY_FMT_DIR="$HOME/texmf/tex/latex/rl_theory"

if [[ ! -d "$RL_THEORY_FMT_DIR" ]]; then
  mkdir -p "$RL_THEORY_FMT_DIR"
fi

cp ./format/{*.cls,*.sty} "$RL_THEORY_FMT_DIR"
cp ./defs/*.tex "$RL_THEORY_FMT_DIR"
