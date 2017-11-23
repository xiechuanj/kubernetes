#!/bin/bash
cmake .. -DUSE_MPI=ON -DUSE_CUDNN=OFF
make -j"$(nproc)" all
