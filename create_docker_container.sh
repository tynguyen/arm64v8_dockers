docker run -it --privileged \
  --net=host --name voxl_melodic_docker \
  -v /dev/ptmx:/opt/ptmx \
  -v /data/home_linaro:/root/home_linaro:rw \
  -w /root/ \
  arm64v8/melodic:bionic-melodic \
  /bin/bash

