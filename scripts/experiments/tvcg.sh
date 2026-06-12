DATA_DIR=data/scannetpp 
SCENE=e91722b5a3
GPU=0
IMAGE_PATH=../${DATA_DIR}/${SCENE}
TRANSFORMS_PATH=transforms_undistorted_mapanything.json

CUDA_VISIBLE_DEVICES=${GPU} ns-optimize-probe \
--scene ${SCENE} \
--method mapanything \
--data ${IMAGE_PATH}/dslr \
--transforms_path ${TRANSFORMS_PATH} \
--no-visualize 

CUDA_VISIBLE_DEVICES=${GPU} ns-train nelf-pro-small \
--experiment-name optim-mapanything-${SCENE}-w_0 \
--vis wandb \
--raw_loader scannetpp \
--data ${IMAGE_PATH} \
--use_probe_optimization True \
--use_mapanything True

CUDA_VISIBLE_DEVICES=${GPU} ns-train depth-nelf-pro-small \
--experiment-name mapanything-${SCENE}-w_0 \
--vis wandb \
--raw_loader scannetpp \
--data ${IMAGE_PATH} \
--use_probe_optimization True \
--novel_view True \
--train_num_rays_per_batch 5120 \
--use_mapanything True