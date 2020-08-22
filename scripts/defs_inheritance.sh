ROOT=`git rev-parse --show-toplevel`
python $ROOT/scripts/defs_inheritance.py `realpath $1` $ROOT
