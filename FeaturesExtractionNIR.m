% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------
classdef FeaturesExtractionNIR
    %FeaturesExtraction .
    %   .
    properties
        ImageNIR
    end
    
    methods
        function obj = FeaturesExtractionNIR(ImageNIR)
            % FeaturesExtraction
            %   .
            obj.ImageNIR = ImageNIR;
        end        
                
        function resultMeanNIR = getMeanNIR(obj)
            meanR=mean2(obj.ImageNIR(:,:,1));
            meanG=mean2(obj.ImageNIR(:,:,2));
            meanB=mean2(obj.ImageNIR(:,:,3));
            stdR=std2(obj.ImageNIR(:,:,1));
            stdG=std2(obj.ImageNIR(:,:,2));
            stdB=std2(obj.ImageNIR(:,:,3));
            fprintf('RGB %3f %3f %3f - std2 %3f %3f %3f \n', meanR, meanG, meanB, stdR, stdG, stdB);
            resultMeanNIR=0;
        end

        
    end % end of methods
end % end of class

