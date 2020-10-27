docker run -it --privileged \
  --net=host --name voxl_melodic_docker \
  -v /dev/ptmx:/opt/ptmx \
  -v /data/:/root/yoctohome/:rw \
  -w /root/ \
  arm64v8/ros:voxl_melodic \
  /bin/bash

