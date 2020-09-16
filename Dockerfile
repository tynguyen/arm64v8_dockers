FROM arm64v8/ros:melodic

RUN apt update  
RUN apt install -y python3-pip python-pip wget curl vim

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

# For now, doing the following:
#COPY tflite_runtime-2.1.0.post1-cp36-cp36m-linux_aarch64.whl /tmp
RUN python3 -m pip install ${tflite_pkg_name}
 
# Set up ROS environment (can leave this to the entry point?)
CMD echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
CMD source ~/.bashrc
