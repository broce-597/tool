#!/bin/bash

HARBOR_FROM=$1
HARBOR_TO=$2
HARBOR_PASSWORD=Harbor12345

docker login $HARBOR_FROM --username admin --password $HARBOR_PASSWORD
docker login $HARBOR_TO --username admin --password $HARBOR_PASSWORD

NUMBER=`awk 'END{print NR}' image.txt`
echo -e "\033[36m镜像数量$NUMBER个\033[0m"

for ((i=1; i<=$NUMBER; i++));
do
  imageTag=`awk -v val=$i 'NR==val{print}' image.txt`
  echo -e "\033[36m第$i个镜像 镜像tag名称:$imageTag\033[0m"

  echo -e "\033[36m拉取镜像$HARBOR_FROM/$imageTag\033[0m"
  docker pull $HARBOR_FROM/$imageTag
  
  echo -e "\033[36m修改原镜像tag:$HARBOR_FROM/$imageTag 为$HARBOR_TO/$imageTag\033[0m"
  docker tag $HARBOR_FROM/$imageTag $HARBOR_TO/$imageTag
  
  echo -e "\033[36m上传镜像$HARBOR_TO/$imageTag\033[0m"
  docker push $HARBOR_TO/$imageTag
  
  echo -e "\033[36m清除本地镜像$HARBOR_FROM/$imageTag及$HARBOR_TO/$imageTag\033[0m"
  docker rmi $HARBOR_FROM/$imageTag $HARBOR_TO/$imageTag

done
