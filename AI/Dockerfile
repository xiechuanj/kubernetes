FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu14.04
LABEL maintainer xiechuanj@gmail.com

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN locale-gen zh_CN.UTF-8 &&\
  DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
RUN locale-gen zh_CN.UTF-8  
ENV LANG zh_CN.UTF-8  
ENV LANGUAGE zh_CN:zh  
ENV LC_ALL zh_CN.UTF-8 

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        vim \
        sudo \
        openssh-server \
        openssh-client \
        libatlas-base-dev \
        libboost-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libopencv-dev \
        libprotobuf-dev \
        libsnappy-dev \
        protobuf-compiler \
        python-dev \
        python-numpy \
        python-pip \
        python-setuptools \
        python-scipy && \
    rm -rf /var/lib/apt/lists/*


ARG user=caffe
ARG group=caffe
ARG uid=1000
ARG gid=1000

ENV CAFFE_HOME /workspace
RUN groupadd -g ${gid} ${group} \
    && useradd -d "$CAFFE_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}


RUN set -x \
    && chmod 777 /etc/sudoers \
    && echo "caffe   ALL=(ALL:ALL) NOPASSWD:NOPASSWD:ALL" >/etc/sudoers \
    && chmod 440 /etc/sudoers 

RUN echo 'caffe:caffe' |chpasswd
RUN mkdir /var/run/sshd

USER ${user}

WORKDIR /workspace

#cudnn
COPY cudnn-8.0-v5.1.tar.gz ./
RUN sudo tar zxvf cudnn-8.0-v5.1.tar.gz -C /usr/local/

#openmpi
COPY openmpi-2.0.0.tar.gz ./
RUN set -x \
    && tar zxvf openmpi-2.0.0.tar.gz \
    && cd openmpi-2.0.0 \
    && sudo ./configure --with-cuda --enable-mpi-thread-multiple --prefix=/usr/local/mpi \
    && sudo make -j"$(nproc)" all \
    && sudo make install \
    && cd ..

ENV PATH /usr/local/mpi/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/mpi/lib:$LD_LIBRARY_PATH

#nccl
RUN set -x \
    &&  git clone https://github.com/NVIDIA/nccl.git \
    &&  cd nccl \
    &&  sudo make CUDA_HOME=/usr/local/cuda test \
    &&  sudo make PREFIX=/usr/local/nccl install \
    &&  cd .. 

ENV PATH /usr/local/nccl/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/nccl/lib:$LD_LIBRARY_PATH


ENV CAFFE_ROOT=/workspace

WORKDIR $CAFFE_ROOT

#caffe
RUN git clone https://github.com/yjxiong/caffe.git 
RUN mkdir $CAFFE_ROOT/caffe/build 
WORKDIR $CAFFE_ROOT/caffe/build 
#RUN cmake .. -DUSE_MPI=ON -DUSE_CUDNN=OFF 
#RUN make -j"$(nproc)" all

#ENV PYCAFFE_ROOT $CAFFE_ROOT/caffe/python
#ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/caffe/build/tools:$PATH
#RUN sudo touch /etc/ld.so.conf.d/caffe.conf && sudo chmod 777 /etc/ld.so.conf.d/caffe.conf
#RUN sudo echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && sudo ldconfig
COPY *.sh ./
 


ENTRYPOINT sh install.sh && sudo /usr/sbin/sshd -D  && ping localhost>null
