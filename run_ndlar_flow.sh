#!/usr/bin/env bash

if [[ "$#" != "2" ]]; then
    echo "Usage: $0 INFILE OUTFILE"
    exit 1
fi

inFile=$(realpath "$1")
outFile=$(realpath "$2")

module unload python 2>/dev/null
module load python/3.11
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
    -i "$inFile" -o "$outFile"

h5flow -c $workflow6 $workflow7\
    -i "$inFile" -o "$outFile"

h5flow -c $workflow8\
    -i "$outFile" -o "$outFile"
