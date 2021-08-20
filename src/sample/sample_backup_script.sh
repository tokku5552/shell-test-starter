#!/bin/bash
echo "sample backup script"

# Oracleのバックアップスクリプトの例
logname="sample_backup_script.log"

# インスタンスの起動状態確認
sqlplus target / <<EOF
  select instance_name,status from v\$instance;
EOF
ret=$?
if [ ! $ret -eq 0 ]; then
  echo "instance state incorrect" >>$logname
  exit 100
fi

# バックアップ処理
rman target / <<EOF
  backup database;
EOF
ret=$?
if [ ! $ret -eq 0 ]; then
  echo "backup failure" >>$logname
  exit 200
fi

# チェック処理
./db_check.sh full
ret=$?
if [ ! $ret -eq 0 ]; then
  echo "check failed " >>$logname
  exit 300
fi

echo "complete database backup"
