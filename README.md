# Spatial Transformer Networks with TPS transformation in Caffe

This code implemented the hot-off-the-press-paper [Spatial Transformer Network](http://arxiv.org/abs/1506.02025) in one of the most popular deep learning frameworks -- [Caffe](http://caffe.berkeleyvision.org/). This code implemented the Spatial Transformer Network with TPS transformation.

## Oragnization of the code

* **src/caffe/layers:** contains the CPU implementation (two `.cpp` files) for Spatial Transformer with TPS Layer.I will update the GPU part as soon as possible. In that part, there will have two `.cu` files for the Layer.
* **src/caffe/proto:** contains my proto definition for Spatial Transformer Layer (Search for 'CtoParaParameter' and 'TPStransformParameter').
* **include:** contains two `.hpp` files for the layer.
* **examples:** contains several sample setting files (`.prototxt`,'.sh' files) for its usages on MNIST digits and training. They should be useful in understanding how to use my Spatial Transformer with TPS layer. 

## Reference

This code was implemented based on the Spatial Transformer Networks with Affine transformation, which has been implemented by Carey Mo:(https://github.com/daerduoCarey/SpatialTransformerLayer). 

## Acknowledge
The code is implemented at the first semester of my Master degree study. Since it is my first time implement an C++ application, the code might not be as effective as possible. But here, I still want to thank great help from my advisor Dr.Ji and Ph.D students T.Zeng, J.Li and Z.Wang.
