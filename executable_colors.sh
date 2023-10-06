for i in {0..255}; do
    printf "\x1b[38;5;${i}m${i}\x1b[0m\t"
    if ! (((i+1) % 8)); then
        printf "\n"
    fi
done
