% Comparaing IoU calculated by MATLAB Computer Vision Toolbox and a 
%function with matemathical operations.
%


% bounding boxes ar defined in the format of [x, y, width, height]
clc; close all; clear all;
bboxA = [150,80,100,100];
bboxB=bboxA+50

IRGBClusterProcessedPath='/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/outcomesLAB/BD04_inf_201724_004_01_RGBhr.jpgC2.jpg';
IRGBClusterProcessed=imread(IRGBClusterProcessedPath);

RGBBoxed=insertShape(IRGBClusterProcessed,'FilledRectangle',bboxA,'Color','green');
RGBBoxed=insertShape(RGBBoxed,'FilledRectangle',bboxB,'Color','yellow');
imshow(RGBBoxed);

overlapRatio=bboxOverlapRatio(bboxA,bboxB);



%% IoU by manual method
% bounding boxes ar defined in the format of [x, y, width, height]
% Idea adapted from https://analyticsindiamag.com/5-object-detection-evaluation-metrics-that-data-scientists-should-know/
% 
bboxA = [150,80,100,100];
bboxB=bboxA+50;

x1=bboxA(1);
y1=bboxA(2);
w1=bboxA(3);
h1=bboxA(4);

x2=bboxB(1);
y2=bboxB(2);
w2=bboxB(3);
h2=bboxB(4);


w_intersection = min(x1 + w1, x2 + w2) - max(x1, x2);
h_intersection = min(y1 + h1, y2 + h2) - max(y1, y2);

if (w_intersection <= 0) or (h_intersection <= 0)
    fprintf('w_intersection=%d h_intersection=%d',w_intersection, h_intersection);
    IoUResult=0;
else
    I = w_intersection * h_intersection;
    U = w1 * h1 + w2 * h2 - I;
    IoUResult= I/U;
end



fprintf('Rounded Without round overlapRatio=%3f using Computer Vision Toolbox\n',overlapRatio);
fprintf('Rounded overlapRatio=%3f using Computer Vision Toolbox\n',round(overlapRatio,2));
fprintf('Without round IoUResult=%3f \n',IoUResult);
fprintf('Rounded IoUResult=%3f \n',round(IoUResult,2));
