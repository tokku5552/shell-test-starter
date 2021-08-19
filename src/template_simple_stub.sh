#!/bin/bash
if [ $# -eq 0 ]; then
    echo "no argument"
else
    for arg in "$*"; do
        echo "argument: $arg"
    done
fi
