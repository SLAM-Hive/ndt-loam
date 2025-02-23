#!/usr/bin/env bash

set -e
# Change apt source to Tsinghua University mirror
# sed -i "s@http://archive.ubuntu.com/ubuntu/@https://mirrors.tuna.tsinghua.edu.cn/ubuntu/@g" /etc/apt/sources.list
# sed -i "s@http://packages.ros.org/ros/ubuntu@http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu@g" /etc/apt/sources.list.d/ros1-latest.list
#sh -c '. /etc/lsb-release && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AD19BAB3CBF125EA 
# 楼上这句话是因为：gpg报错 这个A1...的签名不合法
apt-get update \
    && apt-get install -y curl \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \


apt-get update 
apt-get install -y --no-install-recommends \
    wget nano build-essential unzip \
    cmake python-catkin-tools \
    ros-melodic-geodesy ros-melodic-pcl-ros ros-melodic-nmea-msgs ros-melodic-rviz ros-melodic-tf-conversions \
    ros-melodic-cv-bridge \
    libgoogle-glog-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev 
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

# copy and unzip lib file
mkdir -p /home/chenshoubin/slam_ws/src && cd /home/chenshoubin/slam_ws/src
#git clone https://github.com/BurryChen/A-LOAM.git 
#git clone https://github.com/BurryChen/lv_slam.git 
cp -r /tmp/lv_slam .
cp -r /tmp/A-LOAM .
mkdir -p /home/chenshoubin/tools && cd /home/chenshoubin/tools
cp -r ../slam_ws/src/lv_slam/3rdtools/*.zip .
cp -r ../slam_ws/src/lv_slam/3rdtools/*.gz .

tar -xzvf ceres-solver-1.14.0.tar.gz
unzip DBow3-master.zip 
unzip g2o-a48ff8c.zip
unzip Sophus-a621ff2-ubuntu18.04.zip

    cd ./ceres-solver-1.14.0
    mkdir build && cd build
    cmake ..
    make -j8 install
    cd ../../
      
    cd ./DBow3
    mkdir build && cd build
    cmake ..
    make -j8 install
    cd ../../
    
    cd ./g2o
    mkdir build && cd build
    cmake  ..
    make -j8 install
    cd ../../
      
    cd ./Sophus
    mkdir build && cd build
    cmake ..
    make -j8 install
    cd ../../
      
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
source /opt/ros/melodic/setup.bash
cd /home/chenshoubin/slam_ws
catkin_make
#catkin_make -DCATKIN_WHITELIST_PACKAGES="A-LOAM" --build='./build/A-LOAM' -DCATKIN_DEVEL_PREFIX=./devel -DCMAKE_INSTALL_PREFIX=./install
#catkin_make -DCATKIN_WHITELIST_PACKAGES="lv_slam" --build='./build/lv_slam' -DCATKIN_DEVEL_PREFIX=./devel -DCMAKE_INSTALL_PREFIX=./install

apt update
apt-get install -y python3-pip
pip3 install evo --upgrade --no-binary evo
apt install -y python3-tk
