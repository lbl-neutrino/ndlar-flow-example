#!/usr/bin/env bash

module unload python 2>/dev/null

module load python/3.11

python -m venv ndlar_flow.venv
source ndlar_flow.venv/bin/activate
pip install --upgrade pip setuptools wheel

git clone -b main https://github.com/lbl-neutrino/h5flow.git
cd h5flow
pip install -e .
cd ..

git clone -b data-test-20240603 https://github.com/mjkramer/ndlar_flow.git
cd ndlar_flow
pip install -e .
cd scripts/proto_nd_scripts
./get_proto_nd_input.sh
cd ../../..
