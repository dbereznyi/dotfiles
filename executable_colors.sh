for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\t"
    if ! ((i % 5)); then
        printf "\n"
    fi
done
