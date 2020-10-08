# Docker images for Voxl Board

# Essential packages
- [x] ROS melodic (base)
- [x] Python3.6 and corresponding tensorflow lite 
- [x] Essential pythong packages: Pillow, Numpy, Cython
- [x] ROS catkin_tools (needs a hack to disable pty)

# Optional packages
- [x] Opencv-python: uncomment the corresponding line in Dockerfile to install

# Prerequisites 
``` 
sudo apt install binfmt-support
sudo apt install qemu-user-static android-tools-adb android-tools-fastboot
```
---
# Build
There are two ways to build and run: onboard (VOXL) and on x86 machines (laptop, desktop...)
## Build on board

`docker build -t <image_name>:<tag_name> .`

## Build on an x86 machine
Make sure the you've installed the prerequisites 
```
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```

```
bash build_docker.sh
```

---
# Usage
## Create a container
```
bash create_docker_container.sh
```
Make sure the name of the docker image and the container are satisfied.

## Attach to a running container
```
bash attach_docker_container.sh
```
