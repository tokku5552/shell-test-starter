#!/bin/bash
# this is sample test script
logname="sample_backup_script.log"

# 全てのスタブを0で返却する
function allStateClear() {
    echo 0 >./sqlplus.dat
    echo 0 >./db_check.dat
    echo 0 >./rman.dat
}

echo "begin sample backup script test"
export PATH=./:$PATH
# test case 1 :正常系　完了した場合返却値が0であること
allStateClear
./sample_backup_script.sh
ret=$?
if [ $ret -eq 0 ]; then
    echo "OK: test case 1"
else
    echo "NG: test case 1 : [ret : ${ret}]"
fi

# test case 2 :正常系　ログにINFO: complete database backupと出力されていること
allStateClear
./sample_backup_script.sh
ret=$(tail -n 1 $logname | grep "INFO: complete database backup" | wc -l)
if [ $ret -eq 1 ]; then
    echo "OK: test case 2"
else
    echo "NG: test case 2"
fi

# test case 3 :正常系　db_checkに引数fullが渡されていること
allStateClear
./sample_backup_script.sh
ret=$(tail -n 2 ./test_db_check.sh.log | grep "argument: full" | wc -l)
if [ $ret -eq 1 ]; then
    echo "OK: test case 3"
else
    echo "NG: test case 3"
fi

# test case 4 :インスタンス起動状態の確認に失敗した場合、返却値が100であること
allStateClear
echo 1 >./sqlplus.dat
./sample_backup_script.sh
ret=$?
if [ $ret -eq 100 ]; then
    echo "OK: test case 4"
else
    echo "NG: test case 4 : [ret : ${ret}]"
fi

# test case 5 :インスタンス起動状態の確認に失敗した場合、エラーがログに出力されていること
allStateClear
echo 1 >./sqlplus.dat
./sample_backup_script.sh
ret=$(tail -n 1 $logname | grep "ERROR: instance state incorrect" | wc -l)
if [ $ret -eq 1 ]; then
    echo "OK: test case 5"
else
    echo "NG: test case 5"
fi

# test case 6 :バックアップ処理に失敗した場合、返却値が200であること
allStateClear
echo 1 >./rman.dat
./sample_backup_script.sh
ret=$?
if [ $ret -eq 101 ]; then
    echo "OK: test case 6"
else
    echo "NG: test case 6 : [ret : ${ret}]"
fi

# test case 7 :バックアップ処理に失敗した場合、エラーがログに出力されていること
allStateClear
echo 1 >./rman.dat
./sample_backup_script.sh
ret=$(tail -n 1 $logname | grep "ERROR: backup failure" | wc -l)
if [ $ret -eq 1 ]; then
    echo "OK: test case 7"
else
    echo "NG: test case 7"
fi

# test case 8 :チェック処理に失敗した場合、返却値が300であること
allStateClear
echo 1 >./db_check.dat
./sample_backup_script.sh
ret=$?
if [ $ret -eq 102 ]; then
    echo "OK: test case 8"
else
    echo "NG: test case 8 : [ret : ${ret}]"
fi

# test case 9 :チェック処理に失敗した場合、エラーがログに出力されていること
allStateClear
echo 1 >./db_check.dat
./sample_backup_script.sh
ret=$(tail -n 1 $logname | grep "ERROR: check failed" | wc -l)
if [ $ret -eq 1 ]; then
    echo "OK: test case 9"
else
    echo "NG: test case 9"
fi

echo "complete database backup test"
