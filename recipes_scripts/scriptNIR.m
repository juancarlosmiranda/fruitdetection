% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------

% Script to get images cropped, cut images with a rectagle coordinates
% Shows a general images and one fruit cropped

%% setting environment
clc; close all; clear all;
home_user=pwd;
pathScript=fullfile(home_user,'development/fruitdetection/');
pathTestImages=fullfile(home_user,'development/fruitdetection/testingImages/');
pathTestNIR=fullfile(home_user,'development/fruitdetection/testingImages/');

% data names: images and NIR
imageName='BD04_inf_201724_004_01_RGBhr.jpg';
imageNameNIR='BD04_inf_201724_004_01_DS.mat';

%% load NIR
load(fullfile(pathTestNIR, imageNameNIR));

% --------------------------------
IRGBPath=fullfile(pathTestImages, imageName);
IRGB=imread(IRGBPath);
InirChannel1=NIR_DEPTH_res_crop(:,:,1);  % getn channel 1 from NIR
% --------------------------------

humanLabeledListBbox=[72,10,47,47;
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

% ------------------------------------
figure; imshow(IRGB);
    
for i=1:size(humanLabeledListBbox,1)
    %i=3;
    % -------------------------------
    x1=humanLabeledListBbox(i,1);
    y1=humanLabeledListBbox(i,2);
    x2=humanLabeledListBbox(i,3)+x1;
    y2=humanLabeledListBbox(i,4)+y1;

    ISelected2 = IRGB(y1:y2, x1:x2);
    % copy all RGB channles
    ISelected2(:,:,1) = IRGB(y1:y2, x1:x2,1);
    ISelected2(:,:,2) = IRGB(y1:y2, x1:x2,2);
    ISelected2(:,:,3) = IRGB(y1:y2, x1:x2,3);
    % -------------------------------    
    figure; imshow(ISelected2);
    % -------------------------------        
    INIRSelected=InirChannel1(y1:y2, x1:x2);
    meanNIR=mean2(INIRSelected(:,:));
    stdNIR=std2(INIRSelected(:,:));
    minNIR=min(INIRSelected(:));    
    maxNIR=max(INIRSelected(:));    
    
    fprintf('%3f %3f %3f %3f \n', meanNIR, stdNIR, minNIR, maxNIR);
    break;
    % -------------------------------
end
