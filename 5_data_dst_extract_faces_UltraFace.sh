#!/usr/bin/env bash
source env.sh

$DFL_PYTHON "$DFL_SRC/../scripts/yolo_face_extractor.py" \
    --input-dir "$DFL_WORKSPACE/data_dst" \
    --output-dir "$DFL_WORKSPACE/data_dst/aligned" \
    --device cuda
