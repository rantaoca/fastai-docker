#!/bin/bash
docker run -it --rm -u $(id -u):$(id -g) -v $(realpath ~/playground/fastai/course-v3):/notebooks/course-v3 -p 8888:8888 fastai

