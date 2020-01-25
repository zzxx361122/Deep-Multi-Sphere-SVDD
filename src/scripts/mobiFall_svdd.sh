#!/usr/bin/env bash

device=$1
xp_dir=log/$2
seed=$3
solver=$4
lr=$5
n_epochs=$6
hard_margin=$7
block_coordinate=$8
pretrain=$9
mobiFall_normal=${10}
mobiFall_outlier=${11}
nu=${12}
mobiFall_rep_dim=${13}
info_file=${14}

mkdir $xp_dir;

# mobiFall training
python baseline.py --dataset mobiFall --solver $solver --loss svdd --lr $lr --lr_drop 1 --lr_drop_in_epoch 50 \
    --seed $seed --lr_drop_factor 10 --block_coordinate $block_coordinate --R_update_solver minimize_scalar \
    --R_update_scalar_method bounded --R_update_lp_obj primal --use_batch_norm 1 --pretrain $pretrain \
    --batch_size 200 --n_epochs $n_epochs --device $device --xp_dir $xp_dir --leaky_relu 1 --weight_decay 1 --C 1e6 \
    --hard_margin $hard_margin --nu $nu --weight_dict_init 1 --unit_norm_used l1 --gcn 1 --mobiFall_rep_dim $mobiFall_rep_dim \
    --mobiFall_normal $mobiFall_normal --mobiFall_outlier $mobiFall_outlier --plot_examples 0 --info_file $info_file --out_frac 0;
