docker run -it --privileged \
  --net=host --name tynguyen_docker \
  -v /dev/ptmx:/opt/ptmx \
  -v /data/:/root/yoctohome/:rw \
  -w /root/ \
  arm64v8/ros:tmux \
  /bin/bash

