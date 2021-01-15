% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------
% Testing color-based features for RGB, LAB, HSV colro spaces

classdef testFeaturesExtractionIM < matlab.unittest.TestCase
    % testFeaturesExtraction
    % Test results in evaluation methods
    %
    % USAGE
    % testCase = testFeaturesExtraction;
    % res = run(testCase)
    %
    methods (Test)
        % -----------------------------------------------------------------
        function testColorFeaturesRGB(testCase)
            fprintf('testColorFeaturesRGB(testCase) \n')
            home_user=pwd
            % -------------------------------------------------------------
            IRGBPath=fullfile(home_user,'fruitdetection/testingImages/BD04_inf_201724_004_01_RGBhr.jpg_1.jpg')
            IRGB=imread(IRGBPath);
            % -------------------------------------------------------------            
            featureExtractor=FeaturesExtractionIM(IRGB);
            [resultMeanR, resultMeanG, resultMeanB, resultStdR, resultStdG, resultStdB] = featureExtractor.getColorFeaturesRGB();            
            % -------------------------------------------------------------
            % RGB 133.698113 121.315863 128.957372 - std2 82.700250 66.947032 79.124462
            % RGB 180.394531 185.025174 177.781684 - std2 65.570758 52.049187 62.389665 
            expMeanR=180.394531;
            expMeanG=185.025174;            
            expMeanB=177.781684;            
            expStdR=65.570758;
            expStdG=52.049187;            
            expStdB=62.389665;            
            % -------------------------------------------------------------
            testCase.verifyEqual(resultMeanR,expMeanR,'AbsTol',0.5);            
            testCase.verifyEqual(resultMeanG,expMeanG,'AbsTol',0.5);            
            testCase.verifyEqual(resultMeanB,expMeanB,'AbsTol',0.5);                        
            testCase.verifyEqual(resultStdR,expStdR,'AbsTol',0.5);                        
            testCase.verifyEqual(resultStdG,expStdG,'AbsTol',0.5);                        
            testCase.verifyEqual(resultStdB,expStdB,'AbsTol',0.5);                                    
            % -------------------------------------------------------------
        end        
        % -----------------------------------------------------------------
        function testColorFeaturesLAB(testCase)
            fprintf('testColorFeatures(testCase) \n')
            home_user=pwd;
            % -------------------------------------------------------------
            IRGBPath=fullfile(home_user,'fruitdetection/testingImages/BD04_inf_201724_004_01_RGBhr.jpg_1.jpg');
            IRGB=imread(IRGBPath);
            % -------------------------------------------------------------
            featureExtractor=FeaturesExtractionIM(IRGB);
            [resultMeanL, resultMeanA, resultMeanB, resultStdL, resultStdA, resultStdB] = featureExtractor.getColorFeaturesLAB();            
            % -------------------------------------------------------------
            % LAB 74.071321 -3.247036 3.593657 - std2 21.210117 10.683761 6.751480
            expMeanLABL=74.071321;
            expMeanLABa=-3.247036;            
            expMeanLABb=3.593657;           
            expStdLABL=21.210117;
            expStdLABa=10.683761;            
            expStdLABb=6.751480;            
            % -------------------------------------------------------------
            testCase.verifyEqual(resultMeanL,expMeanLABL,'AbsTol',0.5);            
            testCase.verifyEqual(resultMeanA,expMeanLABa,'AbsTol',0.5);            
            testCase.verifyEqual(resultMeanB,expMeanLABb,'AbsTol',0.5);                        
            testCase.verifyEqual(resultStdL,expStdLABL,'AbsTol',0.5);                        
            testCase.verifyEqual(resultStdA,expStdLABa,'AbsTol',0.5);                        
            testCase.verifyEqual(resultStdB,expStdLABb,'AbsTol',0.5);                                    
            % -------------------------------------------------------------
        end
        % -----------------------------------------------------------------
        function testColorFeaturesHSV(testCase)
            fprintf('testColorFeaturesHSV(testCase) \n')
            home_user=pwd;
            % -------------------------------------------------------------
            IRGBPath=fullfile(home_user,'fruitdetection/testingImages/BD04_inf_201724_004_01_RGBhr.jpg_1.jpg');
            IRGB=imread(IRGBPath);
            % -------------------------------------------------------------            
            featureExtractor=FeaturesExtractionIM(IRGB);
            [resultMeanH, resultMeanS, resultMeanV, resultStdH, resultStdS, resultStdV] = featureExtractor.getColorFeaturesHSV();            
            % -------------------------------------------------------------
            % HSV 0.628720 0.225088 0.540300 - std2 0.317671 0.211912 0.309886 
            % HSV 0.506991 0.151803 0.755682 - std2 0.295421 0.159484 0.221293
            expMeanH=0.506991;
            expMeanS=0.151803;            
            expMeanV=0.755682;            
            expStdH=0.295421;
            expStdS=0.159484;            
            expStdV=0.221293;            
            % -------------------------------------------------------------
            testCase.verifyEqual(resultMeanH,expMeanH,'AbsTol',0.5);            
            testCase.verifyEqual(resultMeanS,expMeanS,'AbsTol',0.5);            
            testCase.verifyEqual(resultMeanV,expMeanV,'AbsTol',0.5);                        
            testCase.verifyEqual(resultStdH,expStdH,'AbsTol',0.5);                        
            testCase.verifyEqual(resultStdS,expStdS,'AbsTol',0.5);                        
            testCase.verifyEqual(resultStdV,expStdV,'AbsTol',0.5);                                    
            % -------------------------------------------------------------
        end        
        % -----------------------------------------------------------------
    end
end

