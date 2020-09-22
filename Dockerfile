FROM arm64v8/ubuntu:bionic

RUN apt update  
RUN apt install -y python3 python3-dev python3-pip build-essential
RUN apt install -y python-pip wget curl vim man

# Upgrade pip to install opencv python
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install scikit-build cython

# Temperarily halt opencv installation
#RUN python3 -m pip install opencv-python

##############
# Install ROS
# Add sudo to sudoer list to run sudo Pip3 later on 
#RUN adduser --disabled-password --gecos '' root 
#RUN adduser docker sudo
#RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# Temporarily, run with python3
RUN python3 -m pip install rosdep rospkg rosinstall_generator rosinstall wstool vcstools catkin_tools catkin_pkg
RUN rosdep init 
RUN rosdep update
RUN mkdir -p /root/catkin_ws
RUN cd /root/catkin_ws
RUN catkin config --init -DCMAKE_BUILD_TYPE=Release --install
RUN rosinstall_generator ros_base --rosdistro melodic --deps --tar > melodic-ros-base.rosinstall
RUN wstool init -j8 src melodic-ros-base.rosinstall
RUN export ROS_PYTHON_VERSION=3
RUN apt-get install -y libgtk-3-dev
RUN python3 -m pip install -U -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-18.04 wxPython
ADD cfg/install_skip_for_ROS.sh /tmp/install_skip.sh
RUN ./install_skip `rosdep check --from-paths src --ignore-src | grep python | sed -e "s/^apt\t//g" | sed -z "s/\n/ /g" | sed -e "s/python/python3/g"`
RUN rosdep install --from-paths src --ignore-src -y --skip-keys="`rosdep check --from-paths src --ignore-src | grep python | sed -e "s/^apt\t//g" | sed -z "s/\n/ /g"`"
RUN find . -type f -exec sed -i 's/\/usr\/bin\/env[ ]*python/\/usr\/bin\/env python3/g' {} +
RUN catkin build
##############

## Install python's packages 
## Required for Pillow
#RUN apt-get install -y libjpeg-dev zlib1g-dev
#RUN python3 -m pip install Pillow
#
## Install tflite
## Wget to download the wheel file, make sure download the correct file which is compatible with the python's version
##https://www.tensorflow.org/lite/guide/python. For example: 
#ARG tflite_pkg_name="https://dl.google.com/coral/python/tflite_runtime-2.1.0.post1-cp36-cp36m-linux_aarch64.whl"
#RUN wget ${tflite_pkg_name}
#
##COPY tflite_runtime-2.1.0.post1-cp36-cp36m-linux_aarch64.whl /tmp
#RUN python3 -m pip install ${tflite_pkg_name}
#
#
## (Optional) Configure Vim
#RUN mkdir -p /root/.vim
#ADD cfg/.vim /root/.vim
#RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim
#
#
# 
## Set up ROS environment (can leave this to the entry point?)
#RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
#
## (Optional) Install catkin_tools
#RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'
#RUN wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
#RUN rm /etc/apt/sources.list.d/ros1-latest.list
#RUN apt update
## Make sure permissions of /tmp is set appropriately
#RUN chmod 1777 /tmp
#RUN apt-get install -y python-catkin-tools
## In order to run catkin build, need to disable tty emulation option 
#RUN sed -i "/55/ i has_pty=False" /usr/lib/python2.7/dist-packages/osrf_pycommon/process_utils/async_execute_process_trollius.py
#
## Install cv-bridge which is missed from the arm64v8/ros:melodic image
#RUN apt-get install -y ros-melodic-cv-bridge
#
## Install another packages here.....
#
#
#
#
#
#
#
## End installing packages .... 
#
## (optional) Shorten the current directory when working with the container
#CMD echo "PROMPT_DIRTRIM=1" >> ~/.bashrc
#
## Source ros each time a container is run
#CMD echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
#
#CMD source ~/.bashrc
#




