## Running SDFstudio

SCENE=$1
IMAGE_PATH=$2
GPU=${3:-0}
NOVEL_VIEW=${4:-0}

cd sdfstudio
source ~/anaconda3/etc/profile.d/conda.sh
conda activate sdfstudio

OMP_NUM_THREADS=4 CUDA_VISIBLE_DEVICES=${GPU} ns-train monosdf --vis wandb --experiment-name "${SCENE}" scannetpp-data --data "${IMAGE_PATH}" 

# Extract mesh
CUDA_VISIBLE_DEVICES=${GPU} ns-extract-mesh --scene ${SCENE} --method monosdf --output-path outputs/${SCENE}/monosdf/mesh.ply 

# Check if NOVEL_VIEW is set to 1
if [ "${NOVEL_VIEW}" -eq 1 ]; then
    # Sample novel viewpoints
    CUDA_VISIBLE_DEVICES=${GPU} ns-sample-viewpoint --data ${IMAGE_PATH} --meshfile outputs/${SCENE}/monosdf/mesh.ply --no-visualize # --visualization_path "./visualize/"viewpoint_sampling"/"${SCENE}
    CUDA_VISIBLE_DEVICES=${GPU} ns-render-depth --scene $SCENE --method monosdf --data "${IMAGE_PATH}" --output_path "${IMAGE_PATH}" --eval-num-rays-per-chunk 2048 --render_option "train" "eval" "novel"
else
    # Extract depth
    CUDA_VISIBLE_DEVICES=${GPU} ns-render-depth --scene $SCENE --method monosdf --data "${IMAGE_PATH}" --output_path "${IMAGE_PATH}" --eval-num-rays-per-chunk 2048 
fi

# Extract rgb
CUDA_VISIBLE_DEVICES=${GPU} ns-render-rgb --scene $SCENE --method monosdf --data "${IMAGE_PATH}" --output_path "${IMAGE_PATH}" --eval-num-rays-per-chunk 2048 --render_option "eval" 


conda deactivate 
cd ..

# random sampling
# CUDA_VISIBLE_DEVICES=${GPU} ns-sample-viewpoint --data ${IMAGE_PATH} --meshfile outputs/${SCENE}/monosdf/mesh.ply --num_candidate_cameras 100 --no-visualize --sample_random
# CUDA_VISIBLE_DEVICES=${GPU} ns-render-depth --scene $SCENE --method monosdf --data "${IMAGE_PATH}" --output_path "${IMAGE_PATH}" --eval-num-rays-per-chunk 2048 --render_option "random"