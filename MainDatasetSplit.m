% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------
% MAINDATASETSPLIT
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
% ---------------------------------------
fprintf('Creating training dataset from  "KFuji_RGB-DS_dataset" \n')
pathDataset=fullfile(pwd,'/Descargas/KFuji_RGB-DS_dataset/preprocessed data/');
%pathDataset=fullfile(pwd,'development/fruitdetection/miniKFuji_RGB-DS_dataset/preprocessed data/');

pathToSets=fullfile(pathDataset,'sets');
aFileList=fullfile(pathToSets,'train.txt');
copySquaresflash=1; % 1 = true, 0=false to copy squares files
outputPathFolderTraining=fullfile(pwd,'development/fruitdetection/fuji_training/');
% -------------------------------------------------------------
dsSplitProcessorTraining=DatasetSplitProcessor(pathDataset);
outputPathFolderTrainingCreated=dsSplitProcessorTraining.createRepository(aFileList,copySquaresflash, outputPathFolderTraining);
% -------------------------------------------------------------

%% -------------------------------------------------------------

fprintf('Creating test dataset from  "KFuji_RGB-DS_dataset" \n')
pathDataset=fullfile(pwd,'/Descargas/KFuji_RGB-DS_dataset/preprocessed data/');
pathToSets=fullfile(pathDataset,'sets');
aFileList=fullfile(pathToSets,'test.txt');
copySquaresflash=1; % 1 = true, 0=false to copy squares files
outputPathFolderTest=fullfile(pwd,'development/fruitdetection/fuji_test/');

% -------------------------------------------------------------
dsSplitProcessorTest=DatasetSplitProcessor(pathDataset);
outputPathFolderTestCreated=dsSplitProcessorTest.createRepository(aFileList,copySquaresflash, outputPathFolderTest);
% -------------------------------------------------------------