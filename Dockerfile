FROM debian:bookworm

WORKDIR /wrk

ENV NJOY_REPO='https://github.com/njoy/NJOY2016'

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y python3-pip python-is-python3 git build-essential cmake python3-venv gfortran && \
    apt-get autoremove

RUN python3 -m venv venv
ENV PATH=/wrk/venv/bin:$PATH
# RUN pip install --upgrade pip

RUN git clone --single-branch --depth 1 ${NJOY_REPO} \
    && cd NJOY2016 \
    && mkdir build \
    && cd build \
    && cmake -Dstatic=on .. \
    && make 2>/dev/null -j${compile_cores} install \
    && rm -rf $HOME/NJOY2016

ENV NDMANAGER_ENDF6="/wrk/ndmanager-podman/ndmanager/endf6"
ENV NDMANAGER_HDF5="/wrk/ndmanager-podman/ndmanager/hdf5"
ENV NDMANAGER_CHAINS="/wrk/ndmanager-podman/ndmanager/chains"
ENV NDMANAGER_MODULEPATH="/wrk/ndmanager-podman/ndmanager/modulefiles"
ENV OPENBLAS_NUM_THREADS=1

RUN pip install git+https://github.com/openmc-dev/openmc.git
RUN pip install git+https://github.com/nplinden/ndmanager.git
