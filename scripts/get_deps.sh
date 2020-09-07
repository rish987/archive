python3 scripts/get_deps.py $1
find src/$1 -maxdepth 1 -mindepth 1 -type d -a \( -name proof -o -name note -o -name topic -o -name definition \) | xargs -i find "{}" -maxdepth 2 -mindepth 2 -name "defs.tex" | cut -f2- -d/ | xargs echo -n
