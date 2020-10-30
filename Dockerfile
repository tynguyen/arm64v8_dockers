FROM arm64v8/ros:melodic

ARG ROS_DISTRO=melodic

RUN apt-get update  
RUN apt-get install -y python3-pip python-pip wget curl vim man tmux

# Upgrade pip to install opencv python
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install scikit-build cython

# Temperarily halt opencv installation
#RUN python3 -m pip install opencv-python

# Install python's packages 
# Required for Pillow
RUN apt-get install -y libjpeg-dev zlib1g-dev
RUN python3 -m pip install Pillow

#Install Xbee python pacakges
python3 -m pip install digi-xbee
python3 -m pip install pyserial
python3 -m pip install rospkg

# Install tflite
# Wget to download the wheel file, make sure download the correct file which is compatible with the python's version
#https://www.tensorflow.org/lite/guide/python. For example: 
ARG tflite_pkg_name="https://dl.google.com/coral/python/tflite_runtime-2.1.0.post1-cp36-cp36m-linux_aarch64.whl"
RUN wget ${tflite_pkg_name}

#COPY tflite_runtime-2.1.0.post1-cp36-cp36m-linux_aarch64.whl /tmp
RUN python3 -m pip install ${tflite_pkg_name}


# (Optional) Configure Vim
RUN mkdir -p /root/.vim
ADD cfg/.vim /root/.vim
RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim

 
# Set up ROS environment (can leave this to the entry point?)
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

# (Optional) Install catkin_tools
#RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'
#RUN wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
#RUN rm /etc/apt/sources.list.d/ros1-latest.list
RUN apt-get update
# Make sure permissions of /tmp is set appropriately
RUN chmod 1777 /tmp
RUN apt-get install -y python-catkin-tools
# In order to run catkin build, need to disable tty emulation option 
RUN sed -i "/55/ i has_pty=False" /usr/lib/python2.7/dist-packages/osrf_pycommon/process_utils/async_execute_process_trollius.py

# Install cv-bridge which is missed from the arm64v8/ros:$ROS_DISTRO image
RUN apt-get install -y ros-$ROS_DISTRO-cv-bridge

# Install another packages here.....

# Install ROS package dependencies
RUN apt-get install -y libeigen3-dev libsuitesparse-dev protobuf-compiler libnlopt-dev libyaml-cpp-dev

# Install additional ROS packages
RUN apt-get install -y ros-$ROS_DISTRO-pcl-ros
RUN apt-get install -y ros-$ROS_DISTRO-eigen-conversions ros-$ROS_DISTRO-tf2-eigen ros-$ROS_DISTRO-tf2-ros ros-$ROS_DISTRO-tf2-geometry-msgs ros-$ROS_DISTRO-tf2-tools ros-$ROS_DISTRO-tf-conversions ros-$ROS_DISTRO-octomap-ros ros-$ROS_DISTRO-octomap ros-$ROS_DISTRO-octomap-ros ros-$ROS_DISTRO-sophus ros-$ROS_DISTRO-angles ros-$ROS_DISTRO-cv-bridge ros-$ROS_DISTRO-image-transport

#Install throughput/signal packages
RUN apt-get install -y iperf3 traceroute wireless-tools

# End installing packages .... 

#Fix tmux issue
CMD ln -sf /opt/ptmx /dev/ptmx

# (optional) Shorten the current directory when working with the container
CMD echo "PROMPT_DIRTRIM=1" >> ~/.bashrc

# Source ros each time a container is run
CMD echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

CMD source ~/.bashrc





