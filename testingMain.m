%Testing main
% Here I test objects and calls
clc; close all; clear all;
home_user=pwd;
mainPath=fullfile(home_user,'development/fruitdetection/testingImages/');
inputPathFileXML=fullfile(mainPath, '/square_annotations1/');
IRGBPath=fullfile(pwd,'development/fruitdetection/testingImages/');
INIRPath=fullfile(pwd,'development/fruitdetection/testingImages/');

% --------------- file names
filePathXML=fullfile(inputPathFileXML, 'BD04_inf_201724_004_01_RGB.xml');
filePathIRGB=fullfile(IRGBPath, 'BD04_inf_201724_004_01_RGBhr.jpg');
filePathNIR=fullfile(INIRPath, 'BD04_inf_201724_004_01_DS.mat');

% --------------- open files 
IRGBToFilter=imread(filePathIRGB);
load(filePathNIR);
INIRToFilter=NIR_DEPTH_res_crop;


 %% Salida de clusters
pathOutputResultsSegLAB=fullfile(mainPath,'outcomesLAB','/');
nombreImagenP='lab_clusters';
OutputImageNameLAB=strcat(pathOutputResultsSegLAB,nombreImagenP);


%% Hyperparameters
clustersQuantity=3;
clusteringRepetition=3;
IoUThreshold=0.50; % to account a fruit or not fruit
t1=25; t2=77; % thresholds NIR


%INIR=NIR_DEPTH_res_crop;
%% Read configuration
[humanLabeledListBbox humanLabels]=XMLObjectsHelper.readXMLFromFIleBbox(filePathXML);
% -------------------------------------------------------------------------
% NIR FILTER
% -------------------------------------------------------------------------
% -------------------------------------------------------------
% -------------------------------------------------------------
nirFilterProcessor=NIRFilterProcessor(IRGBToFilter, INIRToFilter);
nirFilterProcessor=nirFilterProcessor.segmentImage(t1,t2);
IFilteredNIR=nirFilterProcessor.getSegmentedNIRObjects();
%figure; imshow(IFilteredNIR);
% -------------------------------------------------------------------------
% KMEAN FILTER
% -------------------------------------------------------------------------
clusterProcessor=KmeansClusterProcessor(clustersQuantity, clusteringRepetition, IFilteredNIR);
clusterProcessor=clusterProcessor.segmentImage();
clusterProcessor.saveClustersImages(OutputImageNameLAB);
arrayS=clusterProcessor.getClusters;

% -------------------------------------------------------------------------
% CLASSIFIER FILTER
% -------------------------------------------------------------------------
% put here a rule to read each image, for each image apply a classifier
% result is an image with candidates to count

%% -----------------------------
%labelToFilter='Poma';
%filterClassifier=FilterClassifier(labelToFilter);
%IMfiltered=filterClassifier.runFilterClassifier(arrayS);
%figure;imshow(IMfiltered);
% -----------------------------

IRGBClusterProcessed=imread(fullfile(pathOutputResultsSegLAB,'lab_clustersC1.jpg'));
% -------------------------------------------------------------------------
% counting fruits and evaluating
% -------------------------------------------------------------------------
counting=CountingFruitsProcessor(IRGBClusterProcessed);
counting=counting.detectObjects();
resultsEvaluation=counting.evaluateObjectsInImage(humanLabeledListBbox, humanLabels, IoUThreshold);
objectDetectedMask2=counting.getBinarizedObjectsDetected();
resultsEvaluation.printMetrics();

% write results in files, get total count from expert and counted by system
%figure;imshow(IRGBClusterProcessed);
%figure;imshow(objectDetectedMask2);
