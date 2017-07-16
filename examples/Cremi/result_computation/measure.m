function [ precision, recall, f1 ] = measure( prediction, label, threshold )%assume label is height*width*slice
%MEASURE Summary of this function goes here
%   Detailed explanation goes here


prediction_label = prediction >= threshold;
TP_FP = sum(sum(sum(prediction_label)));
TP_FN = sum(sum(sum(label)));
TP = sum(sum(sum(prediction_label&label)));
precision = TP/TP_FP;
recall = TP/TP_FN;
f1 = 2*precision*recall/(precision+recall);

end