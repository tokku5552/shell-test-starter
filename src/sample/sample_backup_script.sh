#!/bin/bash
# Oracleのバックアップスクリプトの例

logname="sample_backup_script.log"

echo "INFO: sample backup script" >>$logname

# インスタンスの起動状態確認
sqlplus target / 2 &>1 >/dev/null <<EOF
  select instance_name,status from v\$instance;
EOF
ret=$?
if [ ! $ret -eq 0 ]; then
  echo "ERROR: instance state incorrect" >>$logname
  exit 100
fi

# バックアップ処理
rman target / 2 &>1 >/dev/null <<EOF
  backup database;
EOF
ret=$?
if [ ! $ret -eq 0 ]; then
  echo "ERROR: backup failure" >>$logname
  exit 200
fi

# チェック処理
./db_check.sh full
ret=$?
if [ ! $ret -eq 0 ]; then
  echo "ERROR: check failed " >>$logname
  exit 300
fi

echo "INFO: complete database backup" >>$logname
