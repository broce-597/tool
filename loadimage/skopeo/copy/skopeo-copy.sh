#!/bin/bash
GREEN_COL="\\033[32;1m"
RED_COL="\\033[1;31m"
NORMAL_COL="\\033[0;39m"

SOURCE_REGISTRY=$1

# shell 变量赋值，当没有从命令行中传递值给SOURCE_REGISTRY变量时，便采用下述值进行覆盖。
: ${IMAGES_LIST_FILE:="images-list.txt"}
: ${SOURCE_REGISTRY:="registry.cn-hangzhou.aliyuncs.com"}

set -eo pipefail

CURRENT_NUM=0
ALL_IMAGES="$(sed -n '/#/d;s/:/:/p' ${IMAGES_LIST_FILE} | sort -u)"
TOTAL_NUMS=$(echo "${ALL_IMAGES}" | wc -l)
# skopeo copy --all docker://<docker-image-registry>/<image-repo>:<image-tag> oci-archive:<tar-name>.tar
# shopeo 拷贝函数，注意其传递的参数，此处值得学习记录。
skopeo_copy() {
 if skopeo copy --all docker://$1 oci-archive:$2.tar; then
  echo -e "$GREEN_COL Progress: ${CURRENT_NUM}/${TOTAL_NUMS} sync $1 to $2 successful $NORMAL_COL"
 else
  echo -e "$RED_COL Progress: ${CURRENT_NUM}/${TOTAL_NUMS} sync $1 to $2 failed $NORMAL_COL"
  exit 2
 fi
}

# 调用拷贝函数并记录当前执行序号。
for image in ${ALL_IMAGES}; do
 let CURRENT_NUM=${CURRENT_NUM}+1
 skopeo_copy ${SOURCE_REGISTRY}/${image} ${image#harmony-cloud/}
done