#!/bin/bash
echo "sample backup script"

echo "start test"
../template_communicate_stub target / <<EOF
  startup
  select instance_name,status from v\$instance;
  shutdown immediate
  exit
EOF
echo $?
echo "done"
