roots=("./rl_theory")
roots+=(`find . -type d -name "proof" | xargs -i find "{}" -maxdepth 1 -mindepth 1 -type d`)

if [[ " ${roots[@]} " =~ "$1 " ]]; then
    exit 0
fi
exit 1
