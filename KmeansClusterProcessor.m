classdef KmeansClusterProcessor
    % KMEANSCLUSTERPROCESSOR Kmeans clustering, returns and array of images
    %
    % Author: https://github.com/juancarlosmiranda/
    % Date: December 2020
    %
    % USAGE
    % clusterProcessor=KmeansClusterProcessor(clustersQuantity, clusteringRepetition, IRGB);
    % clusterProcessor=clusterProcessor.segmentImage();
    % clusterProcessor.saveClustersImages(OutputImageNameLAB);
    %
    
    properties
        clustersQuantity=3
        clusteringRepetition=3
        IRGBOrig
        segmented_images = cell(1,3)
        pixel_label
        rgb_label
        h = fspecial('average', [5 5]); %TODO: it will be improved to be a parameter
        ISh  % image filtered
        OutputImageName
    end
    
    methods
        function obj = KmeansClusterProcessor(clustersQuantityPar, clusteringRepetitionPar, IRGBOrig)
            %KMEANSCLUSTERPROCESSOR Construct an instance of this class
            %   Detailed explanation goes here
            % ------------------------------------
            obj.clustersQuantity=clustersQuantityPar;
            obj.clusteringRepetition=clusteringRepetitionPar;
            obj.IRGBOrig=IRGBOrig;
            obj.segmented_images = cell(1,3);
            obj.pixel_label=[];
            obj.rgb_label=[];
            obj.h = fspecial('average', [5 5]);
            obj.ISh = IRGBOrig; %imfilter(obj.IRGBOrig, obj.h);  % image filtered
            % ------------------------------------
        end
        
        function obj = segmentImage(obj)
            %SEGMENTIMAGE Process images into clusters
            % Segment images into clusters
            
            % ---------------------------------------------
            %% K-means segmentation
            % --------------------------
            % apply mean filter
            obj.ISh = obj.IRGBOrig %imfilter(obj.IRGBOrig, obj.h);
            % --------------------------
            
            % transform from RGB to L*a*b
            cform = makecform('srgb2lab');
            lab_ISh = applycform(obj.ISh,cform); % apply color conversion independent to device
            
            pixelsList = double(lab_ISh(:,:,2:3)); % extract values from a*b* axes
            nRows = size(pixelsList,1);
            nCols = size(pixelsList,2);
            pixelsList = reshape(pixelsList,nRows*nCols,2); %cambia la figura
            
            % to repite clustering 3 times to avoid local minimal
            [cluster_idx cluster_center] = kmeans(pixelsList,obj.clustersQuantity,'distance','sqEuclidean', 'Replicates',obj.clusteringRepetition);
            obj.pixel_label = reshape(cluster_idx,nRows,nCols);
            % ---------------------------------------------
            %% Create images
            obj.segmented_images = cell(1,3);
            obj.rgb_label = repmat(obj.pixel_label,[1 1 3]);
            
            %% Create clusters images and save it in files
            for k = 1:obj.clustersQuantity
                color = obj.ISh;
                color(obj.rgb_label ~= k) = 0;
                obj.segmented_images{k} = color;
            end
            % -----------------------
        end
        
        function obj = saveClustersImages(obj,OutputImageName)
            %SAVECLUSTERSIMAGES Given a path save images into files if it
            % is necessary
            % ----------------------
            %% Iterate into cluster
            for k = 1:obj.clustersQuantity
                %% Store clusters in files and create extension
                extension=strcat('C',strcat(int2str(k),'.jpg'));
                ClusterImageName=strcat(OutputImageName,extension);
                fprintf('Cluster images-> %s \n',ClusterImageName);
                imwrite(obj.segmented_images{k},ClusterImageName,'jpg');
            end
            % -----------------------
        end
        
        function segmented_images = getClusters(obj)
            %GETCLUSTERS
            %   Returns an array of images
            segmented_images = obj.segmented_images;
        end                
    end
end

