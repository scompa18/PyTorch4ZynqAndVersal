#! /bin/bash
docker build -t test_cross_arch .
docker create -it --name test_image_arm --platform linux/arm64 test_cross_arch
docker start test_image_arm
docker exec -it test_image_arm /bin/bash
