% testing NIR parameters
%
% Load dta from NIR matrix and makes a threshold filter over the channels
%
%

clc; close all; clear all;
load '/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/original/BD04_inf_201724_004_01_DS.mat'
IRGB=imread('/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/original/BD04_inf_201724_004_01_RGBhr.jpg')



% -----------------------
InirChannel1=NIR_DEPTH_res_crop(:,:,1)  % getn channel 1 from NIR
InirChannel2=NIR_DEPTH_res_crop(:,:,2)  % getn channel 2 from NIR
t=70;
%nirMask1=InirChannel1(:,:)<t
nirMask2=InirChannel1(:,:)>t

% ----------
IsegmentedNIR(:,:,1)=immultiply(IRGB(:,:,1),nirMask2);
IsegmentedNIR(:,:,2)=immultiply(IRGB(:,:,2),nirMask2);
IsegmentedNIR(:,:,3)=immultiply(IRGB(:,:,3),nirMask2);


figure; imshow(IRGB);
figure; imshow(IsegmentedNIR);

%imwrite(IsegmentedNIR,'/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/original/fromNIR1.jpg','jpg');



%% to k-means over one NIR channel
%nir=NIR_DEPTH_res_crop(:,:,1)
%% reshape to list of pairs
%pixelsList = nir(:,:,1); % extract values from channel 1
%nRows = size(pixelsList,1);
%nCols = size(pixelsList,2);
%pixelsList = reshape(pixelsList,nRows*nCols,1); %cambia la figura



% Channel S: 
% Channel D:


%% to plot data NIR
 figure; heatmapHandle1 = heatmap(InirChannel1, 'ColorMap', jet(100));
 maximumValue=max(InirChannel1(:))
 caxis(heatmapHandle1,[0 maximumValue])
 saveas(heatmapHandle1,'/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/outcomesHeatmap/MYHEATMAP1','png'); 


 figure; heatmapHandle2 = heatmap(InirChannel2, 'ColorMap', jet(100));
 maximumValue=max(InirChannel2(:))
 caxis(heatmapHandle2,[0 maximumValue])
 saveas(heatmapHandle2,'/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/outcomesHeatmap/MYHEATMAP2','png'); 