% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------
% This script contains the NDI calculation implemented in Matlab to subtract red colors and green colors.
% Use the binary mask technique to obtain the desired object.
% This technique is widely used in computer vision systems applied to agriculture. For more information you can read
%
% Hamuda, E., Glavin, M., & Jones, E. (2016). A survey of image processing techniques for plant extraction and segmentation in the field. Computers and Electronics in Agriculture, 125, 184–199. https://doi.org/10.1016/j.compag.2016.04.024
% Meyer, G. E., & Neto, J. C. (2008). Verification of color vegetation indices for automated crop imaging applications. Computers and Electronics in Agriculture, 63(2), 282–293. https://doi.org/10.1016/j.compag.2008.03.009
%

%% setting environment
clc; close all; clear all;
home_user=pwd;
pathScript=fullfile(home_user,'development/fruitdetection/recipes_scripts/');

% input data
pathTestImages=fullfile(pathScript,'test_ndi_index/');

% output data
path_output_images=fullfile(pathScript,'test_ndi_index/');

% data names: images
% Here the link for public images
%
% BD04_inf_201724_004_01_RGBhr.jpg -> Dataset Title: KFuji RGB-DS dataset
% [2] Gené-Mola J, Vilaplana V, Rosell-Polo JR, Morros JR, Ruiz-Hidalgo J, Gregorio E. 2019.
% KFuji RGB-DS database: Fuji apple multi-modal images for fruit detection with color, depth and range-corrected IR data. Data in brief, 25 (2019), 104289. DOI: 10.1016/j.dib.2019.104289
%
% soil1.png v--> https://www.growwilduk.com/blog/there%E2%80%99s-weed-my-lawn-what-should-i-do-about-it
% soil2.jpeg -> https://www.topcropmanager.com/weed-recovery-after-burial-by-soil-19747/
% % soil3.jpeg --> % https://www.growwilduk.com/sites/default/files/styles/default_image_style_compressive/public/images/blog/seeds.jpg?itok=alwp0CYl

imageName1='BD04_inf_201724_004_01_RGBhr.jpg';
imageName4='soil1.png';
%imageName4='soil2.jpeg'; %uncomment to see results
%imageName4='soil3.jpeg'; %uncomment to see results

IRGB1=imread(fullfile(pathTestImages,imageName1));
IRGB4=imread(fullfile(pathTestImages,imageName4));
% ------------------------------------
% NDI1=(R-G)/(R+G)  NDI2=(R-B)/(R+B)  NDI3=(B-G)/(B+G)

%% NDI1=128*(R-G)/((R+G)+1) good for extraction of red colors
R=double(IRGB1(:,:,1));
G=double(IRGB1(:,:,2));
RminG=R-G;
RG=R+G;
RGplus1=RG+1;
NDI1=128*(RminG./(RGplus1)); % it is good for red color
%---------------------------------------
% binarization NDI1
umbral=graythresh(NDI1); % get a better threshold
MaskNDI1=im2bw(NDI1,umbral);
% multiply by mask created with ND4
IMsegmented1(:,:,1)=immultiply(IRGB1(:,:,1),MaskNDI1);
IMsegmented1(:,:,2)=immultiply(IRGB1(:,:,2),MaskNDI1);
IMsegmented1(:,:,3)=immultiply(IRGB1(:,:,3),MaskNDI1);
figure('Name','NDI1 for red color', 'Position', get(0, 'Screensize')); montage({IRGB1,MaskNDI1,IMsegmented1});
% ------------------------------------

%% NDI4= 128*(G-R)/((G+R)+1) good for extraction of green colors
R=double(IRGB4(:,:,1));
G=double(IRGB4(:,:,2));
GminR=G-R;
GR=G+R;
GRplus1=GR+1;
NDI4=128*(GminR./(GRplus1)); % it is good for green color
%---------------------------------------
% binarization NDI4
umbral=graythresh(NDI4); % get a better threshold
MaskNDI4=im2bw(NDI4,umbral);
% multiply by mask created with ND4
IMsegmented4(:,:,1)=immultiply(IRGB4(:,:,1),MaskNDI4);
IMsegmented4(:,:,2)=immultiply(IRGB4(:,:,2),MaskNDI4);
IMsegmented4(:,:,3)=immultiply(IRGB4(:,:,3),MaskNDI4);
figure('Name','NDI4 for green color', 'Position', get(0, 'Screensize')); montage({IRGB4,MaskNDI4,IMsegmented4});
% ------------------------------------
