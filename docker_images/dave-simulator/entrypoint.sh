#!/bin/bash
set -e

ln -s /usr/bin/python3 /usr/bin/python
echo "source /opt/ros/noetic/setup.sh" >> /root/.bashrc
echo "source /usr/share/gazebo-11/setup.sh" >> /root/.bashrc
echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc

exec "$@"
