% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------

classdef testDatasetSplitProcessor < matlab.unittest.TestCase
    % testDatasetSplitProcessor
    % Test results in evaluation methods
    %
    % USAGE
    % testCase = testDatasetSplitProcessor;
    % res = run(testCase)
    %
    methods (Test)
        function createRepository(testCase)
            fprintf('testevaluateObjectsInImage(testCase) \n')
            pathDataset=fullfile(pwd,'development/fruitdetection/miniKFuji_RGB-DS_dataset/preprocessed data/');
            %pathDataset=fullfile(pwd,'Descargas/KFuji_RGB-DS_dataset/preprocessed data/');
            pathToSets=fullfile(pathDataset,'sets');
            aFileList=fullfile(pathToSets,'test_123.txt');
            %aFileList=fullfile(pathToSets,'train.txt');
            
            copySquaresflash=1; % 1 = true, 0=false to copy squares files
            %outputPathFolder=fullfile(pwd,'development/datasets_deep_learning/fuji_training/');
            outputPathFolder=fullfile(pwd,'development/fruitdetection/fuji_training/');            
            % -------------------------------------------------------------
            % -------------------------------------------------------------
            dsSplitProcessor=DatasetSplitProcessor(pathDataset);
            outputPathFolderCreated=dsSplitProcessor.createRepository(aFileList,copySquaresflash, outputPathFolder);
            % -------------------------------------------------------------
            % Results
            % -------------------------------------------------------------
            expResult=outputPathFolder;
            %outputPathFolderCreated=0;
            % -------------------------------------------------------------
            testCase.verifyEqual(outputPathFolderCreated,expResult);
            % -------------------------------------------------------------
        end
    end
end