% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------
% Given an image and its NIR data, this scripts cuts each fruit and put
% the result in a final image to show only the fruits cropped.
% It produces a heatmap to show NIR data.

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
InirChannel2=NIR_DEPTH_res_crop(:,:,2);  % getn channel 2 from NIR
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

IRGBBlack=IRGB;
IRGBBlack(:,:,1)=0;
IRGBBlack(:,:,2)=0;
IRGBBlack(:,:,3)=0;

INIRSelected1=InirChannel1;
INIRSelected1(:,:)=0;

INIRSelected2=InirChannel2;
INIRSelected2(:,:)=0;



for i=1:size(humanLabeledListBbox,1)
    % -------------------------------
    x1=humanLabeledListBbox(i,1);
    y1=humanLabeledListBbox(i,2);
    x2=humanLabeledListBbox(i,3)+x1;
    y2=humanLabeledListBbox(i,4)+y1;
    % -------------------------------
    % copy all RGB channels
    IRGBBlack(y1:y2, x1:x2,1) = IRGB(y1:y2, x1:x2,1);
    IRGBBlack(y1:y2, x1:x2,2) = IRGB(y1:y2, x1:x2,2);
    IRGBBlack(y1:y2, x1:x2,3) = IRGB(y1:y2, x1:x2,3);
    % -------------------------------
    % copy all NIR channels
    INIRSelected1(y1:y2, x1:x2) = InirChannel1(y1:y2, x1:x2);
    INIRSelected2(y1:y2, x1:x2) = InirChannel2(y1:y2, x1:x2);
    % -------------------------------
    %break;
end
% -------------------------------
figure; imshow(IRGBBlack);
%figure; heatmap(INIRSelected);

f1=figure; heatmapHandle1 = heatmap(INIRSelected1(:,:,1), 'ColorMap', jet(100));maximumValue=max(INIRSelected1(:));caxis(heatmapHandle1,[0 maximumValue]);
f2=figure; heatmapHandle2 = heatmap(INIRSelected2(:,:,1), 'ColorMap', jet(100));maximumValue=max(INIRSelected2(:));caxis(heatmapHandle2,[0 maximumValue]);
% -------------------------------