# 1. Scuol & T&T
python undistort_data.py --input_dir scuol --output_dir scuol_resized
python sample_transforms.py --scene scoul --sampling_ratio 2  

DATA_DIR=data/scuol
SCENE=scuol_small
GPU=6
NOVEL_VIEW=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}
DEPTH_DIR='sdfstudio_depths'
if [ "${NOVEL_VIEW}" -eq 0 ]; then
TRANSFORMS_PATH="transforms_undistorted.json"
else
TRANSFORMS_PATH="transforms_undistorted_fvs.json"
fi

# CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-${SCENE}-appearance --vis wandb --raw_loader scuol --data ${IMAGE_PATH} --use_probe_optimization False --use_appearance_embedding True --sequential True --pipeline.model.background_color last_sample --pipeline.model.distortion_loss_mult_factor_max 20 --pipeline.model.far_plane 100 --pipeline.model.init_sampler log --pipeline.model.freq_theta 4 --pipeline.model.freq_phi 4

# CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-${SCENE} --vis wandb --raw_loader scuol --data ${IMAGE_PATH} --use_probe_optimization False --pipeline.model.background_color last_sample --pipeline.model.distortion_loss_mult_factor_max 20 --pipeline.model.far_plane 100 --pipeline.model.init_sampler log --pipeline.model.freq_theta 4 --pipeline.model.freq_phi 4
   
# Best
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-${SCENE}-appearance-128 --vis wandb --raw_loader scuol --data ${IMAGE_PATH} --use_probe_optimization False --use_appearance_embedding True --sequential True --num_basis 128  --pipeline.model.background_color last_sample --pipeline.model.distortion_loss_mult_factor_max 20 --pipeline.model.far_plane 100 --pipeline.model.init_sampler log --pipeline.model.freq_theta 4 --pipeline.model.freq_phi 4

# CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-${SCENE}-128 --vis wandb --raw_loader scuol --data ${IMAGE_PATH} --use_probe_optimization False --num_basis 128 --pipeline.model.background_color last_sample --pipeline.model.distortion_loss_mult_factor_max 20 --pipeline.model.far_plane 100 --pipeline.model.init_sampler log --pipeline.model.freq_theta 4 --pipeline.model.freq_phi 4

# Probe planning
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name optim-${SCENE}-appearance-128 --vis wandb --raw_loader scuol --data ${IMAGE_PATH} --use_probe_optimization True --use_appearance_embedding True --sequential True --num_basis 128  --pipeline.model.background_color last_sample --pipeline.model.distortion_loss_mult_factor_max 20 --pipeline.model.far_plane 100 --pipeline.model.init_sampler log --pipeline.model.freq_theta 4 --pipeline.model.freq_phi 4

# Depth regul
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_apperance_128 --vis wandb --raw_loader scuol --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --use_appearance_embedding True --sequential True --pipeline.model.background_color last_sample --pipeline.model.distortion_loss_mult_factor_max 20 --pipeline.model.far_plane 100 --pipeline.model.init_sampler log --pipeline.model.freq_theta 4 --pipeline.model.freq_phi 4


# Novel
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader scuol --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --novel_view True --train_num_rays_per_batch 6144 --use_appearance_embedding True --sequential True --pipeline.model.background_color last_sample --pipeline.model.distortion_loss_mult_factor_max 20 --pipeline.model.far_plane 100 --pipeline.model.init_sampler log --pipeline.model.freq_theta 4 --pipeline.model.freq_phi 4

CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_full_128_3_no_appearance --vis wandb --raw_loader scuol --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --novel_view True --train_num_rays_per_batch 6144 --pipeline.model.background_color last_sample --pipeline.model.distortion_loss_mult_factor_max 20 --pipeline.model.far_plane 100 --pipeline.model.init_sampler log --pipeline.model.freq_theta 4 --pipeline.model.freq_phi 4



DATA_DIR=data/scuol
SCENE=scuol_small
GPU=0
NOVEL_VIEW=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}
DEPTH_DIR='sdfstudio_depths'
if [ "${NOVEL_VIEW}" -eq 0 ]; then
TRANSFORMS_PATH="transforms_undistorted.json"
else
TRANSFORMS_PATH="transforms_undistorted_fvs.json"
fi

CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-${SCENE}-appearance-128 --vis wandb --raw_loader scuol --data ${IMAGE_PATH} --use_probe_optimization False --use_appearance_embedding True --sequential True --num_basis 128  --pipeline.model.background_color last_sample --pipeline.model.distortion_loss_mult_factor_max 20 --pipeline.model.far_plane 100 --pipeline.model.init_sampler log --pipeline.model.freq_theta 4 --pipeline.model.freq_phi 4

CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader scuol --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --novel_view True --train_num_rays_per_batch 6144 --use_appearance_embedding True --sequential True --pipeline.model.background_color last_sample --pipeline.model.distortion_loss_mult_factor_max 20 --pipeline.model.far_plane 100 --pipeline.model.init_sampler log --pipeline.model.freq_theta 4 --pipeline.model.freq_phi 4

DATA_DIR=data/tanks
SCENE=barn
GPU=0
NOVEL_VIEW=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}
DEPTH_DIR='sdfstudio_depths'
if [ "${NOVEL_VIEW}" -eq 0 ]; then
TRANSFORMS_PATH="transforms_undistorted.json"
else
TRANSFORMS_PATH="transforms_undistorted_fvs.json"
fi

CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-${SCENE}-appearance --vis wandb --raw_loader tanks --data ${IMAGE_PATH}  --use_appearance_embedding True --sequential True 
# Novel
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_full --vis wandb --raw_loader tanks --data ${IMAGE_PATH} --use_probe_optimization True --novel_view True --train_num_rays_per_batch 6144 --use_appearance_embedding True --sequential True


# T&T barn
DATA_DIR=data/tanks
SCENE=barn
GPU=6
NOVEL_VIEW=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}
DEPTH_DIR='sdfstudio_depths'
if [ "${NOVEL_VIEW}" -eq 0 ]; then
TRANSFORMS_PATH="transforms_undistorted.json"
else
TRANSFORMS_PATH="transforms_undistorted_fvs.json"
fi

CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-${SCENE}-appearance --vis wandb --raw_loader tanks --data ${IMAGE_PATH}  --use_appearance_embedding True --sequential True 
# CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-${SCENE} --vis wandb --raw_loader tanks --data ${IMAGE_PATH}  # --use_appearance_embedding True --sequential True
# Optim
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name optim-nelfpro-${SCENE}-appearance --vis wandb --raw_loader tanks --data ${IMAGE_PATH} --use_probe_optimization True  --use_appearance_embedding True --sequential True 
# Depth
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}-appearance --vis wandb --raw_loader tanks --data ${IMAGE_PATH} --use_probe_optimization True --use_appearance_embedding True --sequential True
# Novel
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_full --vis wandb --raw_loader tanks --data ${IMAGE_PATH} --use_probe_optimization True --novel_view True --train_num_rays_per_batch 6144 --use_appearance_embedding True --sequential True




DATA_DIR=data/scuol
SCENE=scuol_small
GPU=0
NOVEL_VIEW=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}
DEPTH_DIR='sdfstudio_depths'
if [ "${NOVEL_VIEW}" -eq 0 ]; then
TRANSFORMS_PATH="transforms_undistorted.json"
else
TRANSFORMS_PATH="transforms_undistorted_fvs.json"
fi

CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader scuol --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --novel_view True --train_num_rays_per_batch 6144 --use_appearance_embedding True --sequential True --pipeline.model.background_color last_sample --pipeline.model.distortion_loss_mult_factor_max 20 --pipeline.model.far_plane 100 --pipeline.model.init_sampler log --pipeline.model.freq_theta 4 --pipeline.model.freq_phi 4

DATA_DIR=data/tanks
SCENE=barn
GPU=0
NOVEL_VIEW=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}
DEPTH_DIR='sdfstudio_depths'
if [ "${NOVEL_VIEW}" -eq 0 ]; then
TRANSFORMS_PATH="transforms_undistorted.json"
else
TRANSFORMS_PATH="transforms_undistorted_fvs.json"
fi

CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_full --vis wandb --raw_loader tanks --data ${IMAGE_PATH} --use_probe_optimization True --novel_view True --train_num_rays_per_batch 6144 --use_appearance_embedding True --sequential True



