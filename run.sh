#!/bin/bash
# bash container.sh -n project_name

REMOVE='--rm'
while getopts rn: option
do
case "${option}"
in
r) REMOVE='--rm' ;;
n) NAME='--name='${OPTARG} ;;
esac
done

docker run ${REMOVE} \
           -it \
           --net host \
           ${NAME:-"--name=miniconda3"} \
           --mount type=bind,source=$HOME/yys,target=/workbench \
           --mount type=bind,source=/mnt/sdb1/data,target=/home/data \
           yys8646/miniconda3:latest \
           /bin/bash
