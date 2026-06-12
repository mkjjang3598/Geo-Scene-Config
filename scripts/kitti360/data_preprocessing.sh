## processing raw Kitti360 dataset
DATA_DIR=${1:-data/kitti360}
SCENE=${2:- }

# undistort
python3 data/undistort_data.py --input_dir $DATA_DIR --output_dir $DATA_DIR --scene $SCENE

