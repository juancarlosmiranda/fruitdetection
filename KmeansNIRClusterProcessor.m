classdef KmeansNIRClusterProcessor
    % KMEANSCLUSTERPROCESSOR Kmeans clustering, returns and array of images
    %
    % Author: https://github.com/juancarlosmiranda/
    % Date: December 2020
    %
    % 
    % Adapted to manage Near infrarred data in two channels
    %
    % USAGE
    % clusterProcessor=KmeansNIRClusterProcessor(clustersQuantity, clusteringRepetition, INIR);
    % clusterProcessor=clusterProcessor.segmentImage();
    % clusterProcessor.saveClustersImages(OutputImageNameLAB);
    %
    
    properties
        clustersQuantity=3
        clusteringRepetition=3
        maxChannels=2
        INIROrig
        segmented_images
        pixel_label
        rgb_label
        OutputImageName
    end
    
    methods
        function obj = KmeansNIRClusterProcessor(clustersQuantityPar, clusteringRepetitionPar, INIROrig)
            %KMEANSCLUSTERPROCESSOR Construct an instance of this class
            %   Detailed explanation goes here
            % ------------------------------------
            obj.clustersQuantity=clustersQuantityPar;
            obj.clusteringRepetition=clusteringRepetitionPar;
            obj.maxChannels=size(INIROrig,3); % get total channels automatically
            obj.INIROrig=INIROrig;
            obj.segmented_images = cell(1,clustersQuantityPar);
            obj.pixel_label=[];
            obj.rgb_label=[];
            % ------------------------------------
        end
        
        function obj = segmentImage(obj)
            %SEGMENTIMAGE Process images into clusters
            % Segment images into clusters
            
            % ---------------------------------------------
            %% K-means segmentation
            % --------------------------
            
            pixelsList = double(obj.INIROrig(:,:,1:obj.maxChannels)); % extract values from a*b* axes
            nRows = size(pixelsList,1);
            nCols = size(pixelsList,2);
            pixelsList = reshape(pixelsList,nRows*nCols,obj.maxChannels); %cambia la figura
                        
            % to repite clustering 3 times to avoid local minimal
            [cluster_idx cluster_center] = kmeans(pixelsList,obj.clustersQuantity,'distance','sqEuclidean', 'Replicates',obj.clusteringRepetition);
            obj.pixel_label = reshape(cluster_idx,nRows,nCols);
            % ---------------------------------------------
            %% Create images
            obj.segmented_images = cell(1,obj.clustersQuantity);
            obj.rgb_label = repmat(obj.pixel_label,[1 1 obj.maxChannels]);
                        
            %% Create clusters images and save it in files
            for k = 1:obj.clustersQuantity
                color = obj.INIROrig;
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
                %extension=strcat('C',strcat(int2str(k),'.jpg'));
                %ClusterImageName=strcat(OutputImageName,extension);                
                %fprintf('Cluster images-> %s \n',ClusterImageName);
                %imwrite(obj.segmented_images{k},ClusterImageName,'jpg');
                figure; heatmap(obj.segmented_images{k})
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

