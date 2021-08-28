#!/bin/bash
# this is sample test script
logname="sample_backup_script.log"

# function that returns all stubs with 0
function allStateClear() {
    echo 0 >./sqlplus.dat
    echo 0 >./db_check.dat
    echo 0 >./rman.dat
}

echo "begin sample backup script test"
export PATH=./:$PATH
# test case 1 : When completed, the return value must be 0
allStateClear
./sample_backup_script.sh
ret=$?
if [ $ret -eq 0 ]; then
    echo "OK: test case 1"
else
    echo "NG: test case 1 : [ret : ${ret}]"
fi

# test case 2 : INFO: complete database backup is output to the log
allStateClear
./sample_backup_script.sh
ret=$(tail -n 1 $logname | grep "INFO: complete database backup" | wc -l)
if [ $ret -eq 1 ]; then
    echo "OK: test case 2"
else
    echo "NG: test case 2"
fi

# test case 3 : The argument full is passed to db_check
allStateClear
./sample_backup_script.sh
ret=$(tail -n 2 ./test_db_check.sh.log | grep "argument: full" | wc -l)
if [ $ret -eq 1 ]; then
    echo "OK: test case 3"
else
    echo "NG: test case 3"
fi

# test case 4 : If the confirmation of the instance startup status fails,
#               the return value must be 100.
allStateClear
echo 1 >./sqlplus.dat
./sample_backup_script.sh
ret=$?
if [ $ret -eq 100 ]; then
    echo "OK: test case 4"
else
    echo "NG: test case 4 : [ret : ${ret}]"
fi

# test case 5 : If the confirmation of the instance startup status fails,
#               an error has been output to the log.
allStateClear
echo 1 >./sqlplus.dat
./sample_backup_script.sh
ret=$(tail -n 1 $logname | grep "ERROR: instance state incorrect" | wc -l)
if [ $ret -eq 1 ]; then
    echo "OK: test case 5"
else
    echo "NG: test case 5"
fi

# test case 6 : If the backup process fails, the return value must be 200
allStateClear
echo 1 >./rman.dat
./sample_backup_script.sh
ret=$?
if [ $ret -eq 101 ]; then
    echo "OK: test case 6"
else
    echo "NG: test case 6 : [ret : ${ret}]"
fi

# test case 7 : If the backup process fails, an error has been output to the log.
allStateClear
echo 1 >./rman.dat
./sample_backup_script.sh
ret=$(tail -n 1 $logname | grep "ERROR: backup failure" | wc -l)
if [ $ret -eq 1 ]; then
    echo "OK: test case 7"
else
    echo "NG: test case 7"
fi

# test case 8 : If the check process fails, the return value must be 300
allStateClear
echo 1 >./db_check.dat
./sample_backup_script.sh
ret=$?
if [ $ret -eq 102 ]; then
    echo "OK: test case 8"
else
    echo "NG: test case 8 : [ret : ${ret}]"
fi

# test case 9 : If the check process fails, an error has been output to the log.
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
