#!/usr/bin/env bash


set -e
    
docker build \
    --rm \
    --network=host \
    --build-arg=HTTP_PROXY=$http_proxy \
    --build-arg=HTTPS_PROXY=$https_proxy \
    --tag slam-hive-algorithm:ndt-loam \
    --file Dockerfile .

echo "已构建新镜像"

    # --network=host \
    # --build-arg=HTTP_PROXY=$http_proxy \
    # --build-arg=HTTPS_PROXY=$https_proxy \
    
    
# 构建过程中遇到的问题
# 1 gpg问题：记录在docker文件夹里的对应脚本里（去dockerfile里找）
# 2 镜像构建完成（install脚本里最后两行被注释掉了 应该加在里面）
  # 1 编译aloam时候的问题
    # 1 找不到opencv4/opencv2/...
    # 解决：创建opencv4文件夹，将opencv2软连接过去
    # mkdir /usr/include/opencv4
    # ln -s /usr/include/opencv2 /usr/include/opencv4/opencv2
