classdef NIRFilterProcessor
    % NIRFilterProcessor Process images using NIR channels
    %
    % Author: https://github.com/juancarlosmiranda/
    % Date: January 2021
    %
    % USAGE
    % nirFilterProcessor=NIRFilterProcessor(IRGB, INIR);
    % nirFilterProcessor=nirFilterProcessor.segmentImage();
    % nirFilterProcessor.saveFilteredImages(OutputImagePath);
    %
    properties
        IRGBOrig
        INIROrig
        IRGBsegmented2
        INIRsegmented2
        formatImage; % by default jpg        
        OutputImageName
    end
    
    methods
        function obj = NIRFilterProcessor(IRGBOrig, INIROrig)
            %NIRFilterProcessor Construct an instance of this class
            %   Detailed explanation goes here
            % ------------------------------------
            obj.IRGBOrig=IRGBOrig;
            obj.INIROrig=INIROrig;
            obj.IRGBsegmented2=obj.IRGBOrig;
            obj.formatImage='jpg';
            % ------------------------------------
        end
        
        function obj = segmentImage(obj, t1, t2)
            %SEGMENTIMAGE Process images USING NIR data
            % -----------------------
            InirChannel1=obj.INIROrig(:,:,1);  % getn channel 1 from NIR
            %% configure thresholds and getting masks
            nirMask2=(InirChannel1(:,:,1) >= t1 ) & (InirChannel1(:,:,1) <= t2);
            notNIRMask2=~nirMask2; % negative matrix 
            obj.IRGBsegmented2=obj.IRGBOrig;
            %% segmentation with mask 2 appliying two thresholds at each end
            obj.IRGBsegmented2(:,:,1)=immultiply(obj.IRGBOrig(:,:,1),notNIRMask2);
            obj.IRGBsegmented2(:,:,2)=immultiply(obj.IRGBOrig(:,:,2),notNIRMask2);
            obj.IRGBsegmented2(:,:,3)=immultiply(obj.IRGBOrig(:,:,3),notNIRMask2);
            %% INIR
            obj.INIRsegmented2(:,:,1)=immultiply(obj.INIROrig(:,:,1),notNIRMask2); % channel 1 segmented mask2
            % ------------------------------------
            %fo_1=figure('Name','Original RGB Image', 'Position', get(0, 'Screensize')); figure(fo_1); imshow(obj.IRGBOrig); title(['Original RGB Image']);
            %%fo_2=figure('Name','Original NIR channel 1', 'Position', get(0, 'Screensize')); figure(fo_2); heatmapHandle_o_1 = heatmap(obj.INIROrig(:,:,1), 'ColorMap', jet(100)); title(['Original NIR Channel 1']);
            
            %f1_2=figure('Name','RGB Image with two threshold NIR'); figure(f1_2); imshow(obj.IRGBsegmented2); title(['RGB Image with two threshold NIR']);
            %f2_2=figure('Name','NIR channel 1 with two threshold', 'Position', get(0, 'Screensize')); figure(f2_2); heatmapHandle2_2 = heatmap(obj.INIRsegmented2(:,:,1), 'ColorMap', jet(100)); title(['INIR double threshold t1=',num2str(t1), ' t2=',num2str(t2)]); F=getframe(f2_2);
            % ------------------------------------
        end
        
        function obj = saveClustersImages(obj,OutputImageName)
            %SAVECLUSTERSIMAGES Given a path save images into files if it
            % is necessary
            % ----------------------
            %% Store segmented image
            extension=strcat('C','.', obj.formatImage);
            ClusterImageName=strcat(OutputImageName,extension);
            imwrite(obj.IRGBsegmented2, ClusterImageName, obj.formatImage);
            % -----------------------
        end
        
        function IRGBsegmented2 = getSegmentedNIRObjects(obj)
            % GETSEGMENTEDNIROBJECTS Returns a segmented image
            % ...
            IRGBsegmented2 = obj.IRGBsegmented2;
        end        
    end
end

