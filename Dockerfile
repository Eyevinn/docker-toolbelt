FROM ubuntu:14.04
MAINTAINER Eyevinn Technology <info@eyevinn.se>
RUN apt-get update && apt-get install -y --force-yes \
  autoconf \
  automake \
  build-essential \
  curl \
  git \
  apache2 \
  libapache2-mod-php5 \
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
  zlib1g-dev
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
RUN pip install hls2dash
ADD toolbelt/motd /etc/motd
ADD toolbelt/bash.bashrc /etc/bash.bashrc
RUN useradd -m -p changeme -s /bin/bash eyevinn
