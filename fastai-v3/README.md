This container pulls the latest fast.ai class. You can find this repo here: https://github.com/fastai/fastai and you can learn more about the Fast.ai course here: http://course.fast.ai/

This dockerfile pins the fastai "course-v3" repository to the commit hash: 2d532e82517a8b528b351fa6b2da985da0affe8b representing the master branch as of 1/24/2019

## Requirements:

[Docker CE](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)

[NVIDIA-docker](https://github.com/NVIDIA/nvidia-docker)

Nvidia Drivers


## Build


`docker build -t fastai .`

## Pre-built runtimes

You can also just run the following without having to build the entire container yourself. This will pull the container from Docker Hub.

`docker run --runtime=nvidia -d -p 8888:8888 fastai`
