#!/bin/bash

image_ids=$(docker images -q j2fps15)

if [ -z "$image_ids" ]; then
  echo "Không có hình ảnh 'j2fps15' để xóa."
  exit 0
fi

for id in $image_ids; do
  docker rmi -f $id
done

docker build -t 'j2fps15:1.1' .

mkdir -p ./build
docker save -o ./build/j2fps15:1.1.tar j2fps15:1.1