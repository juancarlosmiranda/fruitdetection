clc; close all; clear all;
%/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/original/BD12_sup_201711_171_08_DS.mat
load '/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/original/BD12_sup_201711_171_08_DS.mat'

IRGB=imread('/home/usuario/development/fruitDetector/testingImages/BD12_sup_201711_171_08_RGBhr.jpg1C3.jpg');
Igray=im2gray(IRGB);


figure;
imshow(Igray)

%% Binarización de la silueta fondo removido
umbral=graythresh(Igray);
IB1=im2bw(Igray,umbral); %Imagen tratada


%% Elimina los elementos cuya area es igual al parametro, deja los elementos grandes
tamanoObjeto=50
IB2=bwareaopen(IB1,tamanoObjeto);
IMask=IB2;



%% The background is removed using a binary mask and multiplying the matrices
IBackground(:, :, 1)=immultiply(IRGB(:, :, 1),IMask);
IBackground(:, :, 2)=immultiply(IRGB(:, :, 2),IMask);
IBackground(:, :, 3)=immultiply(IRGB(:, :, 3),IMask);


figure; imshow(IMask);
figure; imshow(IBackground);

IBackgroundGray=im2gray(IBackground);

Idepth=immultiply(NIR_DEPTH_res_crop(:,:,1),IMask);
%Inir=immultiply(NIR_DEPTH_res_crop(:,:,2),IMask;

figure;
imshow(im2gray(Idepth))
surf(Idepth)

%% Circle detection
%%[centers, radii, metric] = imfindcircles(Igray,[1 90]);
%[centers,radii, metric] = imfindcircles(IBackgroundGray,[10 80],'ObjectPolarity','dark');

%%centersStrong5 = centers(1:5,:); 
%%radiiStrong5 = radii(1:5);
%%metricStrong5 = metric(1:5);

%centersStrong5 = centers(:,:); 
%radiiStrong5 = radii(:);
%metricStrong5 = metric(:);

%viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');

