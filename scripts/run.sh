cd mhp_extension
python ./coco_style_annotation_creator/test_human2coco_format.py \
    --dataset 'Demo' \
    --json_save_dir './data/DemoDataset/msrcnn_finetune_annotations' \
    --test_img_dir './data/DemoDataset/global_pic'

cd ./detectron2/tools/

python finetune_net.py \
	--num-gpus 1 \
	--config-file ../configs/Misc/parsing_inference.yaml \
	--eval-only MODEL.WEIGHTS ../../pretrain_model/detectron2_maskrcnn_cihp_finetune.pth TEST.AUG.ENABLED False \
    DATASETS.TEST "('demo_test', )" OUTPUT_DIR ../../data/DemoDataset/detectron2_prediction
    
cd ../../

python make_crop_and_mask_w_mask_nms.py \
    --img_dir './data/DemoDataset/global_pic' \
    --save_dir './data/DemoDataset' \
    --img_list './data/DemoDataset/msrcnn_finetune_annotations/Demo.json' \
    --det_res './data/DemoDataset/detectron2_prediction/inference/instances_predictions.pth'

python global_local_parsing/make_id_list.py 

cd ../

python mhp_extension/global_local_parsing/global_local_evaluate.py \
    --data-dir mhp_extension/data/DemoDataset \
    --split-name crop_pic \
    --model-restore mhp_extension/pretrain_model/exp_schp_multi_cihp_local.pth \
    --log-dir mhp_extension/data/DemoDataset \
    --save-results

python mhp_extension/global_local_parsing/global_local_evaluate.py \
    --data-dir mhp_extension/data/DemoDataset \
    --split-name global_pic \
    --model-restore mhp_extension/pretrain_model/exp_schp_multi_cihp_global.pth \
    --log-dir mhp_extension/data/DemoDataset \
    --save-results

python mhp_extension/logits_fusion.py \
    --test_json_path ./mhp_extension/data/DemoDataset/crop.json \
    --global_output_dir ./mhp_extension/data/DemoDataset/global_pic_parsing \
    --gt_output_dir ./mhp_extension/data/DemoDataset/crop_pic_parsing \
    --mask_output_dir ./mhp_extension/data/DemoDataset/crop_mask \
    --save_dir ./mhp_extension/data/DemoDataset/mhp_fusion_parsing