% MAINFRUITSSEGLABKMEANS
%
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
%
% Get as input an RGB image.
% Convert to L*a*b and apply K-means classifier
% From an image, this code takes pixels with values in RGB color space
% and then convert it to L*a*b color space values.
% The values are clustered with K-means algorithms
%
% USAGE:
% MainFruitsSegLABKmeans.main()
%

%% Settings
clc; clear all; close all;

%% Images folders Path
DatasetPath=fullfile('/','home','usuario','development','fruitdetection','fuji_test');
%DatasetPath=fullfile('/','home','usuario','development','fruitdetection','fuji_test');
mainPathDsRGB=fullfile(DatasetPath,'images','/'); % RGB
mainPathDsNIR=fullfile(DatasetPath,'images','/'); % NIR
mainPathDsXML=fullfile(DatasetPath,'square_annotations1','/'); % path to XML squares labeled by human

%% Output results paths
pathOutputResultsSegLAB=fullfile(DatasetPath,'outcomesLAB','/');
pathOutputResultsHeatmap=fullfile(DatasetPath,'outcomesHeatmap','/');
pathOutputResultsFeaturesFiles=fullfile(DatasetPath,'outcomesFiles','/');


% TODO: CLEAR PATHS AND ADD OFFICIAL PATH
%% Path Images folders
mainPath=fullfile('/','home','usuario','development','fruitdetection','testingImages');
mainInputPath=fullfile('/','home','usuario','development','datasets_deep_learning','ClippedFujiDataset','original','/')



%% Cut images
%pathAplicacionAprender=strcat(mainPath,'tmpToLearnK/'); 

 %% Salida de clusters
pathOutputResultsSegLAB=fullfile(mainPath,'outcomesLAB','/');
%pathOutputResultsSegHSV=fullfile(mainPath,'outcomesHSV','/');


%% Llamado de función de clustering
clustersQuantity=3;
clusteringRepetition=3;

removeFiles(strcat(pathOutputResultsSegLAB,'*.jpg'));
%removeFiles(strcat(pathOutputResultsSegHSV,'*.jpg'));

%carga del listado de nombres
fileList=dir(strcat(mainInputPath,'*.jpg'));
%fileList=dir(strcat(mainInputPath,'*.mat'));

%% lectura en forma de bach del directorio de la cámara
for n=1:size(fileList)
    fprintf('Extrayendo manchas-> %s \n',fileList(n).name);    
    nombreImagenP=fileList(n).name;
    %% salida segmentacion
    %nombreImagenP='BD04_inf_201724_004_01_RGBhr.jpg';
    %nombreImagenP='apples_squares_1.jpg';
    OutputImageName=strcat(mainInputPath,nombreImagenP);    
    OutputImageNameLAB=strcat(pathOutputResultsSegLAB,nombreImagenP);
    %OutputImageNameHSV=strcat(pathOutputResultsSegHSV,nombreImagenP);
    fprintf('Clustering -> %s \n',fileList(n).name);        
    fprintf('OutputImageName -> %s \n',OutputImageName);        
    fprintf('OutputImageNameLAB -> %s \n',OutputImageNameLAB);
    %fprintf('nombreImagenSalidaHSV -> %s \n',OutputImageNameHSV);
    % --------------------
    IRGB=imread(OutputImageName);
    % --------------------
    clusterProcessor=KmeansClusterProcessor(clustersQuantity, clusteringRepetition, IRGB);
    clusterProcessor=clusterProcessor.segmentImage();
    clusterProcessor.saveClustersImages(OutputImageNameLAB);
    arrayS=clusterProcessor.getClusters;
    %% -----------------------------
    %labelToFilter='Poma';
    %filterClassifier=FilterClassifier(labelToFilter);
    %IMfiltered=filterClassifier.runFilterClassifier(arrayS);
    %figure;imshow(IMfiltered);
    % -----------------------------    
    break;
    
    %% NIR EXTRACTION by k-means
    %load '/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/original/BD12_sup_201711_171_08_DS.mat'
    %IRGB=imread('/home/usuario/development/datasets_deep_learning/ClippedFujiDataset/original/BD12_sup_201711_171_08_RGBhr.jpg')   
    %INIR=NIR_DEPTH_res_crop;
    %clusterProcessor=KmeansNIRClusterProcessor(clustersQuantity, clusteringRepetition, INIR);
    %clusterProcessor=clusterProcessor.segmentImage();
    %%clusterProcessor.saveClustersImages(OutputImageNameLAB);
    %arrayS=clusterProcessor.getClusters;
    
    
    %% ----------------------
    %t=65
    %maskNIR=arrayS{1}(:,:,1)
    %nirMask2=maskNIR(:,:)>t
    %IsegmentedNIR(:,:,1)=immultiply(IRGB(:,:,1),uint8(nirMask2));
    %IsegmentedNIR(:,:,2)=immultiply(IRGB(:,:,2),uint8(nirMask2));
    %IsegmentedNIR(:,:,3)=immultiply(IRGB(:,:,3),uint8(nirMask2));    
    %figure; imshow(IsegmentedNIR)
    %figure; imshow(arrayS{1}(:,:,1))
    %figure; imshow(nirMask2)    
    % iterate over arrayS, for each image get every blob
    
        
    break;
end %

