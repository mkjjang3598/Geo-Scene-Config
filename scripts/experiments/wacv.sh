# 1. STD estimation
# 1.1) Scannetpp 
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name std-nelfpro-${SCENE} --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH}
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name std-optim-nelfpro-${SCENE} --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_probe_optimization True
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name std-only_depth-nelfpro-${SCENE}-6144 --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --novel_view True --train_num_rays_per_batch 6144
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name std-novel-nelfpro-${SCENE}-6144 --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_probe_optimization True --novel_view True --train_num_rays_per_batch 6144


# 1.2) ZipNeRF dataset
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name std-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 128 --num_core 3 
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name std-optim-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name std-depth_only_nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 128 --num_core 3 --novel_view True --train_num_rays_per_batch 6144 
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name std-novel-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --novel_view True --train_num_rays_per_batch 6144 


# 3DGS 
CUDA_VISIBLE_DEVICES=${GPU} python train.py -s ${IMAGE_PATH}/colmap_3dgs -m output/${SCENE}_${SCENE_NUM} --eval --port ${PORT}
CUDA_VISIBLE_DEVICES=${GPU} python render.py -m output/${SCENE}_${SCENE_NUM} # Generate renderings
CUDA_VISIBLE_DEVICES=${GPU} python torch_metrics.py -m output/${SCENE}_${SCENE_NUM} # Compute error metrics on renderings

# 2. Running other baselines: DNGaussian, ZipNeRF
# 2.1) DNGaussian
zsh scripts/run_custom.sh ../${IMAGE_PATH}/dslr/colmap_3dgs output/${SCENE} 0
# 2.2) ZipNeRF
# scannetpp [bb87c292ad. 281ba69af1, 0d2ee665be]
CUDA_VISIBLE_DEVICES=${GPU} ns-train zipnerf --experiment-name zipnerf-${SCENE}_scale_2 --vis wandb scannetpp-data --data ${IMAGE_PATH} --scale_factor 2.0
CUDA_VISIBLE_DEVICES=${GPU} ns-train zipnerf --experiment-name zipnerf-${SCENE}_scale_4 --vis wandb scannetpp-data --data ${IMAGE_PATH} --scale_factor 4.0
CUDA_VISIBLE_DEVICES=${GPU} ns-train zipnerf --experiment-name zipnerf-${SCENE}_scale_6 --vis wandb scannetpp-data --data ${IMAGE_PATH} --scale_factor 6.0

# ZipNeRF [alameda, berlin, london, nyc]
CUDA_VISIBLE_DEVICES=${GPU} ns-train zipnerf --experiment-name zipnerf-${SCENE}_scale_2 --vis wandb zipnerf-data --data ${IMAGE_PATH} --scale_factor 2.0
CUDA_VISIBLE_DEVICES=${GPU} ns-train zipnerf --experiment-name zipnerf-${SCENE}_scale_4 --vis wandb zipnerf-data --data ${IMAGE_PATH} --scale_factor 4.0
CUDA_VISIBLE_DEVICES=${GPU} ns-train zipnerf --experiment-name zipnerf-${SCENE}_scale_6 --vis wandb zipnerf-data --data ${IMAGE_PATH} --scale_factor 6.0

# 3. Depth regularization comparisons
# 3.1) RegNeRF
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name regnerf-nelfpro-${SCENE} --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_probe_optimization True --depth_loss_type REGNERF 

CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name regnerf-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --depth_loss_type REGNERF

# 3.2) DiffNeRF
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name diffnerf-nelfpro-${SCENE} --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_probe_optimization True --depth_loss_type DIFFNERF 

CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name diffnerf-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --depth_loss_type DIFFNERF

# Scannetpp
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name regnerf-nelfpro-${SCENE} --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_probe_optimization True --depth_loss_type REGNERF 
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name diffnerf-nelfpro-${SCENE} --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_probe_optimization True --depth_loss_type DIFFNERF 

