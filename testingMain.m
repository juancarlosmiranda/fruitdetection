%Testing main
% Here I test objects and calls
clc; clear all; close all;
inputPathFileXML='/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/square_annotations1/BD04_inf_201724_004_01_RGB.xml';



%IRGB=imread('/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/images/BD04_inf_201724_004_01_RGBhr.jpg');
%load('/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/images/BD04_inf_201724_004_01_DS.mat');

% this is a result from fruit detector, it is a selected
%IRGBClusterProcessedPath='/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/outcomesLAB/BD04_inf_201724_004_01_RGBhr.jpgC2.jpg'
IRGBClusterProcessedPath=fullfile(pwd,'development/fruitdetection/testingImages/BD04_inf_201724_004_01_RGBhr.jpgC2.jpg');           

IRGBClusterProcessed=imread(IRGBClusterProcessedPath);

%INIR=NIR_DEPTH_res_crop;
%% Read configuration
[humanLabeledListBbox humanLabels]=XMLObjectsHelper.readXMLFromFIleBbox(inputPathFileXML);

IoUThreshold=0.50;
counting=CountingFruitsProcessor(IRGBClusterProcessed);
counting=counting.detectObjects();
resultsEvaluation=counting.evaluateObjectsInImage(humanLabeledListBbox, humanLabels, IoUThreshold);
objectDetectedMask2=counting.getBinarizedObjectsDetected();
resultsEvaluation.printMetrics();

% write results in files, get total count from expert and counted by system

figure;imshow(IRGBClusterProcessed);
figure;imshow(objectDetectedMask2);
