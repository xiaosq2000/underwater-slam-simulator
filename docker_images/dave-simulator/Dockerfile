FROM ros-noetic-nvidia-accelerated

LABEL maintainer="xiaosq2000@gmail.com"

USER root
SHELL ["/bin/bash", "-c"]

RUN echo "Acquire::http::proxy \"${HTTP_PROXY}\";" >> /etc/apt/apt.conf && \
    echo "Acquire::https::proxy \"${HTTP_PROXY}\";" >> /etc/apt/apt.conf

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
        dbus-x11 \
        libgles2-mesa-dev \
        git \
        python3-vcstool \
        vim \
        curl \
        wget \
        cppcheck \
        python3-dbg \
        python3-pip \
        python3-venv \
        software-properties-common && \
rm -rf /var/lib/apt/lists/*

RUN git config --global http.proxy ${HTTP_PROXY} && \
    git config --global https.proxy ${HTTPS_PROXY}

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
        python3-catkin-tools \
        python3-rosinstall-generator \
        ros-noetic-effort-controllers \
        ros-noetic-geographic-info \
        ros-noetic-hector-gazebo-plugins \
        ros-noetic-joy \
        ros-noetic-joy-teleop \
        ros-noetic-kdl-parser-py \
        ros-noetic-key-teleop \
        ros-noetic-move-base \
        ros-noetic-moveit-commander \
        ros-noetic-moveit-planners \
        ros-noetic-moveit-simple-controller-manager \
        ros-noetic-moveit-ros-visualization \
        ros-noetic-robot-localization \
        ros-noetic-ros-controllers \
        ros-noetic-teleop-tools \
        ros-noetic-teleop-twist-joy \
        ros-noetic-teleop-twist-keyboard \
        ros-noetic-tf2-tools \
        ros-noetic-urdfdom-py \
        ros-noetic-velodyne-gazebo-plugins \
        ros-noetic-velodyne-simulator && \
rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/catkin_ws/src 
WORKDIR /root/catkin_ws

RUN cd src && \
    git clone https://github.com/Field-Robotics-Lab/dave.git && \
    sed -i 's/git\@github\.com\:/https\:\/\/github\.com\//' dave/extras/repos/dave_sim.repos && \
    sed -i 's/git\@github\.com\:/https\:\/\/github\.com\//' dave/extras/repos/multibeam_sim.repos && \
    sed -i '9s/main/129e1e0f04000397eb91cf812ada04904987ed94/' dave/extras/repos/multibeam_sim.repos && \
    vcs import --skip-existing --input dave/extras/repos/dave_sim.repos && \
    vcs import --skip-existing --input dave/extras/repos/multibeam_sim.repos

RUN source /opt/ros/${ROS_DISTRO}/setup.bash && \
    source /usr/share/gazebo-11/setup.sh && \
    catkin_make install

RUN rm /ros_entrypoint.sh
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD ["bash"]