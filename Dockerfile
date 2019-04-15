FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

arg caffe_version=1.0
arg protobuf_version=3.6.1
arg openpose_version=1.4.0

# Openpose Requirements
run apt-get update -y && apt-get upgrade -y

# Install Utilities
run apt-get install -y apt-utils
run apt-get install -y unzip lsof apt-utils lsb-core libatlas-base-dev curl

# Install Build Tools/Essentials
run apt-get install -y cmake make g++ autoconf automake libtool

# Install Boost, HD5 & Glog (Google's logger)
run apt-get install -y libgoogle-glog-dev libboost-all-dev libhdf5-serial-dev

# Install OpenCV
run apt-get install -y python-pip libopencv-dev python-opencv

# Downloading protobuf
run curl -o protobuf.zip -L https://github.com/protocolbuffers/protobuf/releases/download/v$protobuf_version/protobuf-all-$protobuf_version.zip
run unzip protobuf.zip && rm protobuf.zip
run mv protobuf-$protobuf_version protobuf

workdir protobuf

# Installing protobuf
run ./configure
run make
run make check
run make install
run ldconfig

workdir /

# Downloading openpose
RUN curl -o openpose.zip -L https://github.com/CMU-Perceptual-Computing-Lab/openpose/archive/master.zip
run unzip openpose.zip && rm openpose.zip
run mv openpose-master openpose

workdir /openpose

# Donwloading caffe
run curl -o caffe.zip -L https://github.com/CMU-Perceptual-Computing-Lab/caffe/archive/master.zip
run unzip caffe.zip && rm caffe.zip
run mv caffe-master/* 3rdparty/caffe
run rm -rf caffe-master

# Installing openpose (and caffe)
RUN mkdir build
run cd build

workdir /openpose/build
run cmake ..
run make -j`nproc`
run make install

workdir /openpose
