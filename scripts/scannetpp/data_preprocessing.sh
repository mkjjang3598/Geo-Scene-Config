## processing raw ScanNet++ dataset
DATA_DIR=${1:-data/scannetpp}
SCENE=${2:- }
SAMPLE_NUM=${3:-200}

# sample
python data/sample_data.py --input_dir $DATA_DIR --output_dir $DATA_DIR --scene $SCENE --sample_num ${SAMPLE_NUM}
# undistort
python data/undistort_data.py --input_dir $DATA_DIR --output_dir $DATA_DIR --scene $SCENE

