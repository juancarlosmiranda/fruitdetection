% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: January 2020
% ------------------------------------------------------------------------

classdef testNIRFilterProcessor < matlab.unittest.TestCase
    % testNIRFilterProcessor
    % Test results in evaluation methods
    %
    % USAGE
    % testCase = testNIRFilterProcessor;
    % res = run(testCase)
    %
    methods (Test)
        function testSegmentObjectsNIR(testCase)
            fprintf('testSegmentObjectsNIR(testCase) \n');
            pathToSave=fullfile(pwd,'development/fruitdetection/testingImages/test_cropped');
            IRGBPath=fullfile(pwd,'development/fruitdetection/testingImages/BD04_inf_201724_004_01_RGBhr.jpg');
            INIRPath=fullfile(pwd,'development/fruitdetection/testingImages/BD04_inf_201724_004_01_DS.mat');
            IRGBToFilter=imread(IRGBPath);
            load(INIRPath);
            INIRToFilter=NIR_DEPTH_res_crop;
            % -------------------------------------------------------------
            % Define thresholds
            t1=25; t2=77;
            % -------------------------------------------------------------
            nirFilterProcessor=NIRFilterProcessor(IRGBToFilter, INIRToFilter);
            nirFilterProcessor=nirFilterProcessor.segmentImage(t1,t2);
            imageSegmentedNIR=nirFilterProcessor.getSegmentedNIRObjects();
            figure; imshow(imageSegmentedNIR);
            % nirFilterProcessor.saveFilteredImages(OutputImagePath);            
            % -------------------------------------------------------------
            resultsEvaluation=1;
            expResult=1;
            % -------------------------------------------------------------
            testCase.verifyEqual(resultsEvaluation, expResult);
            % -------------------------------------------------------------
        end
    end
end