# ZipNeRF
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name regnerf-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --depth_loss_type REGNERF
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name diffnerf-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --depth_loss_type DIFFNERF


# Video

# 1) NeLF-pro rendering
DATA_DIR=data/zipnerf      
SCENE=nyc
GPU=6
NOVEL_VIEW=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}
DEPTH_DIR='sdfstudio_depths'
if [ "${NOVEL_VIEW}" -eq 0 ]; then
TRANSFORMS_PATH="transforms_undistorted.json"
else
TRANSFORMS_PATH="transforms_undistorted_fvs.json"
fi

CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 128 --num_core 3 
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 128 --num_core 3 

CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --novel_view True --train_num_rays_per_batch 6144 
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --novel_view True --train_num_rays_per_batch 6144 



# CUDA_VISIBLE_DEVICES=${GPU} ns-render --load_config outputs/nelfpro-nyc_full_128_3/nelf-pro-small/2025-09-09_161025/config.yml --traj train --data ${IMAGE_PATH} --output-path renders/nelf-pro_nyc_big

# CUDA_VISIBLE_DEVICES=${GPU} ns-render --load_config outputs/novel-nelfpro-nyc_128_3/depth-nelf-pro-small/2025-09-09_163913/config.yml --traj train --data ${IMAGE_PATH} --output-path renders/nelf-pro_ours_nyc_big

CUDA_VISIBLE_DEVICES=${GPU} ns-render --load_config outputs/nelfpro-nyc_full_128_3/nelf-pro-small/2025-09-09_161025/config.yml --traj filename --camera-path-filename camera_paths/nyc_big_rebuttal.json --output-path renders/nelf-pro_nyc_big

CUDA_VISIBLE_DEVICES=${GPU} ns-render --load_config outputs/novel-nelfpro-nyc_128_3/depth-nelf-pro-small/2025-09-09_163913/config.yml --traj filename --camera-path-filename camera_paths/nyc_big_rebuttal.json --output-path renders/nelf-pro_ours_nyc_big


# 2)LocalRF rendering
# FOV=98.19 / 97.34 / 97.88 / 98.11
# NUM_BLOCKS= 10 / 8 / 9 / 8
NUM_BLOCKS=8

cd gaussian_splatting
python extrapolation2nerfstudio.py 

# LocalRF
SCENE=nyc
SCENE_DIR=../../data/zipnerf/${SCENE}
IMAGE_PATH=${SCENE_DIR}
LOG_DIR=./log/${SCENE}_novel
FOV=98.11
GPU=0 
NUM_BLOCKS=8

CUDA_VISIBLE_DEVICES=${GPU} python localTensoRF/train.py --datadir ${SCENE_DIR} --logdir ${LOG_DIR} --fov ${FOV} --n_max_frames -1 --basis_path ${SCENE_DIR}/probes_${NUM_BLOCKS}.npz --robust_depth --loss_depth_weight_initial 0.01 --novel_depth --render_only 1 --render_test 0 --render_path 0 --render_from_file camera_paths/${SCENE}/transforms_undistorted.json


# Time examination
# Scannet
DATA_DIR=data/scannetpp   
SCENE=e91722b5a3
GPU=0       
NOVEL_VIEW=0                      
IMAGE_PATH=../${DATA_DIR}/${SCENE}
if [ "${NOVEL_VIEW}" -eq 0 ]; then                               
    TRANSFORMS_PATH="dslr/nerfstudio/transforms_undistorted.json"    
else
    TRANSFORMS_PATH="dslr/nerfstudio/transforms_undistorted_fvs.json"
fi           

CUDA_VISIBLE_DEVICES=${GPU} ns-sample-viewpoint --data ${IMAGE_PATH} --meshfile outputs/${SCENE}/monosdf/mesh.ply --no-visualize
CUDA_VISIBLE_DEVICES=${GPU} ns-optimize-probe --scene ${SCENE} --method monosdf --data ${IMAGE_PATH} --no-visualize