FROM vastai/pytorch
MAINTAINER Daisuke Shimamoto <diskshima@gmail.com>

RUN apt-get update && apt-get install -y \
  file \
  libmecab-dev \
  mecab \
  mecab-ipadic-utf8 \
  swig \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
  cd mecab-ipadic-neologd && \
  ./bin/install-mecab-ipadic-neologd -n -y -u -p "$(mecab-config --dicdir)/mecab-ipadic-neologd/"

RUN pip install -U pip

ARG fastai_ver=1.0.51
RUN pip install -U \
  fastai==$fastai_ver \
  jupyter \
  jupyter_contrib_nbextensions \
  jupyter_nbextensions_configurator \
  mecab-python3 \
  numpy \
  pandas \
  torch \
  torchvision

RUN jupyter contrib nbextension install --user && \
  jupyter nbextensions_configurator enable --user

CMD ["/bin/bash"]
