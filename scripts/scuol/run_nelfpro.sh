## Running NeLF-Pro

SCENE=$1
IMAGE_PATH=$2
GPU=${3:-0}
NOVEL_VIEW=${4:-0}

cd nelf-pro
source ~/anaconda3/etc/profile.d/conda.sh
conda activate nelf-pro
CUDA_VISIBLE_DEVICES=${GPU} ns-optimize-probe --scene ${SCENE} --method monosdf --data ${IMAGE_PATH} --no-visualize # --visualization_path "./visualize/probe_planning/${SCENE}"
if [ "${NOVEL_VIEW}" -eq 0 ]; then
    CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True 
else
    CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}-6144 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --depth_loss_type ROBUST --novel_view True --train_num_rays_per_batch 6144
fi
cd ..
conda deactivate


