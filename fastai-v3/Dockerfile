FROM nvidia/cuda:10.1-base-ubuntu18.04
# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8
LABEL com.nvidia.volumes.needed="nvidia_driver"

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         vim \
         ca-certificates \
         python-qt4 \
         libjpeg-dev \
         zip \
         unzip \
         libpng-dev &&\
     rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV PYTHON_VERSION=3.6

RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
    /opt/conda/bin/conda install conda-build

ENV PATH=$PATH:/opt/conda/bin/

# Create user and home directory.
# This is necessary so we can run the notebook as current user and edit files
# that we mount. Otherwise, the files that are edited would belong to root.
ENV USER fastai
ENV UID 1000
ENV HOME /home/$USER
RUN groupadd -r -g $UID $USER && useradd -u $UID -g $USER --create-home --home-dir $HOME $USER && chown -R $USER:$USER $HOME

# Create Enviroment
COPY enviroment.yaml /enviroment.yaml
RUN conda env create -f enviroment.yaml

WORKDIR /notebooks
# Activate Source
CMD source activate fastai
CMD source ~/.bashrc

RUN chmod -R a+w /notebooks
WORKDIR /notebooks

COPY config.yml /root/.fastai/config.yml
COPY run.sh /run.sh

CMD ["/run.sh"]
