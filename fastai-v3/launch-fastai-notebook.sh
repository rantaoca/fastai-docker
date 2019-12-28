#!/bin/bash
state_running=`docker inspect -f '{{.State.Running}}' fastai-instance > /dev/null 2>&1`
is_exist=$?

if [[ $is_exist == 1 ]]; then
  # Does not exist, create it.

  # The following parameters:
  # --gpus all
  #    Use all GPUs
  # -it
  #    Run docker interactively.
  # -u $(id -u):$(id -g)
  #    Run docker with the current user, so we can modify mounted directory.
  # --ipc=host
  #    Set interprocess communication to use the host's IPC namespace. This is
  #    to fix a bug where the DataLoader with multiple workers.
  # -v host_path:docker_path
  #    Mount the directory.
  # -p 8888:8888
  #    Port forward the notebook.
  # --name fastai-instance
  #    Name the container.
  docker run --gpus all -it -u $(id -u):$(id -g) --ipc=host -v $(realpath ~/playground/fastai/course-v3):/notebooks/course-v3 -p 8888:8888 --name fastai-instance fastai
elif [[ $state_running != "true" ]]; then
  # Exists but it's stopped
  docker start -i fastai-instance
else
  echo "fast.ai notebook is already running."
fi

