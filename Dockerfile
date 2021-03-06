FROM ubuntu:16.04
MAINTAINER Eyevinn Technology <info@eyevinn.se>
RUN apt-get update && apt-get install -y --force-yes \
  autoconf \
  automake \
  build-essential \
  curl \
  git \
  apache2 \
  libapache2-mod-php \
  libass-dev \
  libcurl4-openssl-dev \
  libfreetype6-dev \
  libmp3lame-dev \
  libopus-dev \
  libtheora-dev \
  libtool \
  libvorbis-dev \
  libx264-dev \
  pkg-config \
  python2.7 \
  python2.7-dev \
  python-pip \
  scons \
  texinfo \
  vim \
  wget \
  yasm \
  cmake \
  mercurial \
  zlib1g-dev \
  gfortran \
  libhdf5-dev \
  liblapack-dev \
  python-setuptools \
  python-tk
RUN pip install --ignore-installed --upgrade pip
RUN pip install numpy scipy matplotlib notebook pandas sympy nose scikit-learn h5py
RUN mkdir /root/source
RUN mkdir /root/source/ffmpeg
RUN cd /root/source/ffmpeg && \ 
  wget -O fdk-aac.tar.gz https://github.com/mstorsjo/fdk-aac/tarball/master && \
  tar xzvf fdk-aac.tar.gz && \
  cd mstorsjo-fdk-aac* && \
  autoreconf -fiv && \
  ./configure --disable-shared && \
  make && \
  make install && \
  make distclean
RUN cd /root/source/ffmpeg && \
  wget http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.5.0.tar.bz2 && \
  tar xjvf libvpx-1.5.0.tar.bz2 && \
  cd libvpx-1.5.0 && \
  ./configure --disable-examples --disable-unit-tests && \
  make && \
  make install && \
  make clean 
RUN apt-get install -y --force-yes cmake-curses-gui
#RUN cd /root/source/ffmpeg && \
#  hg clone https://bitbucket.org/multicoreware/x265 && \
#  cd x265/build/linux && \
#  PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DENABLE_SHARED=off ../../source && \
#  make && make install
RUN cd /root/source/ffmpeg && \
  git clone https://github.com/Netflix/vmaf && \
  cd vmaf && \
  git submodule update --init --recursive && \
  make && \
  export PYTHONPATH="$(pwd)/python/src:$(pwd)/sureal/python/src:$PYTHONPATH" && \
  make install 
RUN mkdir -p /root/source/ffmpeg/libaom && \
  cd /root/source/ffmpeg/libaom && \
  git clone https://aomedia.googlesource.com/aom && \
  cmake ./aom && \
  make && \
  make install
RUN cd /root/source/ffmpeg && \
  wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
  tar xjvf ffmpeg-snapshot.tar.bz2 && \
  cd ffmpeg && \
  ./configure \
    --pkg-config-flags="--static" \
    --enable-gpl \
    --enable-libass \
    --enable-libfdk-aac \
    --enable-libfreetype \
    --enable-libmp3lame \
    --enable-libopus \
    --enable-libtheora \
    --enable-libvorbis \
    --enable-libvpx \
    --enable-libx264 \
#    --enable-libx265 \
    --enable-libaom \
    --enable-version3 \
    --enable-libvmaf \
    --enable-nonfree && \
  make && \
  make install && \
  make distclean && \
  hash -r
RUN cd /root/source/ && \
  git clone https://github.com/axiomatic-systems/Bento4.git && \
  cd /root/source/Bento4/ && \
  scons -u build_config=Release
COPY build/install-bento4.sh /root/build/
RUN /root/build/install-bento4.sh
#RUN pip install hls2dash
#RUN pip install hlsorigin
ADD toolbelt/motd /etc/motd
ADD toolbelt/bash.bashrc /etc/bash.bashrc
RUN useradd -m -p changeme -s /bin/bash eyevinn
