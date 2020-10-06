# Docker images for Voxl Board

# Essential packages
- [x] ROS melodic (base)
- [x] Python3.6 and corresponding tensorflow lite 
- [x] Essential pythong packages: Pillow, Numpy, Cython
- [x] ROS catkin_tools (needs a hack to disable pty)

# Optional packages
- [x] Opencv-python: uncomment the corresponding line in Dockerfile to install

# Prerequisites to build docker image
``` 
sudo apt install binfmt-support
sudo apt install qemu-user-static android-tools-adb android-tools-fastboot
```

# Build

`docker build -t <image_name>:<tag_name> .`
