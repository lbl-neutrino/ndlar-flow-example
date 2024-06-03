#!/usr/bin/env bash

default_in_file="/global/cfs/cdirs/dune/www/data/2x2/nearline/packet/commission/May2024/COOLDOWN/packet-2024_05_30_18_50_48_CDT.h5"

now=$(date -u +%Y%m%dT%H%M%SZ)

in_file=$(realpath ${1:-$default_in_file})
out_file=$(basename $in_file .h5)."$now".FLOW.h5

out_dir=$SCRATCH/larnd-sim-output
mkdir -p "$out_dir"

source ndlar_flow.venv/bin/activate

cd ndlar_flow

# charge workflows
workflow1='yamls/proto_nd_flow/workflows/charge/charge_event_building.yaml'
workflow2='yamls/proto_nd_flow/workflows/charge/charge_event_reconstruction.yaml'
workflow3='yamls/proto_nd_flow/workflows/combined/combined_reconstruction.yaml'
workflow4='yamls/proto_nd_flow/workflows/charge/prompt_calibration.yaml'
workflow5='yamls/proto_nd_flow/workflows/charge/final_calibration.yaml'

# light workflows
workflow6='yamls/proto_nd_flow/workflows/light/light_event_building_mc.yaml'
workflow7='yamls/proto_nd_flow/workflows/light/light_event_reconstruction.yaml'

# charge-light trigger matching
workflow8='yamls/proto_nd_flow/workflows/charge/charge_light_assoc.yaml'

h5flow -c $workflow1 $workflow2 $workflow3 $workflow4 $workflow5\
    -i "$in_file" -o "$out_dir/$out_file"

# h5flow -c $workflow6 $workflow7\
#     -i "$inFile" -o "$outFile"

# h5flow -c $workflow8\
#     -i "$outFile" -o "$outFile"
