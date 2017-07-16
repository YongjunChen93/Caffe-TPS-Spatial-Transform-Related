#!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-7.0/lib64 
caffe_path=/tempspace/ychen7/TZcaffe/caffe_nd_sense_segmentation/build/tools 
for idmodel in {3800..3800..100}
do
	for idx in {1..6..1}
	do
		for idy in {1..6..1}
 	    do
	    a=w$idx
            b=_h$idy
 	    d=$idmodel
  	    e=result
		predict_dir1=U_Net_cutimage10refine_$d$e;
      		if [ ! -d "$predict_dir1" ]; then
     		 # Control will enter here if $DIRECTORY doesn't exist.
      		mkdir "U_Net_cutimage10refine_$d$e"
     		fi
		predict_dir=U_Net_cutimage10refine_$d$e/U_Net_$d$e$a$b;
      		if [ ! -d "$predict_dir" ]; then
      		# Control will enter here if $DIRECTORY doesn't exist.
      		mkdir "U_Net_cutimage10refine_$d$e/U_Net_$d$e$a$b"
      		fi
	GLOG_logtostderr=1 $caffe_path/predict_seg_new.bin \
            --model=predictDSNYCversion.prototxt \
            --weights=DSNtrain10refine_iter_$d.caffemodel \
            --data=/tempspace/jli1/icmldata/cremi3D_A_test40cut/cremi3D_A_seg_train3X3_v1_test40_$a$b.h5 \
            --predict=$predict_dir/U_Net_$d$e$a$b \
            --shift_axis=2 \
            --shift_stride=1 \
            --gpu=0
done
done
done
