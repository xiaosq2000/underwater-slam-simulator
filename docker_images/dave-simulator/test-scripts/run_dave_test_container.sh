#!/bin/bash

HTTP_PROXY="http://127.0.0.1:1080"
HTTPS_PROXY="http://127.0.0.1:1080"

xhost +local:root
XSOCK=/tmp/.X11-unix

docker container rm -f dave_test_container

docker run \
    --name="dave_test_container" \
    --interactive \
    --detach \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="$XSOCK:$XSOCK:rw" \
    --runtime="nvidia" \
    --network="host" \
    --env http_proxy=$HTTP_PROXY \
    --env https_proxy=$HTTPS_PROXY \
    --env HTTP_PROXY=$HTTP_PROXY \
    --env HTTPS_PROXY=$HTTPS_PROXY \
    dave-simulator

docker cp /home/shuqi/underwater-slam/docker/dave-simulator/demo_description dave_test_container:/root/catkin_ws/src/

docker exec dave_test_container bash -c "echo 'export GAZEBO_RESOURCE_PATH=/root/catkin_ws/src/demo_description/:\$GAZEBO_RESOURCE_PATH' >> /root/.bashrc"
docker exec dave_test_container bash -c "cp /root/catkin_ws/src/demo_description/config/rexrov_sonar.xacro /root/catkin_ws/src/uuv_simulator/uuv_descriptions/robots/"
docker exec dave_test_container bash -c "cp /root/catkin_ws/src/demo_description/config/sonar_snippets.xacro /root/catkin_ws/src/uuv_simulator/uuv_sensor_plugins/uuv_sensor_ros_plugins/urdf/"
docker exec -it dave_test_container bash -ic "roslaunch demo_description demo.launch; bash -i"
