#!/bin/bash

image_ids=$(docker images -q j2fps15-arm)

if [ "$image_ids" ]; then
  for id in $image_ids; do
    docker rmi -f $id
  done
fi

docker build -f Dockerfile.arm -t 'j2fps15-arm:1.3' .

mkdir -p ./build
docker save -o ./build/j2fps15-arm:1.3.tar j2fps15-arm:1.3