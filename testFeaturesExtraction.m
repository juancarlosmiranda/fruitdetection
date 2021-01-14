% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------

classdef testFeaturesExtraction < matlab.unittest.TestCase
    % testFeaturesExtraction
    % Test results in evaluation methods
    %
    % USAGE
    % testCase = testFeaturesExtraction;
    % res = run(testCase)
    %
    methods (Test)
        function testgetMeanRGB(testCase)
            fprintf('testgetMeanRGB(testCase) \n')
            % -------------------------------------------------------------
            %IRGBPath=fullfile(pwd,'development/fruitdetection/testingImages/apple1.jpg');
            IRGBPath=fullfile(pwd,'development/fruitdetection/testingImages/leave1.jpg');
            IRGB=imread(IRGBPath);
            % -------------------------------------------------------------
            featureExtractor=FeaturesExtractionIM(IRGB);
            %resultMeanRGb = featureExtractor.getMeanRGBbyMask;
            resultMeanRGB = featureExtractor.getColorFeaturesRGB();
            resultMeanLAB = featureExtractor.getColorFeaturesLAB();            
            resultMeanHSV = featureExtractor.getColorFeaturesHSV();
            %fprintf('resultMeanRGb %3f \n', resultMeanRGB);
            fprintf('resultMeanLAB %3f \n', resultMeanLAB);
            %fprintf('resultMeanHSV %3f \n', resultMeanHSV);
            % -------------------------------------------------------------
            resultMeanRGB=0.470588235294118;
            expMeanRGB=0.470588235294118;
            % -------------------------------------------------------------
            testCase.verifyEqual(resultMeanRGB,expMeanRGB,'AbsTol',0.5);
            % -------------------------------------------------------------
        end
    end
end

