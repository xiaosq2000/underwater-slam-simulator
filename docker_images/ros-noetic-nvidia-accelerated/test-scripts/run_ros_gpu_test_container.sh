#!/bin/bash

httpProxy="http://127.0.0.1:1080"
httpsProxy="https://127.0.0.1:1080"

xhost +local:root
XSOCK=/tmp/.X11-unix

docker container stop ros_gpu_test_container
docker container rm ros_gpu_test_container

docker run \
    -id \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="$XSOCK:$XSOCK:rw" \
    --runtime=nvidia \
    --network="host" \
    --env http_proxy=$httpProxy \
    --env https_proxy=$httpsProxy \
    --env HTTP_PROXY=$httpProxy \
    --env HTTPS_PROXY=$httpsProxy \
    --name="ros_gpu_test_container" \
    ros-noetic-nvidia-accelerated

docker cp env.sh ros_gpu_test_container:/root
docker exec ros_gpu_test_container bash -c /root/env.sh

docker exec -it ros_gpu_test_container bash -i
