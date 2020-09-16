FROM arm64v8/ros:melodic

RUN apt update  
RUN apt install -y python3-pip python-pip wget curl vim man

# Upgrade pip to install opencv python
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install scikit-build cython

# Temperarily halt opencv installation
#RUN python3 -m pip install opencv-python

# Install python's packages 
# Required for Pillow
RUN apt-get install -y libjpeg-dev zlib1g-dev
RUN python3 -m pip install Pillow

# Install tflite
# Wget to download the wheel file, make sure download the correct file which is compatible with the python's version
#https://www.tensorflow.org/lite/guide/python. For example: 
ENV tflite_pkg_name https://dl.google.com/coral/python/tflite_runtime-2.1.0.post1-cp36-cp36m-linux_aarch64.whl
RUN curl ${tflite_pkg_name}

#COPY tflite_runtime-2.1.0.post1-cp36-cp36m-linux_aarch64.whl /tmp
RUN python3 -m pip install ${tflite_pkg_name}


# (Optional) Configure Vim
COPY cfg/.vim /root/
CMD git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim

 
# Set up ROS environment (can leave this to the entry point?)
CMD echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
# (optional) Shorten the current directory when working with the container
CMD echo "PROMPT_DIRTRIM=1" >> ~/.bashrc
CMD source ~/.bashrc

# (Optional) Install catkin_tools
CMD sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'

CMD wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
CMD apt update

# (Optional) Make sure permissions of /tmp is set appropriately
CMD chmod 1777 /tmp
CMD apt-get install -y python-catkin-tools
# In order to run catkin build, need to disable tty emulation option 
CMD sed '55has_pty=False' /usr/lib/python2.7/dist-packages/osrf_pycommon/process_utils/async_execute_process_trollius.py





