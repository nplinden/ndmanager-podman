#!/bin/bash

if [ -z "$(podman images -q ndmanager 2> /dev/null)" ]; then
  podman build --tag ndmanager .
fi

mkdir -p ndmanager
mkdir -p ndmanager/endf6
mkdir -p ndmanager/hdf5
mkdir -p ndmanager/chains
mkdir -p ndmanager/modulefiles

podman run -it -v ./ndmanager:/wrk/ndmanager ndmanager bash
