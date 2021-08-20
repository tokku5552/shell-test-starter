#!/bin/bash
# 変数定義
array_communicate_stub=(sqlplus rman)
array_simple_stub=(db_check)
tmp_com_stub=template_communicate_stub
tmp_simple_stub=template_simple_stub

# テスト実行時の準備処理を記載しておく
echo "INFO: prepare stub script"

if [ ! -e ../${tmp_com_stub} ]; then
    echo "ERROR: [${tmp_com_stub}] not found"
    exit 1
fi
for item in ${array_communicate_stub[@]}; do
    cp -pr ../${tmp_com_stub} ./${item}
    cp -pr ../${tmp_com_stub}.dat ./${item}.dat
done

for item in ${array_simple_stub[@]}; do
    cp -pr ../${tmp_simple_stub}.sh ./${item}.sh
    cp -pr ../${tmp_simple_stub}.dat ./${item}.dat
done

echo "done prepare!"
# export PATH=./:$PATH
