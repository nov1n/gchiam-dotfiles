#!/bin/bash

pushd ~/.vim
mkdir -p bundle && cd bundle
git clone git://github.com/klen/python-mode.git
popd
