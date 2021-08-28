#!/bin/bash
script_name=$(basename $0)
script_logname=test_$script_name.log
echo "run $script_name" >>$script_logname
if [ $# -eq 0 ]; then
    echo "no argument" >>$script_logname
else
    for arg in "$*"; do
        echo "argument: $arg" >>$script_logname
    done
fi
exit $(cat ${script_name%.*}.dat)