## LocalRF
SCENE=scuol_small
SCENE_DIR=../../data/scuol/${SCENE}
IMAGE_PATH=${SCENE_DIR}
LOG_DIR=./log/${SCENE}_small
FOV=98.46
GPU=0
NUM_BLOCKS=8
# LocalRF
CUDA_VISIBLE_DEVICES=${GPU} python localTensoRF/train.py --datadir ${SCENE_DIR} --logdir ${LOG_DIR} --fov ${FOV} --n_max_frames 100 
# Basis optim
CUDA_VISIBLE_DEVICES=${GPU} python localTensoRF/train.py --datadir ${SCENE_DIR} --logdir ${LOG_DIR} --fov ${FOV} --n_max_frames 100 --basis_path ${SCENE_DIR}/probes_${NUM_BLOCKS}.npz 
# Novel
CUDA_VISIBLE_DEVICES=${GPU} python localTensoRF/train.py --datadir ${SCENE_DIR} --logdir ${LOG_DIR} --fov ${FOV} --n_max_frames 100 --basis_path ${SCENE_DIR}/probes_${NUM_BLOCKS}.npz --robust_depth --loss_depth_weight_initial 0.01 --novel_depth

SCENE=barn
SCENE_DIR=../../data/tanks/${SCENE}
IMAGE_PATH=${SCENE_DIR}
LOG_DIR=./log/${SCENE}
FOV=84.36
GPU=4
NUM_BLOCKS=6

# LocalRF
CUDA_VISIBLE_DEVICES=${GPU} python localTensoRF/train.py --datadir ${SCENE_DIR} --logdir ${LOG_DIR} --fov ${FOV} --n_max_frames 100 
# Basis optim
CUDA_VISIBLE_DEVICES=${GPU} python localTensoRF/train.py --datadir ${SCENE_DIR} --logdir ${LOG_DIR} --fov ${FOV} --n_max_frames 100 --basis_path ${SCENE_DIR}/probes_${NUM_BLOCKS}.npz 
# Novel
CUDA_VISIBLE_DEVICES=${GPU} python localTensoRF/train.py --datadir ${SCENE_DIR} --logdir ${LOG_DIR} --fov ${FOV} --n_max_frames 100 --basis_path ${SCENE_DIR}/probes_${NUM_BLOCKS}.npz --robust_depth --loss_depth_weight_initial 0.01 --novel_depth


# 2. Regular grids
python scripts/regular_probe.py --scene ${SCENE} --method monosdf --data ${IMAGE_PATH} --no-visualize --num_basis 4

# Scannetpp e91722b5a3
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name regular-nelfpro-${SCENE} --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_regular_probe True --num_basis 4 --near_basis 2  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name regular-nelfpro-${SCENE} --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_regular_probe True --num_basis 8 --near_basis 4
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name regular-nelfpro-${SCENE} --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_regular_probe True --num_basis 16 --near_basis 4
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name regular-nelfpro-${SCENE} --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_regular_probe True --num_basis 32  --near_basis 8
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name regular-nelfpro-${SCENE} --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_regular_probe True --num_basis 64 --near_basis 16  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name regular-nelfpro-${SCENE} --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_regular_probe True --num_basis 128 --near_basis 16  

# ZipNeRF NYC
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name regular-nelfpro-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_regular_probe True --num_basis 4 --near_basis 2  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name regular-nelfpro-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_regular_probe True --num_basis 8 --near_basis 4
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name regular-nelfpro-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_regular_probe True --num_basis 16 --near_basis 4
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name regular-nelfpro-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_regular_probe True --num_basis 32  --near_basis 8
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name regular-nelfpro-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_regular_probe True --num_basis 64 --near_basis 16  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name regular-nelfpro-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_regular_probe True --num_basis 128 --near_basis 16  


# 3. SparesNeRF depth regularization
GPU=6
DATA_DIR=data/scannetpp
TRANSFORMS_PATH="transforms_undistorted.json"

SCENE=785e7504b9
IMAGE_PATH=../${DATA_DIR}/${SCENE}
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_sparsenerf --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --use_probe_optimization True --depth_loss_type SPARSENERF_RANKING 

SCENE=ef69d58016
IMAGE_PATH=../${DATA_DIR}/${SCENE}
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_sparsenerf --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --sort-per-sample True --depth_loss_type SPARSENERF_RANKING 

SCENE=bb87c292ad
IMAGE_PATH=../${DATA_DIR}/${SCENE}
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_sparsenerf --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --depth_loss_type SPARSENERF_RANKING 

