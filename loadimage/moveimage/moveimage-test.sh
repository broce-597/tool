#!/bin/bash

HARBOR_FROM=$1
HARBOR_TO=$2
HARBOR_PASSWORD=Harbor12345

docker login $HARBOR_FROM --username admin --password $HARBOR_PASSWORD
if [ $? -eq 0  ]; then
  docker login $HARBOR_TO --username admin --password $HARBOR_PASSWORD
  if [ $? -eq 0  ]; then
    echo "成功"
  else
    echo -e "\033[31m失败\033[0m"
    exit 0
  fi
else
  echo -e "\033[31m失败\033[0m"
  exit 0
fi

echo "3333"
