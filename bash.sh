#!/bin/bash

checkCommandExist(){
    command -v $1 >/dev/null 2>&1 || { echo "I require $1 but it's not installed.  Aborting." >&2; exit 1; }
}

readBoolStr(){
    if test $# == 1  ; then
        echo $1 yes/no
        read ANS
        readBoolStr "$1" $ANS
        ret=$?
        return $ret
    elif test $# == 2  ; then
        case $2 in
        yes|YES|Yes)
            return 1
        ;;
        no|NO|No)
            return 0
        ;;
        *)
            readBoolStr "$1"
            ret=$?
            return $ret
        ;;
        esac
    else
        readBoolStr "$1"
        ret=$?
        return $ret
    fi
}

function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo "y"
            return 0
        fi
    }
    echo "n"
    return 1
}

function operationSelect(){
    paramArray=()

    echo "We support follow select："
    echo
    while [ $# -gt 0 ]
    do
        paramArray+=("$1")
        echo $1
        shift
    done

    echo
    echo
    echo "Please select your env:"

    read ANS

    if [ $(contains "${paramArray[@]}" ${ANS}) == "y" ]; then
        __=$ANS
    else
        operationSelect "${paramArray[@]}"
    fi
}


function testOperationSelect(){
    paramArray=(a "bb" "cc  dd" "ee   ff   gg")
    operationSelect "${paramArray[@]}"

    echo your selection is: ${__}
}
