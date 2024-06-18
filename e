#!/opt/homebrew/bin/bash

choice=0
num_args=$#
if [ $num_args -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

if [ $num_args -eq 1 ]; then
    num=0

    readarray -t matches <<< $(mdfind -name $1 -onlyin . 2> /dev/null)

    i=0
    for ee in "${matches[@]}"; do
        abc="./$(realpath --relative-to="$(pwd)" $ee)"
        echo "$i: $abc"
        i=$((i+1))
    done

    echo  "${#matches[@]}"
    if [ "${#matches[@]}" -gt 1 ]; then
        read -n 1 num
        if [ "$num" != '' ]; then echo ''; fi
    fi

    echo "Editing ${matches[$num]}"
    $EDITOR ${matches[$num]}
else
    echo "You provided $num_args arguments"
fi

