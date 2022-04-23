### moveimage使用说明

该脚本用于将指定harbor的镜像批量迁移到另一个harbor，需要事先知道harbor的IP地址，需要在image.txt文件中写上需要迁移的镜像tag名称，tag名称必须带仓库名及版本号，例如：k8s-deploy/alpine:latest 不要有多余的行存在
执行方法：./moveimage.sh 源Harbor 目标Harbor
例如：./moveimage.sh 10.1.10.89 10.1.11.19
