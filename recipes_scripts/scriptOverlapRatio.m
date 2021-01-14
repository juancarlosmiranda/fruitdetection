% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------
% Comparaing IoU calculated by MATLAB Computer Vision Toolbox and a
% function with matemathical operations.
%  
% BD04_inf_201724_004_01_RGBhr.jpg -> Dataset Title: KFuji RGB-DS dataset
% [2] Gené-Mola J, Vilaplana V, Rosell-Polo JR, Morros JR, Ruiz-Hidalgo J, Gregorio E. 2019.
% KFuji RGB-DS database: Fuji apple multi-modal images for fruit detection with color, depth and range-corrected IR data. Data in brief, 25 (2019), 104289. DOI: 10.1016/j.dib.2019.104289

%

%% setting environment
clc; close all; clear all;
home_user=pwd;
pathScript=fullfile(home_user,'development/fruitdetection/recipes_scripts/');

% input data
pathTestImages=fullfile(pathScript,'testingImages/');
pathTestNIR=fullfile(pathScript,'testingImages/');
IRGBClusterProcessedPath=fullfile(pathTestImages,'BD04_inf_201724_004_01_RGBhr.jpgC2.jpg');

% ---------------------------
% [xmin, ymin, width, height]
humanLabeledListBbox=[
    72,10,47,47;
    299,35,51,51;
    119,167,51,52;
    46,227,45,46;
    152,269,50,49;
    266,230,44,44;
    305,246,44,44;
    205,324,49,47;
    397,270,39,39;
    307,122,49,49;
    99,136,35,35;
    61,141,39,39;
    40,80,47,47;
    1,211,40,42;
    30,331,42,40;
    493,61,45,45;
    446,45,45,45
    ];

% conversion to make more readable
xminH=humanLabeledListBbox(1,1);
yminH=humanLabeledListBbox(1,2);
widthH=humanLabeledListBbox(1,3);
heigthH=humanLabeledListBbox(1,4);

% --------------------------
%% IoU by Computer Vision Tool
% bounding boxes ar defined in the format of [x, y, width, height]
bboxA = [xminH, yminH, widthH, heigthH];
bboxB=[82,20,47,47;];

IRGBClusterProcessed=imread(IRGBClusterProcessedPath);

RGBBoxed=insertShape(IRGBClusterProcessed,'FilledRectangle',bboxA,'Color','green');
RGBBoxed=insertShape(RGBBoxed,'FilledRectangle',bboxB,'Color','yellow');
imshow(RGBBoxed);

overlapRatio=bboxOverlapRatio(bboxA,bboxB);



%% IoU by manual method
% bounding boxes ar defined in the format of [x, y, width, height]
% Idea adapted from https://analyticsindiamag.com/5-object-detection-evaluation-metrics-that-data-scientists-should-know/
%
bboxA = [xminH, yminH, widthH, heigthH];
bboxB=[82,20,47,47;];

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

if (w_intersection <= 0) || (h_intersection <= 0)    
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
