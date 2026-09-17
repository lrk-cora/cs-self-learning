#!/usr/bin/env bash
count=0
logfile="output.log"
# 先清空旧日志，防止上次运行残留内容
> "$logfile"

while true; do
    count=$((count + 1))
    ./random_script.sh >> "$logfile" 2>&1
    ret=$?
    if [ $ret -ne 0 ]; then
        echo "脚本失败！一共运行了 $count 次"
        echo "===== 全部日志内容 ====="
        cat "$logfile"
        break
    fi
done