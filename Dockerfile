# ffmpeg
#
# VERSION               2.8
#
# From https://trac.ffmpeg.org/wiki/CompilationGuide/Centos
#
# https://hub.docker.com/r/jrottenberg/ffmpeg/
#
#
FROM          phusion/passenger-ruby22:latest
MAINTAINER    Jian Peng <alucardpj@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

ENV           FFMPEG_VERSION=2.8.3 \
              YASM_VERSION=1.3.0   \
              OGG_VERSION=1.3.2    \
              VORBIS_VERSION=1.3.5 \
              THEORA_VERSION=1.1.1 \
              LAME_VERSION=3.99.5  \
              OPUS_VERSION=1.1     \
              FAAC_VERSION=1.28    \
              VPX_VERSION=1.4.0    \
              XVID_VERSION=1.3.4   \
              FDKAAC_VERSION=0.1.4 \
              X265_VERSION=1.8

WORKDIR       /tmp/workdir

# See https://github.com/jrottenberg/ffmpeg/blob/master/run.sh
COPY          run.sh /tmp/run.sh
RUN           /tmp/run.sh

# Let's make sure the app built correctly
# Convenient to verify on https://hub.docker.com/r/jrottenberg/ffmpeg/builds/
RUN           ffmpeg -buildconf

RUN           apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD           ["--help"]
ENTRYPOINT    ["ffmpeg"]
