docker run -it --privileged \
  --net=host --name voxl_noetic_docker \
  -v /dev/ptmx:/opt/ptmx \
  -v /data/home_linaro:/root/home_linaro:rw \
  -w /root/ \
  arm64v8/noetic:bionic-noetic \
  /bin/bash
