#!/bin/bash
state_running=`docker inspect -f '{{.State.Running}}' fastai-instance`
is_exist=$?

if [[ $is_exist == 1 ]]; then
  # Does not exist, create it.
  docker run -it -u $(id -u):$(id -g) -v $(realpath ~/playground/fastai/course-v3):/notebooks/course-v3 -p 8888:8888 --name fastai-instance fastai
elif [[ $state_running != "true" ]]; then
  # Exists but it's stopped
  docker start -i fastai-instance
else
  echo "fast.ai notebook is already running."
fi

