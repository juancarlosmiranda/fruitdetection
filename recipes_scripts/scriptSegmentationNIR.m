% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------
% Segmentation using NIR and thresholds
% Given an image and its NIR data, filter by threshold NIR data in channel
% 1 to get a first approximation of fruits in a rgb IMAGE.
%
% Load dAta from NIR matrix and makes a threshold filter over the channels,
% this applies two thresholds at each end.
% This scripts serves as test for differents trhresholds to get a better 
% segmentation.
%% setting environment
clc; close all; clear all;
home_user=pwd;
pathScript=fullfile(home_user,'development/fruitdetection/recipes_scripts/');

% input data
pathTestImages=fullfile(pathScript,'testingImages/');
pathTestNIR=fullfile(pathScript,'testingImages/');

% output data
path_output_images=fullfile(home_user,'development/fruitdetection/testingImages/test_threshold_NIR/');

% data names: images and NIR
imageName='BD04_inf_201724_004_01_RGBhr.jpg';
imageNameNIR='BD04_inf_201724_004_01_DS.mat';
imageNameHeatmap_orig='BD04_inf_201724_004_01_DS.mat_h_orig.jpg';

% images names for mask 1
imageNameSegmentedMask_2_1='BD04_inf_201724_004_01_RGBhr.jpg_mask1.jpg';
imageNameHeatmap_2_1='BD04_inf_201724_004_01_DS.mat_h_2_1.jpg';

% images names for mask 2
imageNameSegmentedMask_2_2='BD04_inf_201724_004_01_RGBhr.jpg_mask2.jpg';
imageNameHeatmap_2_2='BD04_inf_201724_004_01_DS.mat_h_2_2.jpg';

%% load NIR and RGB images to test
load(fullfile(pathTestNIR, imageNameNIR));
IRGBPath=fullfile(pathTestImages, imageName);
IRGB=imread(IRGBPath);
INIR=NIR_DEPTH_res_crop; % load from file
% -----------------------
InirChannel1=NIR_DEPTH_res_crop(:,:,1);  % getn channel 1 from NIR
%InirChannel2=NIR_DEPTH_res_crop(:,:,2);  % getn channel 2 from NIR

%% configure thresholds and getting masks
t_single=70;
nirMask1=InirChannel1(:,:)>t_single; % This is a good solution

t1=90; t2=190;
nirMask2=(InirChannel1(:,:,1) >= t1 ) & (InirChannel1(:,:,1) <= t2);

%% segmentation with mask 1 single threshold
IRGBsegmented1(:,:,1)=immultiply(IRGB(:,:,1),nirMask1);
IRGBsegmented1(:,:,2)=immultiply(IRGB(:,:,2),nirMask1);
IRGBsegmented1(:,:,3)=immultiply(IRGB(:,:,3),nirMask1);

INIRsegmented1(:,:,1)=immultiply(INIR(:,:,1),nirMask1); % channel 1 segmented mask1
INIRsegmented1(:,:,2)=immultiply(INIR(:,:,2),nirMask1); % channel 2 segmented mask1

%% segmentation with mask 2 appliying two thresholds at each end
IRGBsegmented2(:,:,1)=immultiply(IRGB(:,:,1),nirMask2);
IRGBsegmented2(:,:,2)=immultiply(IRGB(:,:,2),nirMask2);
IRGBsegmented2(:,:,3)=immultiply(IRGB(:,:,3),nirMask2);

INIRsegmented2(:,:,1)=immultiply(INIR(:,:,1),nirMask2); % channel 1 segmented mask2
INIRsegmented2(:,:,2)=immultiply(INIR(:,:,2),nirMask2); % channel 2 segmented mask2

%% Figures
fo_1=figure('Name','Original RGB Image', 'Position', get(0, 'Screensize')); figure(fo_1); imshow(IRGB); title(['Original RGB Image']);
fo_2=figure('Name','Original NIR channel 1', 'Position', get(0, 'Screensize')); figure(fo_2); heatmapHandle_o_1 = heatmap(INIR(:,:,1), 'ColorMap', jet(100)); title(['Original NIR Channel 1']);
F=getframe(fo_2);
imwrite(F.cdata, fullfile(path_output_images, imageNameHeatmap_orig), 'jpg')

%% Mask 1
f1_1=figure('Name','RGB single threshold'); figure(f1_1); imshow(IRGBsegmented1); title(['RGB single threshold']);
imwrite(IRGBsegmented1, fullfile(path_output_images, imageNameSegmentedMask_2_1), 'jpg');

f2_1=figure('Name','NIR channel 1 single threshold', 'Position', get(0, 'Screensize')); figure(f2_1); heatmapHandle2_1 = heatmap(INIRsegmented1(:,:,1), 'ColorMap', jet(100)); title(['NIR channel 1 threshold NIR t=',num2str(t_single)]);
F=getframe(f2_1);
imwrite(F.cdata, fullfile(path_output_images, imageNameHeatmap_2_1), 'jpg')

%% Mask 2 two thresholds at each end.
f1_2=figure('Name','RGB Image with two threshold NIR'); figure(f1_2); imshow(IRGBsegmented2); title(['RGB Image with two threshold NIR']);
imwrite(IRGBsegmented2, fullfile(path_output_images, imageNameSegmentedMask_2_2), 'jpg');

f2_2=figure('Name','NIR channel 1 with two threshold', 'Position', get(0, 'Screensize')); figure(f2_2); heatmapHandle2_2 = heatmap(INIRsegmented2(:,:,1), 'ColorMap', jet(100)); title(['INIR double threshold t1=',num2str(t1), ' t2=',num2str(t2)]);
F=getframe(f2_2);
imwrite(F.cdata, fullfile(path_output_images, imageNameHeatmap_2_2), 'jpg')



%% surf data
% Create figure
f_3d_1 = figure('WindowState','maximized');
% Create axes
axes_3d_1 = axes('Parent',f_3d_1);
hold(axes_3d_1,'on');
% Create surf
handle_3d_1=surf(INIRsegmented2(:,:,1),'Parent',axes_3d_1);
view(axes_3d_1,[404.509053628641 76.7141774862933]);
grid(axes_3d_1,'on');
hold(axes_3d_1,'off');
saveas(handle_3d_1,fullfile(path_output_images, 'my_3dplot_1'),'png');
% -------------
f_3d_2 = figure('WindowState','maximized');
% Create axes
axes_3d_2 = axes('Parent',f_3d_2);
hold(axes_3d_2,'on');
% Create surf
handle_3d_2=surf(INIR(:,:,1),'Parent',axes_3d_2);
view(axes_3d_2,[404.509053628641 76.7141774862933]);
grid(axes_3d_2,'on');
hold(axes_3d_2,'off');
saveas(handle_3d_2,fullfile(path_output_images, 'my_3dplot_2'),'png');

%% Another recipe to get graphics
figure('Name','Another recipe'); 
heatmapHandle2 = heatmap(InirChannel1, 'ColorMap', jet(100)); 
maximumValue=max(InirChannel1(:)); 
caxis(heatmapHandle2,[0 maximumValue])
saveas(heatmapHandle2,fullfile(path_output_images, 'MYHEATMAP2'),'png');