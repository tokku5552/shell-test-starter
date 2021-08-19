#!/bin/bash
script_name=$(basename $0)
echo "run $script_name"
if [ $# -eq 0 ]; then
    echo "no argument"
else
    for arg in "$*"; do
        echo "argument: $arg"
    done
fi
exit $(cat ${script_name%.*}.dat)
