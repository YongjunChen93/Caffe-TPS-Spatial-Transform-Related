#include <vector>

    #include <boost/shared_ptr.hpp>
    #include <gflags/gflags.h>
    #include <glog/logging.h>

    #include <cmath>

    #include "caffe/blob.hpp"
    #include "caffe/common.hpp"
    #include "caffe/layers/TPS_AfterT.hpp"
    #include "caffe/util/math_functions.hpp"

    namespace caffe{
        
    template <typename Dtype>
    void TPStransformerLayer<Dtype>::LayerSetUp(const vector<Blob<Dtype>*>& bottom,const vector<Blob<Dtype>*>& top){
    //setup for prototxt
        string prefix = "\t\tTPStransformer Layer:: LayerSetUp: \t";

        //setup dU
        if(this->layer_param_.st_tparam().to_compute_du()) {
            to_compute_dU_ = true;
        }

        //get image size H and W
        output_H_ = bottom[0]->shape(2);
        
        if(this->layer_param_.st_tparam().has_output_h()) {
            output_H_ = this->layer_param_.st_tparam().output_h();
        }
        output_W_ = bottom[0]->shape(3);
        
        if(this->layer_param_.st_tparam().has_output_w()) {
            output_W_ = this->layer_param_.st_tparam().output_w();
        }
        std::cout<<prefix<<"output_H_ = "<<output_H_<<", output_W_ = "<<output_W_<<std::endl;


    //initialize the matrix for output grid(1,x_i,y_i,r_i_1,r_i_2,...,r_i_16)
    //the same matrix(normalize)[-1,1] by [-1,1] fro all batch elements
        //Create Room
        std::cout<<prefix<<"Initializing the matrix for output grid"<<std::endl;
        vector<int> shape_output(2);
        shape_output[0] = output_H_ * output_W_;
        shape_output[1] = 19;
        output_grid.Reshape(shape_output);
        
        //Initialize 
        Dtype* data = output_grid.mutable_cpu_data();
        for(int i=0;i < output_H_ * output_W_; ++i){
            
            Dtype Rx, Ry, dis;
            Rx = (i / output_W_) * 1.0 / output_H_ * 2 - 1;
            Ry = (i % output_W_) * 1.0 / output_W_ * 2 - 1;
            Dtype x[16] = {-1,-0.333333,0.333333,1,-1,-0.333333,0.333333,1,-1,-0.333333,0.333333,1,-1,-0.333333,0.333333,1};
            Dtype y[16] = {-1,-1,-1,-1,-0.333333,-0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333,0.333333,1,1,1,1};
            data[19 * i] = 1;
            data[19 * i + 1] = Rx;
            data[19 * i + 2] = Ry;
            for(int j = 0; j<16;j++){
                            dis = (pow((Rx - x[j]),2) + pow((Ry - y[j]),2));
                if(dis==0){
                data[19 * i + j + 3] = (Dtype)0.;
                }
                else{
                data[19 * i + j + 3] = (dis) * log (dis);
                            }
    //std::cout << "i=" << i << ",j=" << j << ",dis=" << dis << std::endl;
            }
        }


    //initialize the matrix for input grid 
    //the input grid gives, for(i,j) in the output, the corresponding position(projection) on the input
        std::cout<<prefix<<"Initializing the matrix for input grid"<<std::endl;
        
        vector<int> shape_input(3);
        shape_input[0] = bottom[1]->shape(0);
        shape_input[1] = output_H_ * output_W_;
        shape_input[2] = 2;
        input_grid.Reshape(shape_input);
        
        std::cout<<prefix<<"Initialization done."<<std::endl;

    }

    template <typename Dtype>
    void TPStransformerLayer<Dtype>::Reshape(const vector<Blob<Dtype>*>& bottom,const vector<Blob<Dtype>*>& top) {
    //Print Reshape Start

        string prefix = "\t\tTPStransformer Layer:: Reshape: \t";
        
        if(global_debug) std::cout<<prefix<<"Starting!"<<std::endl;
        
        N = bottom[0]->shape(0);
        C = bottom[0]->shape(1);
        H = bottom[0]->shape(2);
        W = bottom[0]->shape(3);


    //Reshape V
        vector<int> shape(4);
        
        shape[0] = N;
        shape[1] = C;
        shape[2] = output_H_;
        shape[3] = output_W_;
        
        top[0]->Reshape(shape);

    // reshape dT_tmp for GPU
            vector<int> dT_tmp_shape(4);

            dT_tmp_shape[0] = N;
            dT_tmp_shape[1] = 2;
            dT_tmp_shape[2] = 19;
            dT_tmp_shape[3] = output_H_ * output_W_ * C;

            dT_tmp.Reshape(dT_tmp_shape);

    // init all_ones_2 for GPU
            vector<int> all_ones_2_shape(1);
            all_ones_2_shape[0] = output_H_ * output_W_ * C;
            all_ones_2.Reshape(all_ones_2_shape);


    //Reshape Full_T
        vector<int> full_T_shape(2);
        
        full_T_shape[0] = N;
        full_T_shape[1] = 38;
        full_T.Reshape(full_T_shape);
        
        if(global_debug) std::cout<<prefix<<"Finished."<<std::endl;
    }

    //Bilinear interpolate
    template <typename Dtype>
    Dtype TPStransformerLayer<Dtype>::transform_forward_cpu(const Dtype* pic, Dtype px, Dtype py){

    //Compute V
        bool debug = false;
        string prefix = "\t\tTPStransformer Layer:: transform_forward_cpu:: \t";
        if(debug) std::cout<<prefix<<"Starting!\t"<<std::endl;
        if(debug) std::cout<<prefix<<"(px,py) = ("<<px<<", "<<py<<")"<<std::endl;
        
        Dtype res = (Dtype)0.;

        //integral coordinates
        Dtype x = (px + 1) / 2 * H;
        Dtype y = (py + 1) / 2 * W;
        
        if(debug) std::cout<<prefix<<"(x, y) = ("<<x<<", "<<y<<")"<<std::endl;
        
        for(int m = floor(x); m <= ceil(x); ++m){
            for(int n = floor(y); n <= ceil(y); ++n){
                if(debug) std::cout<<prefix<<"- (m, n) = ("<<m<<", "<<n<<")"<<std::endl;
                if(m >= 0 && m < H && n >= 0 && n < W){
                    res += (1 - abs(x - m)) * (1 - abs(y - n)) * pic[m * W + n];
                    if(debug) std::cout<<prefix<<" pic[m, n] = "<<pic[m * W + n]<<std::endl;
                }
            }	
        }
        if(debug) std::cout<<prefix<<"Finished.\tres = "<<res<<std::endl;
        return res;
    }

    template <typename Dtype>
    void TPStransformerLayer<Dtype>::Forward_cpu(const vector<Blob<Dtype>*>& bottom,const vector<Blob<Dtype>*>& top) {

    //Print Forward
        string prefix = "\t\tTPStransformer Layer:: Forward_cpu: \t ";

        if(global_debug) std::cout<<prefix<<"Starting"<<std::endl;

    //declare the variables
        const Dtype* U = bottom[0]->cpu_data();
        const Dtype* T = bottom[1]->cpu_data();
        
        Dtype* full_T_data = full_T.mutable_cpu_data();//already initialized at setup layer
        
        Dtype* input_grid_data = input_grid.mutable_cpu_data();
        const Dtype* output_grid_data = output_grid.cpu_data();
        
        Dtype* V = top[0]->mutable_cpu_data();
        
        //initialize mutable_cpu_data arrays
        caffe_set(input_grid.count(), (Dtype)0, input_grid_data);
        caffe_set(top[0]->count(), (Dtype)0, V);
        
    //Compute Full T
        if(global_debug) std::cout<<prefix<<"compute full T"<<std::endl;
        int k = 0;
        for(int i = 0; i < 38; ++i){
            for(int j = 0; j < N; j++){
                full_T_data[full_T.offset(j,i)] = T[bottom[1]->offset(j,k)];
                if(global_debug) std::cout<<prefix<<"assigning"<<T[bottom[1]->offset(j,k)] << std::endl;
            }
            ++ k;
        }

    //For each input in the batch, compute P_input=T*P_output in [-1, 1]
        for(int i = 0; i < N; ++i){
            
            Dtype* coordinates = input_grid_data + (output_H_ * output_W_ * 2) * i;
            
            caffe_cpu_gemm<Dtype>(CblasNoTrans, CblasTrans, output_H_ * output_W_, 2, 19, (Dtype)1., output_grid_data, full_T_data+38 * i, (Dtype)0., coordinates);
            
            int row_idx;//index of position
            Dtype px, py;//x,y in [-1,1]
            
            for(int j = 0; j < C; ++j)
                for(int s = 0; s < output_H_; ++s)
                    for(int t = 0; t < output_W_; ++t){
                        
                        row_idx = output_W_ * s + t;
                        
                        px = coordinates[row_idx * 2];
                        py = coordinates[row_idx * 2 + 1];

    //Run transform_forward_cpu				
                     if(global_debug && i==0)std::cout<<"j="<<j<<", s="<<s<<", t="<<t<<", px="<<px<<", py="<<py<<std::endl;	
                        V[top[0]->offset(i, j, s, t)] = transform_forward_cpu(U + bottom[0]->offset(i,j,0,0), px , py);
                        
                    }
            
        }
        if(global_debug) std::cout<<prefix<<"Finished."<<std::endl;

    }

    //Compute coordinate of dL/dU, dV/dP
    template <typename Dtype>
    void TPStransformerLayer<Dtype>::transform_backward_cpu(Dtype dV, const Dtype* U, const Dtype px,const Dtype py, Dtype* dU, Dtype& dpx, Dtype& dpy){

    //Because dL/dV * dV/dU = dL/dU, dV/dU = + (1-abs(x-m))*(1-abs(y-n))
    //So dL/dU += dL/dV * (1-abs(x-m))*(1-abs(y-n))
    //Compute dL/dU( or call dU)
    //dL/dV * dV/dP = dL/dP. 
    //Compute dL/dP 
        bool debug = false;
        string prefix = "\t\tTPStransformer Layer:: transform_backward_cpu:\t";
        if(debug) std::cout<<prefix<<"Starting!"<<std::endl;
        
        //Get integral coordinates (x,y)
        Dtype x = (px + 1) / 2 * H;
        Dtype y = (py + 1) / 2 * W;
        if(debug) std::cout<<prefix<<"(x,y) = ("<<x<<","<<y<<")"<<std::endl;

        for(int m = floor(x); m <= ceil(x); ++m){
            for(int n = floor(y); n <= ceil(y); ++n){
                if(debug) std::cout<<prefix<<"(m,n) = ("<<m<<","<<n<<")"<<std::endl;
                if(m >= 0 && m < H && n >= 0 && n < W){
                    //dL/dV * dV/dP = dL/dP. 
                    dU[m * W +n] += dV * (1 - abs(x-m)) * (1 - abs(y - n));
                    //Compute dL/dP 
                    dpx += caffe_sign<Dtype>(m - x) * (1 - abs(y - n)) * U[m * W + n] * dV * H / 2;
                    dpy += caffe_sign<Dtype>(n - y) * (1 - abs(x - m)) * U[m * W + n] * dV * W / 2;
                    
                    if(debug) std::cout<<prefix<<"dpy +="<<max(0, 1-abs(x - m))<<" * "<<U[m * W + n]<<" * "<<dV<<" * "<<W / 2<<std::endl;
                } 
            }
            if(debug) std::cout<<prefix<<"Finished."<<std::endl;
        }

    }

    //Compute dV/dT and dV/dU
    template <typename Dtype>
    void TPStransformerLayer<Dtype>::Backward_cpu(const vector<Blob<Dtype>*>& top,const vector<bool>& propagate_down,const vector<Blob<Dtype>*>& bottom) {

    //Print Backward
        string prefix ="\t\tTPStransformer Layer:: Backward_cpu: \t";
        
        if(global_debug) std::cout<<prefix<<"Starting!"<<std::endl;
        
        const Dtype* dV = top[0]->cpu_diff();
        const Dtype* input_grid_data = input_grid.cpu_data();
        const Dtype* U = bottom[0]->cpu_data();
        const Dtype* output_grid_data_diff = output_grid.cpu_data();
        
        Dtype* dU = bottom[0]->mutable_cpu_diff();
        Dtype* dT = bottom[1]->mutable_cpu_diff();
        Dtype* input_grid_diff = input_grid.mutable_cpu_diff();
        
        caffe_set(bottom[0]->count(), (Dtype)0, dU);
        caffe_set(bottom[1]->count(), (Dtype)0, dT);
        caffe_set(input_grid.count(), (Dtype)0, input_grid_diff);
        
    //Compute dL/dU, dV/dP, dL/dT	
        for(int i = 0; i < N; ++i){
            const Dtype* coordinates = input_grid_data + (output_H_ * output_W_ * 2) * i;
            Dtype* coordinates_diff = input_grid_diff + (output_H_ * output_W_ * 2) * i;
            
            int row_idx;
            Dtype px, py, dpx, dpy, delta_dpx, delta_dpy;
            
            for(int s = 0; s < output_H_; ++s){
                for(int t = 0; t < output_W_; ++t){
                    
                    row_idx = output_W_ * s + t;
                    
                    px = coordinates[row_idx * 2];
                    py = coordinates[row_idx * 2 + 1];
                    
                    for(int j = 0; j < C; ++j){
                        
                        delta_dpx = delta_dpy = (Dtype)0.;
    //Run transform_backward_cpu got dL/dU, dV/dP
                        transform_backward_cpu(dV[top[0]->offset(i, j, s, t)], U + bottom[0]->offset(i, j, 0, 0), px, py, 
                                    dU + bottom[0]->offset(i, j, 0, 0), delta_dpx, delta_dpy);
                        coordinates_diff[row_idx * 2] += delta_dpx;
                        coordinates_diff[row_idx * 2 + 1] += delta_dpy;					
                        
                    }
                    
                    //Because dL/dT = dL/dV * dV/dP * dP/dT,
                    //Compute dL/dT	
                    dpx = coordinates_diff[row_idx * 2];
                    dpy = coordinates_diff[row_idx * 2 + 1];
                    //dV/dT1=dV/dx*(dx/dT1)
                    for(int j = 0; j < 19; ++j){
                        dT[38 * i + j] += dpx * output_grid_data_diff[row_idx * 19 + j]; 
                                            //if(i==2 && row_idx == 0)std::cout << "output_grid_data_diff[" << j << "]=" << output_grid_data_diff[row_idx * 19 + j] << std::endl;
                    }
                    //dV/dT2=dV/dy*(dy/dT2)
                    for(int j = 19; j < 38; ++j){
                        dT[38 * i + j] += dpy * output_grid_data_diff[row_idx * 19 + j - 19];
    //if(i==2 && row_idx == 0)std::cout << "output_grid_data_diff[" << j << "]=" << output_grid_data_diff[row_idx * 19 + j-19] << std::endl; 
                    }
                }
            }
        }

    }	

    #ifdef CPU_ONLY
        STUB_GPU(TPStransformerLayer);
        #endif

        INSTANTIATE_CLASS(TPStransformerLayer);
        REGISTER_LAYER_CLASS(TPStransformer);
        
    }//namespace caffe

