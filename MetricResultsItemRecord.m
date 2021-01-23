% XMLITEMRECORD
%
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
%
classdef MetricResultsItemRecord
    %MetricResultsItemRecord This serve as record for results in counting
    %   ...
    
    properties
        allGroundTruthsSize;
        allDetectedSize;
        TP;
        FP;
        FN;
        precision;
        recall;
    end
    
    methods
        function obj = MetricResultsItemRecord(allDetectedSize, allGroundTruthsSize, TP)
            % size of all objects detected with the system
            obj.allDetectedSize=allDetectedSize;
            % size of all objects marked by humans as groundtruth
            obj.allGroundTruthsSize=allGroundTruthsSize;
            obj.TP=TP; % true positive detected with IoU metric
            obj.FP=allDetectedSize-TP;
            obj.FN=allGroundTruthsSize-TP;
            % Explanation allDetected=(TP+FP) precision=TP/(TP+FP);
            obj.precision=obj.TP/(obj.TP+obj.FP);
            % Explanation allGroundTruths=(TP+FN) recall=TP/(TP+FN);
            obj.recall=obj.TP/obj.allGroundTruthsSize;
        end
        function printMetrics(obj)
            fprintf('\n -------------------------------- \n');
            fprintf('printMetrics(obj)');
            fprintf('\n -------------------------------- \n');
            fprintf('allGroundTruths = %i \n', obj.allGroundTruthsSize);
            fprintf('allDetected = %i \n', obj.allDetectedSize);
            fprintf('Detected TP = %i \n', obj.TP);
            fprintf('Detected by system only FP = %i \n', obj.FP);
            fprintf('Ground truth not detected FN = %i \n', obj.FN);
            fprintf('Precision = %3f \n', obj.precision);
            fprintf('Recall = %3f \n', obj.recall);
        end
    end
end