% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------

classdef testMetricResultsItemRecord < matlab.unittest.TestCase
    % testMetricResultsItemRecord
    % Precision and recall classes
    % USAGE
    % testCase = testMetricResultsItemRecord;
    % res = run(testCase)
    %
    methods (Test)
        function testMetricResults(testCase)
            % all objects detected with the system
            allDetectedSize=13;
            % all objects marked by humans as groundtruth
            allGroundTruthsSize=17;
            TP=8;
            % --------------------------
            resultsFromImage=MetricResultsItemRecord(allDetectedSize, allGroundTruthsSize, TP);
            % ------------------------
            expSolutionTP=8;
            resultTP=resultsFromImage.TP;
            testCase.verifyEqual(resultTP,expSolutionTP);
            % ------------------------
            expSolutionallDetectedSize=13;
            resultalDetectedSize=resultsFromImage.allDetectedSize;
            testCase.verifyEqual(resultalDetectedSize,expSolutionallDetectedSize);
            testCase.verifyEqual(resultsFromImage, resultsFromImage);
            % ------------------------
            expSolutionPrecision=0.615384615384615;
            resultPrecision=resultsFromImage.recall;
            testCase.verifyEqual(resultPrecision,expSolutionPrecision,'AbsTol',0.5);
            % ------------------------
            expSolutionRecall=0.470588235294118;
            resultRecall=resultsFromImage.recall;
            testCase.verifyEqual(resultRecall,expSolutionRecall,'AbsTol',0.5);
        end
    end
end

