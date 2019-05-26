#!/bin/sh
-e

#http://jollejolles.com/installing-ffmpeg-with-h264-support-on-raspberry-pi/
#https://www.reddit.com/r/raspberry_pi/comments/5677qw/hardware_accelerated_x264_encoding_with_ffmpeg/
#https://potluru.wordpress.com/2016/06/26/compile-ffmpeg-for-raspberry-pi-3/

cd ~/
rm -rf x264
git clone --depth 1 http://git.videolan.org/git/x264

cd x264
./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl
make -j4
sudo make install

cd ~/
rm -rf ffmpeg
git clone --depth 1 https://github.com/ffmpeg/ffmpeg

cd ffmpeg
sudo apt-get update
sudo apt-get install \
  autoconf \
  automake \
  build-essential \
  libass-dev \
  libfreetype6-dev \
  libsdl1.2-dev \
  libtheora-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  pkg-config \
  texinfo \
  zlib1g-dev \
  libomxil-bellagio-dev

./configure \
  --arch=armel \
  --target-os=linux \
  --enable-gpl \
  --enable-nonfree \
  --enable-mmal \
  --enable-omx \
  --enable-omx-rpi \
  --enable-libx264 \
  --enable-libfreetype
make -j4
sudo make install
