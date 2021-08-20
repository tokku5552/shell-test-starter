#!/bin/bash
echo "sample backup script"

echo "start test"
sqlplus target / <<EOF
  startup
  select instance_name,status from v\$instance;
  shutdown immediate
  exit
EOF
echo $?
echo "done"
