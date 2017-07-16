#!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-7.0/lib64 
caffe_path=/tempspace/ychen7/TZcaffe/caffe_nd_sense_segmentation/build/tools 
for idmodel in {9500..9500..100}
do
	for idx in {1..5..1}
	do
		for idy in {1..5..1}
 	    do
	    a=w$idx
            b=_h$idy
 	    d=$idmodel
  	    e=result
		predict_dir1=U_Nettest_cutimage10refine_$d$e;
      		if [ ! -d "$predict_dir1" ]; then
     		 # Control will enter here if $DIRECTORY doesn't exist.
      		mkdir "U_Nettest_cutimage10refine_$d$e"
     		fi
		predict_dir=U_Nettest_cutimage10refine_$d$e/U_Net_$d$e$a$b;
      		if [ ! -d "$predict_dir" ]; then
      		# Control will enter here if $DIRECTORY doesn't exist.
      		mkdir "U_Nettest_cutimage10refine_$d$e/U_Net_$d$e$a$b"
      		fi
	GLOG_logtostderr=1 $caffe_path/predict_seg_new.bin \
            --model=predictDSNYCversion.prototxt \
            --weights=DSNtrain10refine_iter_$d.caffemodel \
            --data=/tempspace/jli1/icmldata/snemi3d_test80cut/snemi3d_test_v16_$a$b.h5 \
            --predict=$predict_dir/U_Net_$d$e$a$b \
            --shift_axis=2 \
            --shift_stride=1 \
            --gpu=4
done
done
done
