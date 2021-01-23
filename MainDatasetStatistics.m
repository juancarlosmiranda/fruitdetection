% MAINDATASETSTATISTICS
%
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
%
% Get as input a folder with images and NIR data from Kinect.
% Extract data from each file and get statistics
%
% USAGE:
% MainDatasetStatistic.main()
%
% It script requires a dataset with images RGB and NIR data, this must be
% pre-processed in order to put the same resolution for both RGB image and
% NIR  data. This dataset must respect the dition of
%/dataset root
%             -/ images
%             -/ square_annotations1

%% Settings
clc; clear all; close all;

%% Images folders Path
DatasetPath=fullfile('/','home','usuario','development','fruitdetection','fuji_training');
%DatasetPath=fullfile('/','home','usuario','development','fruitdetection','fuji_test');
mainPathDsRGB=fullfile(DatasetPath,'images','/'); % RGB
mainPathDsNIR=fullfile(DatasetPath,'images','/'); % NIR
mainPathDsXML=fullfile(DatasetPath,'square_annotations1','/'); % path to XML squares labeled by human

%% Output results paths
pathOutputResultsSegLAB=fullfile(DatasetPath,'outcomesLAB','/');
pathOutputResultsHeatmap=fullfile(DatasetPath,'outcomesHeatmap','/');
pathOutputResultsFeaturesFiles=fullfile(DatasetPath,'outcomesFiles','/');


% clear old files
removeFiles(strcat(pathOutputResultsSegLAB,'*.jpg'));

%% ---------------------------------------
FolderImages='images';
FolderSquareAnnotations='square_annotations1';
ExtensionRGB='hr.jpg';
ExtensionNIR='DS.mat';
ExtensionSquare='.xml';
%pathDataset;
%pathDatasetImages;
%pathDatasetSquareAnnotations;
% ----------------------------------------

% load file names list
fileList=dir(strcat(mainPathDsRGB,'*.jpg'));

headers_t={'image_name', 'meanLABL', 'meanLABa', 'meanLABb', 'stdLABL', 'stdLABa', 'stdLABb', 'meanNIR1', 'stdNIR1', 'label_class'};
cellRecord = {'',0,0,0,0,0,0,0,0,''};
tablaDSTrainingAll = cell2table(cellRecord(1:end,:),'VariableNames',headers_t)

%% reading folder in batch mode
for n=1:size(fileList)
    fprintf('Get -> %s \n',fileList(n).name);
    currentFileName=fileList(n).name;
    inputIRGBPath=fullfile(mainPathDsRGB,currentFileName);
    % ----------------------------------------
    % BD04_inf_201724_004_01_DS.mat
    subnameendNIR=(size(currentFileName,2)-9);
    subnameNIR=currentFileName(1:subnameendNIR);
    fileNameNIR=strcat(subnameNIR,ExtensionNIR);
    
    % BD12_inf_201711_017_03_RGB.xml
    subnameendSquares=(size(currentFileName,2)-6);
    subnameSquares=currentFileName(1:subnameendSquares);
    fileNameSquares=strcat(subnameSquares,ExtensionSquare);
    % ----------------------------------------
    pathFileSourceNIR=fullfile(mainPathDsNIR,fileNameNIR);
    % ----------------------------------------
    pathFileSourceSquares=fullfile(mainPathDsXML, fileNameSquares);
    % ----------------------------------------
    fprintf('CurrentFileName -> %s \n', currentFileName);
    fprintf('inputIRGBPath -> %s \n', inputIRGBPath);
    fprintf('pathFileSourceNIR -> %s \n',pathFileSourceNIR);
    fprintf('pathFileSourceSquares -> %s \n',pathFileSourceSquares);
    % --------------------
    % open files with data
    % --------------------
    IRGB=imread(inputIRGBPath);
    load(pathFileSourceNIR);
    INIR=NIR_DEPTH_res_crop;
    % --------------------
    % --------------------
    % read file OK
    % read get it NIR data OK
    % read rectangle data OK
    % given an image and rectagles cut each apple to save data OK.
    % given an image and rectagles cut each apple to get features.
    % given each apple ROI, get features
    % given each apple ROI, get features and save in a list
    
    %
    [humanLabeledListBbox humanLabels]=XMLObjectsHelper.readXMLFromFIleBbox(pathFileSourceSquares);
    % -----------------------------
    % with image cut using rectange
    % -----------------------------
    labelToFilter='Poma';
    dataFeatureProcessor=DataFeatureProcessor(IRGB, INIR, currentFileName);
    resultsEvaluation=dataFeatureProcessor.cutSquaresByLabelRGB(humanLabeledListBbox, humanLabels, labelToFilter, pathOutputResultsSegLAB);
    %resultsEvaluation=dataFeatureProcessor.cutSquaresByLabelNIR(humanLabeledListBbox, humanLabels, labelToFilter, pathOutputResultsSegLAB);
    
    % unified in one image
    %GOOD resultsEvaluation=dataFeatureProcessor.cutSquaresByLabelNIRUnified(humanLabeledListBbox, humanLabels, labelToFilter, pathOutputResultsSegLAB);
    %GOOD resultsEvaluation=dataFeatureProcessor.cutSquaresByLabelRGBUnified(humanLabeledListBbox, humanLabels, labelToFilter, pathOutputResultsSegLAB);
    % -----------------------------
    %dataFeatureProcessor.drawHeatmap(pathOutputResultsHeatmap);
    % -----------------------------        
    %GOOD tablaDSTraining=dataFeatureProcessor.getFeaturesByLabelRGB(humanLabeledListBbox, humanLabels, labelToFilter, pathOutputResultsFeaturesFiles);
    tablaDSTraining=dataFeatureProcessor.getFeaturesByLabelRGBNIR(humanLabeledListBbox, humanLabels, labelToFilter, pathOutputResultsFeaturesFiles);
    tablaDSTrainingAll=[tablaDSTrainingAll; tablaDSTraining]
    % -----------------------------
    %break;
    
    
