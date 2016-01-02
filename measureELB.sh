#!/bin/bash

# 対象環境設定
env=$1
if ! ([ $1 = "stg" ] || [ $1 = "prd" ]); then
	exit 1
fi

# 対象アプリ
apps=("web" "evt")
# 対象指標の名称と集計タイプ
declare -A metrics
metrics=(["UnHealthyHostCount"]="Sum" ["RequestCount"]="Sum" ["SpilloverCount"]="Sum" ["HTTPCode_ELB_5XX"]="Sum" ["SurgeQueueLength"]="Maximum" ["HTTPCode_Backend_5XX"]="Sum" ["Latency"]="Maximum")

# 集計ターム
period=60

# 集計開始日時
start_time=$2
## 指定が無ければ1時間前
if [ -z ${start_time} ]; then
	start_time=`date -d '1 hour ago' -u --iso-8601=minutes|cut -d + -f1`
else
	start_time=`date -d "${start_time} hour ago" -u --iso-8601=minutes|cut -d + -f1`
fi
[ -z ${start_time} ] && exit 1

# 集計終了日時
end_time=$3
## 指定が無ければ実行日時
if [ -z ${end_time} ]; then
	end_time=`date -u --iso-8601=minutes |cut -d + -f1`
else
	end_time=`date -d "${end_time} hour ago" -u --iso-8601=minutes|cut -d + -f1`
fi
[ -z ${end_time} ] && exit 1

# 依存性確認
! type aws jq && exit 1

# 出力用ディレクトリ
output_dir="ELB_${env}_`date --iso-8601=minutes|cut -d + -f1`"
for app in ${apps[@]}; do
	! mkdir -p ./${output_dir}/${app} && exit 1
done;

# 指標をcsvファイルで取得
for app in ${apps[@]}; do \
for name in ${!metrics[@]}; do \
aws --profile ${env} \
cloudwatch get-metric-statistics --metric-name $name \
--period ${period} \
--start-time ${start_time} \
--end-time ${end_time} \
--namespace AWS/ELB \
--statistics ${metrics[$name]} \
--dimensions Name=LoadBalancerName,Value=tokuten-${app}-elb-${env} \
|jq -r ".Datapoints[]|[.Timestamp,.${metrics[$name]}]|@csv" |sort -n -t , -k 1  >> ${output_dir}/${app}/${name}.csv;
done;
done;
