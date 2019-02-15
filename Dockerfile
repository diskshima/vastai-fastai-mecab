FROM vastai/pytorch
MAINTAINER Daisuke Shimamoto

RUN apt-get update && apt-get install -y \
  file \
  libmecab-dev \
  mecab \
  mecab-ipadic-utf8 \
  swig \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
  cd mecab-ipadic-neologd && \
  ./bin/install-mecab-ipadic-neologd -n -y -u -p "$(mecab-config --dicdir)"

RUN pip install -U pip
RUN pip install -U \
  fastai \
  mecab-python3 \
  numpy \
  pandas \
  torch

CMD ["/bin/bash"]
