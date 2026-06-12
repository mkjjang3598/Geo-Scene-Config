## Running SDFstudio

SCENE=$1
IMAGE_PATH=$2
GPU=${3:-0}
NOVEL_VIEW=${4:-0}

cd sdfstudio
source ~/anaconda3/etc/profile.d/conda.sh
conda activate sdfstudio

# OMP_NUM_THREADS=4 CUDA_VISIBLE_DEVICES=${GPU} ns-train monosdf --vis wandb --experiment-name "${SCENE}" zipnerf-data --data "${IMAGE_PATH}" 
OMP_NUM_THREADS=4 CUDA_VISIBLE_DEVICES=${GPU} ns-train neus-facto --pipeline.model.sdf-field.use-appearance-embedding True --pipeline.datamanager.train-num-images-to-sample-from 1 --pipeline.datamanager.train-num-times-to-repeat-images 0 --vis wandb --experiment-name ${SCENE} --pipeline.model.mono-depth-loss-mult 0.1 --pipeline.model.mono-normal-loss-mult 0.05 --pipeline.datamanager.train-num-rays-per-batch 2048 zipnerf-data --data ${IMAGE_PATH} --include-mono-prior True

# Extract mesh
# CUDA_VISIBLE_DEVICES=${GPU} ns-extract-mesh --scene ${SCENE} --method monosdf --output-path outputs/${SCENE}/monosdf/mesh.ply 
CUDA_VISIBLE_DEVICES=${GPU} ns-extract-mesh --scene ${SCENE} --method neus-facto --output-path outputs/${SCENE}/neus-facto/mesh.ply 

# Check if NOVEL_VIEW is set to 1
if [ "${NOVEL_VIEW}" -eq 1 ]; then
    # Sample novel viewpoints
    CUDA_VISIBLE_DEVICES=${GPU} ns-sample-viewpoint --data ${IMAGE_PATH} --meshfile outputs/${SCENE}/monosdf/mesh.ply --no-visualize # --visualization_path "./visualize/"viewpoint_sampling"/"${SCENE}
    CUDA_VISIBLE_DEVICES=${GPU} ns-render-depth --scene ${SCENE} --method monosdf --data "${IMAGE_PATH}" --output_path "${IMAGE_PATH}" --eval-num-rays-per-chunk 2048 --render_option "train" "eval" "novel"
else
    # Extract depth
    CUDA_VISIBLE_DEVICES=${GPU} ns-render-depth --scene ${SCENE} --method monosdf --data "${IMAGE_PATH}" --output_path "${IMAGE_PATH}" --eval-num-rays-per-chunk 2048                         
fi

CUDA_VISIBLE_DEVICES=${GPU} ns-render-rgb --scene ${SCENE} --method monosdf --data "${IMAGE_PATH}" --output_path "${IMAGE_PATH}" --eval-num-rays-per-chunk 2048 --render_option "eval"

conda deactivate 
cd ..

# CUDA_VISIBLE_DEVICES=${GPU} ns-sample-viewpoint --data ${IMAGE_PATH} --meshfile outputs/${SCENE}/monosdf/mesh.ply --no-visualize 
# CUDA_VISIBLE_DEVICES=${GPU} ns-render-depth --scene ${SCENE} --method monosdf --data "${IMAGE_PATH}" --output_path "${IMAGE_PATH}" --eval-num-rays-per-chunk 2048 --render_option "novel"

# # OMP_NUM_THREADS=4 CUDA_VISIBLE_DEVICES=${GPU} ns-train neus-facto --pipeline.model.sdf-field.use-appearance-embedding True --pipeline.datamanager.train-num-images-to-sample-from 1 --pipeline.datamanager.train-num-times-to-repeat-images 0 --vis wandb --experiment-name ${SCENE} --pipeline.model.mono-depth-loss-mult 0.1 --pipeline.model.mono-normal-loss-mult 0.05 --pipeline.datamanager.train-num-rays-per-batch 2048 zipnerf-data --data ${IMAGE_PATH} --include-mono-prior True

# # CUDA_VISIBLE_DEVICES=${GPU} ns-extract-mesh --scene ${SCENE} --method neus-facto --output-path outputs/${SCENE}/neus-facto/mesh.ply 
# # CUDA_VISIBLE_DEVICES=${GPU} ns-render-depth --scene ${SCENE} --method neus-facto --data "${IMAGE_PATH}" --output_path "${IMAGE_PATH}" --eval-num-rays-per-chunk 2048  


# ## appearance embedding true for alameda
# OMP_NUM_THREADS=4 CUDA_VISIBLE_DEVICES=${GPU} ns-train monosdf --pipeline.model.sdf-field.use-appearance-embedding True --vis wandb --experiment-name "${SCENE}" zipnerf-data --data "${IMAGE_PATH}" 
# CUDA_VISIBLE_DEVICES=${GPU} ns-extract-mesh --scene ${SCENE} --method monosdf --output-path outputs/${SCENE}/monosdf/mesh.ply 
# CUDA_VISIBLE_DEVICES=${GPU} ns-render-depth --scene ${SCENE} --method monosdf --data "${IMAGE_PATH}" --output_path "${IMAGE_PATH}" --eval-num-rays-per-chunk 2048   

CUDA_VISIBLE_DEVICES=${GPU} ns-sample-viewpoint --data ${IMAGE_PATH} --meshfile outputs/${SCENE}/monosdf/mesh.ply --no-visualize 
CUDA_VISIBLE_DEVICES=${GPU} ns-render-depth --scene ${SCENE} --method monosdf --data "${IMAGE_PATH}" --output_path "${IMAGE_PATH}" --eval-num-rays-per-chunk 2048 --render_option "novel"

CUDA_VISIBLE_DEVICES=${GPU} ns-sample-viewpoint --data ${IMAGE_PATH} --meshfile outputs/${SCENE}/monosdf/mesh.ply --no-visualize --num_candidate_cameras 100 --sample_random
CUDA_VISIBLE_DEVICES=${GPU} ns-render-depth --scene ${SCENE} --method monosdf --data "${IMAGE_PATH}" --output_path "${IMAGE_PATH}" --eval-num-rays-per-chunk 2048 --render_option "random"