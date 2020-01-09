FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update && \
    apt-get install -y wget

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.7.10-Linux-x86_64.sh -O ~/miniconda.sh && \
  mkdir ~/.conda && \
  /bin/bash ~/miniconda.sh -b -p /opt/conda && \
  rm ~/miniconda.sh

RUN /opt/conda/bin/conda clean -tipy && \
  ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
  echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
  echo "conda activate base" >> ~/.bashrc && \
  find /opt/conda/ -follow -type f -name '*.a' -delete && \
  find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
  /opt/conda/bin/conda clean -afy

RUN addgroup conda && \
  chgrp -R conda /opt/conda && \
  chmod 770 -R /opt/conda

RUN /opt/conda/bin/conda install -y jupyter notebook && \
  /opt/conda/bin/jupyter notebook --generate-config

CMD [ "/bin/bash" ]