end %
pathFileCroppedSave=fullfile(pathOutputResultsFeaturesFiles,'allfiles.csv')
writetable(tablaDSTrainingAll,pathFileCroppedSave,'Delimiter',';')

% NIR calc
meanNIR1One=mean2(tablaDSTrainingAll{3:end,'meanNIR1'});
stdNIR1One=mean2(tablaDSTrainingAll{3:end,'stdNIR1'});
possible_t1=meanNIR1One-stdNIR1One;
possible_t2=meanNIR1One+stdNIR1One;
fprintf('NIR--> meanNIR1One=%3f stdNIR1One=%3f t1=%3f t2=%3f \n', meanNIR1One, stdNIR1One, possible_t1, possible_t2);

% -------- LAB -------------
%headers_t={'image_name', 'meanLABL', 'meanLABa', 'meanLABb', 'stdLABL', 'stdLABa', 'stdLABb', 'meanNIR1', 'stdNIR1', 'label_class'};
meanLABL=mean2(tablaDSTrainingAll{3:end,'meanLABL'});
stdLABL=mean2(tablaDSTrainingAll{3:end,'stdLABL'});
possible_t1L=meanLABL-stdLABL;
possible_t2L=meanLABL+stdLABL;
%fprintf('L*--> meanNIR1One=%3f stdNIR1One=%3f t1=%3f t2=%3f \n', meanLABL, stdLABL, possible_t1L, possible_t2L);

meanLABa=mean2(tablaDSTrainingAll{3:end,'meanLABa'});
stdLABa=mean2(tablaDSTrainingAll{3:end,'stdLABa'});
possible_t1a=meanLABa-stdLABa;
possible_t2a=meanLABa+stdLABa;
fprintf('A*--> meanLABa=%3f stdLABa=%3f t1=%3f t2=%3f \n', meanLABa, stdLABa, possible_t1a, possible_t2a);

meanLABb=mean2(tablaDSTrainingAll{3:end,'meanLABb'});
stdLABb=mean2(tablaDSTrainingAll{3:end,'stdLABb'});
possible_t1b=meanLABa-stdLABb;
possible_t2b=meanLABa+stdLABb;
fprintf('B*--> meanLABb=%3f stdLABb=%3f t1=%3f t2=%3f \n', meanLABb, stdLABb, possible_t1b, possible_t2b);

