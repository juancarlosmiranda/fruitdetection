% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------

classdef testCountingFruitsProcessor < matlab.unittest.TestCase
    % testCountingFruitsProcessor
    % Test results in evaluation methods
    %
    % USAGE
    % testCase = testCountingFruitsProcessor;
    % res = run(testCase)
    %
    methods (Test)
        function testevaluateObjectsInImage(testCase)
            fprintf('testevaluateObjectsInImage(testCase) \n')
            IRGBClusterProcessedPath=fullfile(pwd,'development/fruitdetection/testingImages/BD04_inf_201724_004_01_RGBhr.jpgC2.jpg');           
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
            
            %
            %             rectangleVector=[49,234,36,33;
            %                 71,12,49,41;
            %                 118,170,54,48;
            %                 165,273,31,38;
            %                 178,364,36,10;
            %                 214,327,40,25;
            %                 258,363,1,1;
            %                 259,354,26,20;
            %                 260,233,52,35;
            %                 297,40,51,42;
            %                 306,127,40,36;
            %                 309,245,43,39;
            %                 400,276,36,29
            %                 ];
            %
            
            
            % -------------------------------------------------------------
            counting=CountingFruitsProcessor(IRGBClusterProcessed);
            counting=counting.detectObjects();
            resultsEvaluation=counting.evaluateObjectsInImage(humanLabeledListBbox, humanLabels, IoUThreshold);
            % -------------------------------------------------------------
            % resultsEvaluation.TP  8
            % allGroundTruths = 17
            % allDetected = 13
            % Detected TP = 8
            % Detected by system only FP = 5
            % Ground truth not detected FN = 9
            % Precision = 0.615385
            % Recall = 0.470588
            % -------------------------------------------------------------
            expallGroundTruths=17;
            expallDetectedSize = 13;
            expTP=8;
            expFP=5;
            expFN=9;
            expPrecision=0.615384615384615;
            expRecall=0.470588235294118;
            % -------------------------------------------------------------
            testCase.verifyEqual(resultsEvaluation.allGroundTruthsSize,expallGroundTruths);
            testCase.verifyEqual(resultsEvaluation.allDetectedSize,expallDetectedSize);
            testCase.verifyEqual(resultsEvaluation.TP,expTP);
            testCase.verifyEqual(resultsEvaluation.FP,expFP);
            testCase.verifyEqual(resultsEvaluation.FN,expFN);
            testCase.verifyEqual(resultsEvaluation.precision,expPrecision,'AbsTol',0.5);
            testCase.verifyEqual(resultsEvaluation.recall,expRecall,'AbsTol',0.5);
            % -------------------------------------------------------------
        end
    end
end

