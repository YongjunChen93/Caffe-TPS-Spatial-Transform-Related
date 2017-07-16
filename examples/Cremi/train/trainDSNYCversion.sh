caffe_path=/tempspace/ychen7/TZcaffe/caffe_nd_sense_segmentation/build/tools
log_dir=logDSNtrain10YCversion
GLOG_log_dir=$log_dir $caffe_path/caffe train \
--solver=DSNYCversionsolver.prototxt \
--gpu 8 \
#--snapshot=DSNtrain10refine_iter_6000.solverstate \
#--snapshot=trained_weights/inception_fcn_mscal_classifier_fullstacks_train_iter_1322.solverstate
#--snapshot=trained_weights/inception_fcn_iter_20069.solverstate \
#--gpu 3
#--weights=../../trained_temp/bigneuron_7fm_vgg_init_deconv_iter_391.caffemodel \

