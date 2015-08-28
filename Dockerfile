FROM ubuntu:14.04
# FROM debian

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl
RUN apt-get install -y cmake
RUN apt-get install -y software-properties-common
RUN apt-get install -y flex
RUN apt-get install -y bison
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y libreadline6-dev
RUN apt-get install -y gcc
RUN apt-get install -y make
RUN apt-get install -y pgxnclient
RUN apt-get install -y python-dev
RUN apt-get install -y git-core
# RUN apt-get install -y supervisor
# RUN apt-get install -y vim
# RUN apt-get install -y rsync
# RUN apt-get install -y screen 
# RUN apt-get install -y tmux 


# build-essential \
# git-core \
# git \
# vim \
# screen \
# gnumake \
# rsync \
# llvm \
# libffi-dev \
# libncurses5-dev \
# libsqlite3-dev \
# libbz2-dev \
# supervisor \
# libssl-dev \

# RUN \
# apt-get update \
# && \
# apt-get install -y --no-install-recommends \
# ca-certificates \
# wget \
# curl \
# cmake \
# software-properties-common \ 
# flex \
# bison \
# zlib1g-dev \
# libreadline6-dev \
# gcc \
# make \
# python-dev \
# pgxnclient \
# && \
# apt-get clean \
# && \
# rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ADD ./Postgres-XL /Postgres-XL
RUN git clone --depth 1 https://github.com/techdragon/Postgres-XL.git

WORKDIR /Postgres-XL
RUN ./configure --with-python --prefix /opt/pgxl
RUN make -j 4
WORKDIR /Postgres-XL/contrib
RUN make -j 4
WORKDIR /Postgres-XL
RUN make install
WORKDIR /Postgres-XL/contrib
RUN make install

ENV PATH /opt/pgxl/bin:$PATH
ENV PGDATA /root/pgxc

### LD

RUN echo "/usr/local/lib" >> /etc/ld.so.conf
RUN echo "/opt/pgxl/lib" >> /etc/ld.so.conf
RUN ldconfig

EXPOSE 5432
