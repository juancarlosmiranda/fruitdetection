%Testing main
% Here I test objects and calls
clc; clear all; close all;
inputPathFileXML='/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/square_annotations1/BD04_inf_201724_004_01_RGB.xml';



%IRGB=imread('/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/images/BD04_inf_201724_004_01_RGBhr.jpg');
%load('/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/images/BD04_inf_201724_004_01_DS.mat');

% this is a result from fruit detector, it is a selected
IRGBClusterProcessedPath='/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/outcomesLAB/BD04_inf_201724_004_01_RGBhr.jpgC2.jpg'
IRGBClusterProcessed=imread(IRGBClusterProcessedPath);

%INIR=NIR_DEPTH_res_crop;
%% Read configuration
[humanLabeledListBbox humanLabel]=XMLObjectsHelper.readXMLFromFIleBbox(inputPathFileXML);
% [humanLabeledList humanLabel]=XMLObjectsHelper.readXMLFromFIle(inputPathFileXML);
% humanLabeledList, the format of vector is []
%[150,80,100,100]

% the format of humanLabeledList [xmin, ymin, xmax, ymax]
% it has to be converted to [xmin, ymin, width, height] 
% [72, 10, 119-72, 57-10]
%humanLabeledList=[
%    72,10,119,57;   % it has correspondence TP
%    300,50,350,100; % TP 0.8
%    119,167,170,219; % it has correspondence TP
%    80,80,85,85 % it has not correspondence only marked by human but not detected FN
%    ]

% [72, 10, 119-72, 57-10]
%rectangleVector=[
%    72,10,119-72,57-10;  %TP
%    300,50,340-300,80-30; % TP 0.8
%    119,167,170-119,219-167; %TP overlap 1
%    150,150,10,10 %FP yellow
%    200,200,10,10 %FP yellow    
%    ]

% X(1,:)

IoUThreshold=0.50;
counting=CountingFruitsProcessor(IRGBClusterProcessed);
counting=counting.detectObjects();

% to test only
%counting.rectangleVector=rectangleVector;

resultsEvaluation=counting.evaluateObjectsInImage(humanLabeledListBbox, humanLabel, IoUThreshold);
objectDetectedMask2=counting.getBinarizedObjectsDetected();
resultsEvaluation.printMetrics();


%figure;imshow(IRGBClusterProcessed);
%figure;imshow(objectDetectedMask2);
