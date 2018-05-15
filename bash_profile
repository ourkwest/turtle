
echo "Turtle."

hue=$(cat ~/.turtle_hue || expr 0)

bg() {
    echo -e -n "\001\033[48;2;${1};${2};${3}m\002"
}

fg() {
    echo -e -n "\001\033[38;2;${1};${2};${3}m\033[1m\002"
}

reset() {
    echo -e -n "\001\033[0m\002"
}

rgb() {
    ((hue+=3))
    echo $hue > ~/.turtle_hue

    r=$(( (hue % 512) - 256 ))
    r=${r#-}
    g=$(( ((hue + 170) % 512) - 256 ))
    g=${g#-}
    b=$(( ((hue + 340) % 512) - 256 ))
    b=${b#-}

    bg $r $g $b
    fg 0 0 0
    echo -e -n "${1:- }"
    reset
}

colourise() {
    foo=" $1 "
    for (( i=0; i<${#foo}; i++ )); do
        rgb ${foo:$i:1}
    done
}

RED1="\001\033[48;2;170;0;0m\002"
RED2="\001\033[48;2;255;0;0m\002"
GREEN="\001\e[0;32m\002"

RETURN_CODE="\$(RET_CODE=\$?; if [[ \$RET_CODE == 0 ]]; then echo -e \"$GREEN\$RET_CODE$RESET_COLOUR\"; else echo -e \"$RED1 $RED2\$RET_CODE$RED1 $RESET_COLOUR\"; fi; )"

export PS1="$RETURN_CODE \t \033[0m\n\$(colourise \W) "
