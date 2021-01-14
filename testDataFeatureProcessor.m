% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------

classdef testDataFeatureProcessor < matlab.unittest.TestCase
    % testCountingFruitsProcessor
    % Test results in evaluation methods
    %
    % USAGE
    % testCase = testDataFeatureProcessor;
    % res = run(testCase)
    %
    methods (Test)
        function testevaluateObjectsInImage(testCase)
            fprintf('testevaluateObjectsInImage(testCase) \n')
            pathToSave=fullfile(pwd,'development/fruitdetection/testingImages/test_cropped');
            IRGBClusterProcessedPath=fullfile(pwd,'development/fruitdetection/testingImages/BD04_inf_201724_004_01_RGBhr.jpg');           
            IRGBClusterProcessed=imread(IRGBClusterProcessedPath);
            IoUThreshold=0.50;
            % -------------------------------------------------------------
            humanLabeledListBbox=[72,10,47,47;
                299,35,51,51;
                119,167,51,52;
                46,227,45,46;
                152,269,50,49;
                266,230,44,44;
                305,246,44,44;
                205,324,49,47;
                397,270,39,39;
                307,122,49,49;
                99,136,35,35;
                61,141,39,39;
                40,80,47,47;
                1,211,40,42;
                30,331,42,40;
                493,61,45,45;
                446,45,45,45
                ];
            
            humanLabels={'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma';
                'Poma'
                };
             
            % -------------------------------------------------------------
            labelToFilter='Poma';
            imageName='BD04_inf_201724_004_01_RGBhr.jpg';
            dataFeatureProcessor=DataFeatureProcessor(IRGBClusterProcessed, imageName);
            resultsEvaluation=dataFeatureProcessor.cutSquaresByLabelRGB(humanLabeledListBbox, humanLabels, labelToFilter, pathToSave);
            % -------------------------------------------------------------
            resultsEvaluation=1;
            expResult=1;
            % -------------------------------------------------------------
            testCase.verifyEqual(resultsEvaluation, expResult);
            % -------------------------------------------------------------
        end
    end
end

