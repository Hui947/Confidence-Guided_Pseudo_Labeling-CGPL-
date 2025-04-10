model=$1
if [ ! -n "$1" ]
then 
    echo 'pelease input the model para: {deit_base, deit_small}'
    exit 8
fi
if [ "$model" == "deit_base" ]; then
    model_type="vit_base_patch16_224_TransReID"
    pretrain_model="deit_base_distilled_patch16_224-df68dfff.pth"
elif [ "$model" == "deit_small" ]; then
    model_type="vit_small_patch16_224_TransReID"
    pretrain_model="deit_small_distilled_patch16_224-649709d9.pth"
elif [ "$model" == "deit_tiny" ]; then
    model_type="vit_tiny_patch16_224_TransReID"
    pretrain_model="deit_tiny_distilled_patch16_224-b40b3cf7.pth"
else
    echo "Unsupported model: $model"
    exit 1
fi
python train.py --config_file configs/pretrain.yml MODEL.DEVICE_ID "('0')" DATASETS.NAMES 'Office' \
OUTPUT_DIR '../logs/pretrain/'$model'/office/Dslr' \
DATASETS.ROOT_TRAIN_DIR './data/office31/dslr_list.txt' \
DATASETS.ROOT_TEST_DIR './data/office31/dslr_list.txt'   \
SOLVER.LOG_PERIOD 10 \
MODEL.Transformer_TYPE $model_type \
MODEL.PRETRAIN_PATH './data/pretrainModel/'$pretrain_model \
