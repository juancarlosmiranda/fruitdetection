% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------
% Testing ...

classdef testFeaturesExtractionNIR < matlab.unittest.TestCase
    % testFeaturesExtraction
    % Test results in evaluation methods
    %
    % USAGE
    % testCase = testFeaturesExtraction;
    % res = run(testCase)
    %
    methods (Test)
        % -----------------------------------------------------------------
        function testColorFeaturesNIR(testCase)
            fprintf('testColorFeaturesNIR(testCase) \n')
            home_user=pwd
            % -------------------------------------------------------------
            INIRPath=fullfile(home_user,'fruitdetection/testingImages/BD04_inf_201724_004_01_RGBhr.jpg_DS_1.mat')
            load(INIRPath);
            INIR=INIRObject;
            % -------------------------------------------------------------            
            featureExtractor=FeaturesExtractionNIR(INIR);
            [meanChannel1, meanChannel2, stdChannel1, stdChannel2, minChannel1, maxChannel1] = featureExtractor.getColorFeaturesNIR();            
            % -------------------------------------------------------------
            % NIR 96.899644 135.976917 - std2 34.565475 29.246105
            % NIR 84.651770 84.644524 - std2 26.089533 28.808006 - min 17.633631 - max 130.034656

            expMeanChannel1=84.651770;
            expMeanChannel2=84.644524;            
            expStdChannel1=26.089533;            
            expStdChannel2=28.808006;
            expMinChannel1=17.633631;            
            expMaxChannel1=130.034656;                        
            % -------------------------------------------------------------
            testCase.verifyEqual(meanChannel1, expMeanChannel1,'AbsTol',0.5);            
            testCase.verifyEqual(meanChannel2, expMeanChannel2,'AbsTol',0.5);            
            testCase.verifyEqual(stdChannel1,expStdChannel1,'AbsTol',0.5);                        
            testCase.verifyEqual(stdChannel2,expStdChannel2,'AbsTol',0.5);                        
            testCase.verifyEqual(minChannel1,expMinChannel1,'AbsTol',0.5);                                    
            testCase.verifyEqual(maxChannel1,expMaxChannel1,'AbsTol',0.5);                                                
            % -------------------------------------------------------------
        end        
    end
end

