#!/bin/bash

if [[ $TRAVIS_OS_NAME == "osx" ]]; then
    rm '/usr/local/include/c++'
#    brew cask uninstall oclint  #  Reserve variant to deal with conflict link
    if [[ ${TASK} == "mpi" ]]; then
        brew install open-mpi
    else
        brew install gcc
    fi
#    brew link --overwrite gcc  # Previous variant to deal with conflict link
    wget -O conda.sh https://repo.continuum.io/miniconda/Miniconda${PYTHON_VERSION:0:1}-latest-MacOSX-x86_64.sh
else
    if [[ ${TASK} != "pylint" ]] && [[ ${TASK} != "check-docs" ]]; then
        sudo add-apt-repository ppa:george-edison55/cmake-3.x -y
        sudo apt-get update -q
        sudo apt-get install -y cmake
        sudo apt-get install -y libopenmpi-dev openmpi-bin build-essential
        sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test;
        sudo apt-get update;
        sudo apt-get install g++-5;
        sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 90
        export CXX=g++-5 && export CC=gcc-5;
    fi
    wget -O conda.sh https://repo.continuum.io/miniconda/Miniconda${PYTHON_VERSION:0:1}-latest-Linux-x86_64.sh
fi
