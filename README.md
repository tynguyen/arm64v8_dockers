# Docker images for Voxl Board

# Essential packages
- [x] ROS melodic (base)
- [x] Python3.6 and corresponding tensorflow lite 
- [x] Essential pythong packages: Pillow, Numpy, Cython
- [x] ROS catkin_tools (needs a hack to disable pty)

# Optional packages
- [x] Opencv-python: uncomment the corresponding line in Dockerfile to install

# Build an image
There are two ways to do it: either to build directly on the VOXL (slow method) or build on a host machine (even x86) (fast method) and then deploy to the VOXL

## Direct method
```
cd arm64v8_dockers
docker build -t <docker_image_name>:<tag_name> .
```
## Indirect method
Use [this tutorial](https://www.stereolabs.com/docs/docker/building-arm-container-on-x86/)
