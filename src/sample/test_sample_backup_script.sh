#!/bin/bash
# this is sample test script

# 全てのスタブを0で返却する
function allStateClear() {
    echo 0 >./sqlplus.dat
    echo 0 >./db_check.dat
    echo 0 >./rman.dat
}

echo "begin sample backup script test"
export PATH=./:$PATH
allStateClear
# test case 1 :
./sample_backup_script.sh

echo "complete database backup test"
