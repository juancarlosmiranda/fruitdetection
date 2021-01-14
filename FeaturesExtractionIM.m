% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------
classdef FeaturesExtractionIM
    %FeaturesExtraction .
    %   .
    properties
        ImageRGB
    end
    
    methods
        function obj = FeaturesExtractionIM(ImageRGB)
            % FeaturesExtraction
            %   .
            obj.ImageRGB = ImageRGB;
        end        

        
        function resultMeanRGB = getMeanRGBbyMask(obj)
            %resultMeanRGb ..
            %   ..
            % -------------------------------------------------------------
            FOREGROUND=1;
            automaticThreshold=graythresh(obj.ImageRGB);
            IMask=im2bw(obj.ImageRGB,automaticThreshold);
            figure; imshow(IMask);
            
            [rowSize, colSize, ~]=size(obj.ImageRGB);
            
            sumR=double(0.0);
            sumG=double(0.0);
            sumB=double(0.0);
            pixelCounter=double(0.0);
            
            varianceSumR=double(0.0);
            varianceSumG=double(0.0);
            varianceSumB=double(0.0);
            
            %run over a mask
            for f=1:1:rowSize
                for c=1:1:colSize
                    %read if pixel position is distinct to zero
                    pixelMask=IMask(f,c);
                    if pixelMask == FOREGROUND
                        sumR=double(obj.ImageRGB(f,c,1))+sumR;
                        sumG=double(obj.ImageRGB(f,c,2))+sumG;
                        sumB=double(obj.ImageRGB(f,c,3))+sumB;
                        pixelCounter=pixelCounter+1;
                    end %if
                end %end cols
            end %end rows
            
            % --------------------------------------
            %values by channels
            %---------------------------------------
            meanR=double(sumR/pixelCounter); %mean channel R
            meanG=double(sumG/pixelCounter); %mean channel G
            meanB=double(sumB/pixelCounter); %mean channel B
            %------------------------------------------------------------------------
            % sample variance
            %------------------------------------------------------------------------
            for f=1:1:rowSize
                for c=1:1:colSize
                    %read if pixel position is distinct to zero
                    pixelMask=IMask(f,c);
                    if pixelMask == FOREGROUND
                        varianceSumR=varianceSumR+(obj.ImageRGB(f,c,1)-meanR)^2;
                        varianceSumB=varianceSumB+(obj.ImageRGB(f,c,2)-meanG)^2;
                        varianceSumB=varianceSumB+(obj.ImageRGB(f,c,3)-meanB)^2;
                    end %if
                end %end col
            end %end row
            % -----------------------------------------------------------------------
            stdR=sqrt(double(varianceSumR/(pixelCounter)));
            stdG=sqrt(double(varianceSumB/(pixelCounter)));
            stdB=sqrt(double(varianceSumB/(pixelCounter)));
            %% final results            
            fprintf('%3f %3f %3f - std %3f %3f %3f \n', meanR, meanG, meanB, stdR, stdG, stdB);
            % -------------------------------------------------------------
            resultMeanRGB=0;
        end % end of function        
        
        function resultMeanRGB = getColorFeaturesRGB(obj)
            meanR=mean2(obj.ImageRGB(:,:,1));
            meanG=mean2(obj.ImageRGB(:,:,2));
            meanB=mean2(obj.ImageRGB(:,:,3));
            stdR=std2(obj.ImageRGB(:,:,1));
            stdG=std2(obj.ImageRGB(:,:,2));
            stdB=std2(obj.ImageRGB(:,:,3));
            fprintf('RGB %3f %3f %3f - std2 %3f %3f %3f \n', meanR, meanG, meanB, stdR, stdG, stdB);
            resultMeanRGB=0;
        end

        function [meanL, meanA, meanB, stdL, stdA, stdB] = getColorFeaturesLAB(obj)
            ILAB=rgb2lab(obj.ImageRGB);            
            meanL=mean2(ILAB(:,:,1));
            meanA=mean2(ILAB(:,:,2));
            meanB=mean2(ILAB(:,:,3));
            stdL=std2(ILAB(:,:,1));
            stdA=std2(ILAB(:,:,2));
            stdB=std2(ILAB(:,:,3));
            fprintf('LAB %3f %3f %3f - std2 %3f %3f %3f \n', meanL, meanA, meanB, stdL, stdA, stdB);
            %resultMeanLAB=[meanL, meanA, meanB, stdL, stdA, stdB];
        end        
        % TODO: load in a vector

        function resultMeanHSV = getColorFeaturesHSV(obj)
            IHSV=rgb2hsv(obj.ImageRGB);            
            meanH=mean2(IHSV(:,:,1));
            meanS=mean2(IHSV(:,:,2));
            meanV=mean2(IHSV(:,:,3));
            stdH=std2(IHSV(:,:,1));
            stdS=std2(IHSV(:,:,2));
            stdV=std2(IHSV(:,:,3));
            fprintf('HSV %3f %3f %3f - std2 %3f %3f %3f \n', meanH, meanS, meanV, stdH, stdS, stdV);
            resultMeanHSV=0;
        end
        
    end % end of methods
end % end of class

