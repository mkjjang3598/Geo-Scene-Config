## Running from data preprocessing to nelf-pro

## Data preprocessing (sample, scale, undistort)
DATA_DIR=data/scannetpp
SCENE=bb87c292ad
GPU=0
NOVEL_VIEW=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}
if [ "${NOVEL_VIEW}" -eq 0 ]; then
    TRANSFORMS_PATH="dslr/nerfstudio/transforms_undistorted.json"
else
    TRANSFORMS_PATH="dslr/nerfstudio/transforms_undistorted_fvs.json"
fi

zsh scripts/scannetpp/data_preprocessing.sh ${DATA_DIR} ${SCENE}

## Run SDFstudio
zsh scripts/scannetpp/extract_monocular_cues.sh ${IMAGE_PATH} ${GPU}
zsh scripts/scannetpp/run_sdfstudio.sh ${SCENE} ${IMAGE_PATH} ${GPU} ${NOVEL_VIEW}

## Run NeLF-Pro
zsh scripts/scannetpp/run_nelfpro.sh ${SCENE} ${IMAGE_PATH} ${GPU} ${NOVEL_VIEW}