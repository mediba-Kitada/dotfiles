#!/bin/bash

# 対象環境設定
env=$1
if ! ([ $1 = "stg" ] || [ $1 = "prd" ]); then
	exit 1
fi

# 対象指標の名称と集計タイプ
declare -A metrics
metrics=(["UnHealthyHostCount"]="Sum" ["RequestCount"]="Sum" ["SpilloverCount"]="Sum" ["HTTPCode_ELB_5XX"]="Sum" ["SurgeQueueLength"]="Maximum" ["HTTPCode_Backend_5XX"]="Sum")

# 集計ターム
period=60

# 集計開始時間
start_time=$2
## 指定が無ければ1時間前
if [ -z $start_time ]; then
	start_time=`date -d '1 hour ago' -u --iso-8601=minutes|cut -d + -f1`
else
	start_time=`date -d "${start_time}" -u --iso-8601=minutes|cut -d + -f1`
fi
[ -z ${start_time} ] && exit 1

# 依存性確認
! type aws jq && exit 1

# 一時間の指標をcsvファイルで取得
for name in ${!metrics[@]}; do \
aws --profile ${env} \
cloudwatch get-metric-statistics --metric-name $name \
--period ${period} \
--start-time ${start_time} \
--end-time `date -u --iso-8601=minutes |cut -d + -f1` \
--namespace AWS/ELB \
--statistics ${metrics[$name]} \
--dimensions Name=LoadBalancerName,Value=tokuten-web-elb-${env} \
|jq -r ".Datapoints[]|[.Timestamp,.${metrics[$name]}]|@csv" |sort -n -t , -k 1  >> `date --iso-8601=minutes|cut -d + -f1`_${name}.csv;
done;