SCENE=0d2ee665be
IMAGE_PATH=../${DATA_DIR}/${SCENE}
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_sparsenerf --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --depth_loss_type SPARSENERF_RANKING 

SCENE=e91722b5a3
IMAGE_PATH=../${DATA_DIR}/${SCENE}
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_sparsenerf --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --depth_loss_type SPARSENERF_RANKING 

SCENE=281ba69af1
IMAGE_PATH=../${DATA_DIR}/${SCENE}
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_sparsenerf --vis wandb --raw_loader scannetpp --data ${IMAGE_PATH} --depth_loss_type SPARSENERF_RANKING 


GPU=7
DATA_DIR=data/zipnerf

SCENE=alameda
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_sparsenerf_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --depth_loss_type SPARSENERF_RANKING --num_basis 128 --num_core 3 --use_appearance_embedding True --sequential True 

SCENE=berlin
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_sparsenerf_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --depth_loss_type SPARSENERF_RANKING --num_basis 128 --num_core 3 --use_appearance_embedding True --sequential True 

DATA_DIR=data/zipnerf_small

SCENE=london
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_sparsenerf_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --depth_loss_type SPARSENERF_RANKING --num_basis 128 --num_core 3 #--use_appearance_embedding True --sequential True 

SCENE=nyc
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_sparsenerf_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --depth_loss_type SPARSENERF_RANKING --num_basis 128 --num_core 3 #--use_appearance_embedding True --sequential True 


# SCADE
DATA_DIR=data/scannetpp
SCENE=785e7504b9
GPU=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}

CUDA_VISIBLE_DEVICES=${GPU} python ambiguity_aware_prior/tools/output_depth_hypothesis_scannetpp.py --dataroot ${IMAGE_PATH} --num_samples 5
CUDA_VISIBLE_DEVICES=${GPU} python run_scade_scannetpp.py train --data_dir ../${DATA_DIR} --scene_id ${SCENE} --cimle_dir dump_prior_samples --ckpt_dir pretrained_models/scannetpp --expname ${SCENE}  --num_hypothesis 5
CUDA_VISIBLE_DEVICES=${GPU} python run_scade_scannetpp.py test --data_dir ../${DATA_DIR} --scene_id ${SCENE} --cimle_dir dump_prior_samples --ckpt_dir pretrained_models/scannetpp --expname ${SCENE}  --num_hypothesis 5

DATA_DIR=data/scannetpp
SCENE=ef69d58016
GPU=1
IMAGE_PATH=../${DATA_DIR}/${SCENE}


DATA_DIR=data/scannetpp
SCENE=bb87c292ad
GPU=2
IMAGE_PATH=../${DATA_DIR}/${SCENE}


DATA_DIR=data/scannetpp
SCENE=0d2ee665be
GPU=3
IMAGE_PATH=../${DATA_DIR}/${SCENE}


DATA_DIR=data/scannetpp
SCENE=e91722b5a3
GPU=4
IMAGE_PATH=../${DATA_DIR}/${SCENE}


DATA_DIR=data/scannetpp
SCENE=281ba69af1
GPU=5
IMAGE_PATH=../${DATA_DIR}/${SCENE}



DATA_DIR=data/zipnerf_small
SCENE=nyc
GPU=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}

CUDA_VISIBLE_DEVICES=${GPU} python ambiguity_aware_prior/tools/output_depth_hypothesis_zipnerf.py --dataroot ../${IMAGE_PATH} --num_samples 5
CUDA_VISIBLE_DEVICES=${GPU} python run_scade_zipnerf.py train --data_dir ../${DATA_DIR} --scene_id ${SCENE} --cimle_dir dump_prior_samples --ckpt_dir pretrained_models/zipnerf --expname ${SCENE} --num_hypothesis 5
CUDA_VISIBLE_DEVICES=${GPU} python run_scade_zipnerf.py test --data_dir ../${DATA_DIR} --scene_id ${SCENE} --cimle_dir dump_prior_samples --ckpt_dir pretrained_models/zipnerf --expname ${SCENE} --num_hypothesis 5

# Scuol
DATA_DIR=data/scuol
SCENE=scuol_small
GPU=0
NOVEL_VIEW=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}
DEPTH_DIR='sdfstudio_depths'
if [ "${NOVEL_VIEW}" -eq 0 ]; then
TRANSFORMS_PATH="transforms_undistorted.json"
else
TRANSFORMS_PATH="transforms_undistorted_fvs.json"
fi

