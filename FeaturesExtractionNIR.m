% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% 
% Given a matrix with NIR data, it calculates statisticals features for
% reflection and depth
% spaces colors
%
% ------------------------------------------------------------------------
classdef FeaturesExtractionNIR
    %FeaturesExtraction .
    %   .
    properties
        ImageNIR
    end
    
    methods
        function obj = FeaturesExtractionNIR(ImageNIR)
            % FeaturesExtractionNIR
            %   .
            obj.ImageNIR = ImageNIR;
        end        
                
        function [meanChannel1, meanChannel2, stdChannel1, stdChannel2, minChannel1, maxChannel1] = getColorFeaturesNIR(obj)
            % getColorFeaturesNIR ..
            %   ..
            % -------------------------------------------------------------
            INIR=obj.ImageNIR;            
            meanChannel1=mean2(INIR(:,1));
            meanChannel2=mean2(INIR(:,2));
            stdChannel1=std2(INIR(:,1));
            stdChannel2=std2(INIR(:,2));
            minChannel1=min(INIR(:,1));
            maxChannel1=max(INIR(:,1));            
            fprintf('NIR %3f %3f - std2 %3f %3f - min %3f - max %3f\n', meanChannel1, meanChannel2, stdChannel1, stdChannel2, minChannel1, maxChannel1);
        end        
        
    end % end of methods
end % end of class

% TODO: add help to each methods