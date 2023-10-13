#! /bin/bash
docker stop test_image_arm
docker rm test_image_arm
docker image rm test_cross_arch

