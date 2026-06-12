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



# CUDA_VISIBLE_DEVICES=${GPU} ns-optimize-probe --scene ${SCENE} --method monosdf --data ${IMAGE_PATH} --no-visualize # --visualization_path "./visualize/probe_planning/${SCENE}"
# CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name optim-nelfpro-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True 

#(64, 3)
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name optim-nelfpro-${SCENE}_full --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True #--use_appearance_embedding True --sequential True
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_full --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True #--use_appearance_embedding True --sequential True
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_full --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --novel_view True --train_num_rays_per_batch 6144 #--use_appearance_embedding True --sequential True

# (128, 3)
# CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 128 --num_core 3 --use_appearance_embedding True --sequential True
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name optim-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 #--use_appearance_embedding True --sequential True
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 #--use_appearance_embedding True --sequential True
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_full_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --novel_view True --train_num_rays_per_batch 6144 #--use_appearance_embedding True --sequential True


CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-${SCENE}-appearance_sequential_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 128 --num_core 3 --use_appearance_embedding True --sequential True
CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name optim-nelfpro-${SCENE}-appearance_sequential_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --use_appearance_embedding True --sequential True
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}-appearance_sequential_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --use_appearance_embedding True --sequential True
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}-appearance_sequential_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --novel_view True --train_num_rays_per_batch 6144 --use_appearance_embedding True --sequential True


CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_128_3_appearance --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --novel_view True --train_num_rays_per_batch 6144 --use_appearance_embedding True --sequential True


CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-${SCENE}_128_3_appearance_sequential --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 3 --novel_view True --train_num_rays_per_batch 6144 --use_appearance_embedding True --sequential True


# big
# CUDA_VISIBLE_DEVICES=${GPU} ns-optimize-probe --scene ${SCENE} --method monosdf --data ${IMAGE_PATH} --no-visualize --num_basis 128 --num_core 6
# CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name optim-nelfpro-big-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 6 

# CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small --experiment-name nelfpro-big-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --num_basis 128 --num_core 6 

CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --use_appearance_embedding True --sequential True
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-big-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --num_basis 128 --num_core 6 --use_appearance_embedding True --sequential True

CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name novel-nelfpro-big-${SCENE} --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --depth_loss_type ROBUST --novel_view True --train_num_rays_per_batch 6144 --use_appearance_embedding True --sequential True --num_basis 128 --num_core 6 



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


# SPARSENERF RANKING
CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small --experiment-name depth-nelfpro-${SCENE}_sparsenerf_128_3 --vis wandb --raw_loader zipnerf --data ${IMAGE_PATH} --use_probe_optimization True --depth_loss_type SPARSENERF_RANKING --num_basis 128 --num_core 3 #--use_appearance_embedding True --sequential True