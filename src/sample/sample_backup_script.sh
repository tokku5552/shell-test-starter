#!/bin/bash
# Oracle backup script example

logname="sample_backup_script.log"

echo "INFO: sample backup script" >>$logname

# Check the startup status of the instance
sqlplus target / 2>&1 >/dev/null <<EOF
  select instance_name,status from v\$instance;
EOF
ret=$?
if [ ! $ret -eq 0 ]; then
  echo "ERROR: instance state incorrect" >>$logname
  exit 100
fi

# Backup process
rman target / 2>&1 >/dev/null <<EOF
  backup database;
EOF
ret=$?
if [ ! $ret -eq 0 ]; then
  echo "ERROR: backup failure" >>$logname
  exit 101
fi

# Check processing
./db_check.sh full
ret=$?
if [ ! $ret -eq 0 ]; then
  echo "ERROR: check failed" >>$logname
  exit 102
fi

echo "INFO: complete database backup" >>$logname
