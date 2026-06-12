## Extracting monocular cues

IMAGE_PATH=$1
GPU=${2:-0}

cd sdfstudio
source ~/anaconda3/etc/profile.d/conda.sh
conda activate omnidata
CUDA_VISIBLE_DEIVCES=${GPU} python scripts/datasets/extract_monocular_cues.py --task depth --data_dir "${IMAGE_PATH}" 
CUDA_VISIBLE_DEIVCES=${GPU} python scripts/datasets/extract_monocular_cues.py --task normal --data_dir "${IMAGE_PATH}" 
conda deactivate
cd ..