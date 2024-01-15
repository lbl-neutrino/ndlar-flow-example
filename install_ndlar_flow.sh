#!/usr/bin/env bash

module unload python 2>/dev/null

module load python/3.11

python -m venv ndlar_flow.venv
source ndlar_flow.venv/bin/activate
pip install --upgrade pip setuptools wheel

git clone -b main https://github.com/larpix/h5flow.git
cd h5flow
pip install -e .
cd ..

git clone -b develop https://github.com/larpix/ndlar_flow.git
cd ndlar_flow
pip install -e .
cd ..

datadir=ndlar_flow/data/proto_nd_flow

curl -O --output-dir "$datadir" https://raw.githubusercontent.com/DUNE/larnd-sim/develop/larndsim/pixel_layouts/multi_tile_layout-2.4.16.yaml
curl -O --output-dir "$datadir" https://raw.githubusercontent.com/DUNE/larnd-sim/develop/larndsim/pixel_layouts/multi_tile_layout-2.5.16.yaml
curl -O --output-dir "$datadir" https://raw.githubusercontent.com/DUNE/larnd-sim/develop/larndsim/detector_properties/2x2.yaml

cp static/runlist-2x2-mcexample.txt $datadir
cp static/light_module_desc-0.0.0.yaml $datadir
