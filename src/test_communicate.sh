#!/bin/bash
echo "start test"
./template_communicate_stub << EOF
  startup
  select instance_name,status from v\$instance;
  shutdown immediate
  exit
EOF
echo "done"