CUDA_VISIBLE_DEVICES=${GPU} python ambiguity_aware_prior/tools/output_depth_hypothesis_zipnerf.py --dataroot ../${IMAGE_PATH} --num_samples 5
CUDA_VISIBLE_DEVICES=${GPU} python run_scade_zipnerf.py train --data_dir ../${DATA_DIR} --scene_id ${SCENE} --cimle_dir dump_prior_samples --ckpt_dir pretrained_models/zipnerf --expname ${SCENE} --num_hypothesis 5
CUDA_VISIBLE_DEVICES=${GPU} python run_scade_zipnerf.py test --data_dir ../${DATA_DIR} --scene_id ${SCENE} --cimle_dir dump_prior_samples --ckpt_dir pretrained_models/zipnerf --expname ${SCENE} --num_hypothesis 5

# Tanks
DATA_DIR=data/tanks
SCENE=barn
GPU=0
NOVEL_VIEW=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}
DEPTH_DIR='sdfstudio_depths'
if [ "${NOVEL_VIEW}" -eq 0 ]; then
TRANSFORMS_PATH="transforms_undistorted.json"
else
TRANSFORMS_PATH="transforms_undistorted_fvs.json"
fi

CUDA_VISIBLE_DEVICES=${GPU} python ambiguity_aware_prior/tools/output_depth_hypothesis_zipnerf.py --dataroot ../${IMAGE_PATH} --num_samples 5
CUDA_VISIBLE_DEVICES=${GPU} python run_scade_zipnerf.py train --data_dir ../${DATA_DIR} --scene_id ${SCENE} --cimle_dir dump_prior_samples --ckpt_dir pretrained_models/zipnerf --expname ${SCENE} --num_hypothesis 5
CUDA_VISIBLE_DEVICES=${GPU} python run_scade_zipnerf.py test --data_dir ../${DATA_DIR} --scene_id ${SCENE} --cimle_dir dump_prior_samples --ckpt_dir pretrained_models/zipnerf --expname ${SCENE} --num_hypothesis 5



# 4. num_probe vs training time
# size comparison
# Basis opt.
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name optim-nelfpro-${SCENE}-4-2 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 4 --near_basis 2  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name optim-nelfpro-${SCENE}-8-4 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 8 --near_basis 4  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name optim-nelfpro-${SCENE}-16-4 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 16 --near_basis 4  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name optim-nelfpro-${SCENE}-32-8 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 32 --near_basis 8  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name optim-nelfpro-${SCENE}-64-16 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 64 --near_basis 16  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name optim-nelfpro-${SCENE}-128-16 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --near_basis 16 

CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name nelfpro-${SCENE}-4-2 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 4 --near_basis 2  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name nelfpro-${SCENE}-8-4 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 8 --near_basis 4  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name nelfpro-${SCENE}-16-4 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 16 --near_basis 4  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name nelfpro-${SCENE}-32-8 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 32 --near_basis 8  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name nelfpro-${SCENE}-64-16 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 64 --near_basis 16  
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name nelfpro-${SCENE}-128-16 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 128 --near_basis 16 

CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name novel-nelfpro-${SCENE}-4-2 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --novel_view True --num_basis 4 --near_basis 2 #--train_num_rays_per_batch 6144
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name novel-nelfpro-${SCENE}-8-4 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --novel_view True --num_basis 8 --near_basis 4 #--train_num_rays_per_batch 6144 
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name novel-nelfpro-${SCENE}-16-4 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --novel_view True --num_basis 16 --near_basis 4 #--train_num_rays_per_batch 6144 
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name novel-nelfpro-${SCENE}-32-8 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --novel_view True --num_basis 32 --near_basis 8 #--train_num_rays_per_batch 6144 
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name novel-nelfpro-${SCENE}-64-16 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --novel_view True --num_basis 64 --near_basis 16 #--train_num_rays_per_batch 6144
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --trainer.steps_per_eval_image 50000 --trainer.steps_per_eval_all_images 50000 --experiment-name novel-nelfpro-${SCENE}-128-16 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --novel_view True --num_basis 128 --near_basis 16 #--train_num_rays_per_batch 6144 