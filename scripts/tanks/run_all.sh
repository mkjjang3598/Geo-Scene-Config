## Running from data preprocessing to nelf-pro

## Data preprocessing (sample, scale, undistort)
DATA_DIR=data/tanks
SCENE=ballroom
GPU=0
NOVEL_VIEW=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}
if [ "${NOVEL_VIEW}" -eq 0 ]; then
    TRANSFORMS_PATH="transforms_undistorted.json"
else
    TRANSFORMS_PATH="transforms_undistorted_fvs.json"
fi

zsh scripts/tanks/data_preprocessing.sh ${DATA_DIR} ${SCENE}

## Run SDFstudio
zsh scripts/tanks/extract_monocular_cues.sh ${IMAGE_PATH} ${GPU}
zsh scripts/tanks/run_sdfstudio.sh ${SCENE} ${IMAGE_PATH} ${GPU} ${NOVEL_VIEW}

## Run NeLF-Pro
zsh scripts/tanks/run_nelfpro.sh ${SCENE} ${IMAGE_PATH} ${GPU} ${NOVEL_VIEW}