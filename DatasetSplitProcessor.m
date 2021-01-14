% ------------------------------------------------------------------------
% Fruit Detection Project
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
% ------------------------------------------------------------------------
classdef DatasetSplitProcessor
    % DatasetSplitProcessor
    %
    %   From Fuji dataset creates folders with: images, NIR data and
    %   aples squares.
    %   This a intermediate step before training.
    %
    %   [1] Gené-Mola J, Vilaplana V, Rosell-Polo JR, Morros JR, Ruiz-Hidalgo J, Gregorio E. 2019. Multi-modal Deep Learning for Fruit Detection Using RGB-D Cameras and their Radiometric Capabilities. Computers and Electronics in Agriculture, 162, 689-698. DOI: 10.1016/j.compag.2019.05.016
    %   [2] Gené-Mola J, Vilaplana V, Rosell-Polo JR, Morros JR, Ruiz-Hidalgo J, Gregorio E. 2019. KFuji RGB-DS database: Fuji apple multi-modal images for fruit detection with color, depth and range-corrected IR data. Data in brief, 25 (2019), 104289. DOI: 10.1016/j.dib.2019.104289
    %
    %
    % INPUT: a path with Fuji dataset struc
    % with a list of images and images, NIR data preprocessd, square boxes, this
    % creates a folder with data to train
    %
    %
    % OUTPUT:
    % pre-procesed images cutted in a folder
    % a list of each image with features extracted by apple: color-based,
    % NIR statistic parameters. The apple image must correspond with image
    % cutted.
    
    % TODO: model class, after put the parameters in a config class.
    % 
    % Original folder hierarchy
    %
    % FujiDataset/
    %   |--images/
    %   |--square_annotations1/
    %
    %
    
    properties
        FolderImages='images',
        FolderSquareAnnotations='square_annotations1';
        ExtensionRGB='hr.jpg';
        ExtensionNIR='DS.mat';
        ExtensionSquare='.xml';
        pathDataset;
        pathDatasetImages;
        pathDatasetSquareAnnotations;
    end
    
    methods
        function obj = DatasetSplitProcessor(pathDataset)
            %DatasetSplitProcessor ..
            %   ..
            % -------------------------------------------------------------
            fprintf('\n -------------------------------- \n');
            fprintf('\n DatasetSplitProcessor(pathDataset) \n');
            fprintf('\n -------------------------------- \n');
            obj.pathDataset = pathDataset;
            obj.pathDatasetImages=fullfile(pathDataset,obj.FolderImages);
            obj.pathDatasetSquareAnnotations=fullfile(pathDataset,obj.pathDatasetSquareAnnotations);
            % -------------------------------------------------------------
        end
        
        function createFolderDatasetStructure(obj, outputPathFolder)
            % CREATEFOLDERDATASETSTRUCTURE
            % With a path creates a folder tree.
            fprintf('\n -------------------------------- \n');
            fprintf('\n createFolderDatasetStructure(outputPathFolder) \n');
            fprintf('\n -------------------------------- \n');
            % ------------------------------------------------
            mkdir(outputPathFolder);
            mkdir(outputPathFolder,obj.FolderImages);
            mkdir(outputPathFolder,obj.FolderSquareAnnotations);
            % ------------------------------------------------
        end
        
        
        function outputPathFolderCreated = createRepository(obj,aFileListPath, copySquaresFlag, outputPathFolder)
            % CREATEREPOSITORY ...
            %  With a images names list, this create a folder following
            %  a standard hierarchy.
            fprintf('\n aFileListPath=%s \n', aFileListPath);
            % -------------------------------------------------------------
            % must exists file set
            % if ouput folder does not exist, create it and proceed
            if isfile(aFileListPath)
                fprintf('\n aFileListPath=%s \n', aFileListPath);
                fprintf('\n outputPathFolder=%s \n', outputPathFolder);
                % ---------------------------------------------------------
                if ~isfolder(outputPathFolder)
                    % creates folder with special folder inner
                    obj.createFolderDatasetStructure(outputPathFolder)
                end
                % ---------------------------------------------------------
                aFileId = fopen(aFileListPath);
                while ~feof(aFileId)
                    %disp(aFileline)
                    aFileline = fgetl(aFileId);
                    % ---------------------------
                    % read file name
                    % copy image to folder
                    % copy NIR to folder
                    % copy square
                    % if training flag copy square annotations
                    % ---------------------------
                    % BD04_inf_201724_004_01_RGBhr.jpg
                    fileNameRGB=strcat(aFileline,obj.ExtensionRGB);
                    % ----------------------------------------
                    % BD04_inf_201724_004_01_DS.mat
                    subnameend=(size(aFileline,2)-3);
                    subname=aFileline(1:subnameend);
                    fileNameNIR=strcat(subname,obj.ExtensionNIR);
                    fileNameSquare=strcat(aFileline,obj.ExtensionSquare);
                    % ----------------------------------------
                    pathFileSourceCopyRGB=fullfile(obj.pathDatasetImages,fileNameRGB);
                    pathFileToCopyRGB=fullfile(outputPathFolder, obj.FolderImages,fileNameRGB);
                    % ----------------------------------------
                    pathFileSourceCopyNIR=fullfile(obj.pathDatasetImages,fileNameNIR);
                    pathFileToCopyNIR=fullfile(outputPathFolder, obj.FolderImages,fileNameNIR);
                    % ----------------------------------------
                    pathFileSourceCopySquare=fullfile(obj.pathDatasetSquareAnnotations, obj.FolderSquareAnnotations, fileNameSquare);
                    pathFileToCopySquare=fullfile(outputPathFolder, obj.FolderSquareAnnotations, fileNameSquare);
                    % ----------------------------------------
                    disp(aFileline)
                    %disp(pathFileSourceCopyNIR)
                    %disp(pathFileToCopyNIR)
                    %disp(pathFileToCopySquare)
                    % ----------------------------------------
                    % copiyng file from source to destination
                    copyfile(pathFileSourceCopyRGB, pathFileToCopyRGB);
                    copyfile(pathFileSourceCopyNIR, pathFileToCopyNIR);
                    if copySquaresFlag
                        copyfile(pathFileSourceCopySquare, pathFileToCopySquare);
                    end
                    % ---------------------------
                end
                fclose(aFileId);                
                % ---------------------------------------------------------
            else
                fprintf('\n aFileListPath=%s DOES NOT EXIST!\n', aFileListPath);
                ME = MException('DatasetSplitProcessor.createRepository:noSuchFile', 'File=%s DOES NOT EXIST!',aFileListPath);
                throw(ME)
            end            
            % -------------------------------------------------------------
            outputPathFolderCreated = outputPathFolder; % TODO:            
            % -------------------------------------------------------------
        end
        
        % TODO
        function [ splittedFile1 splittedFile2] = splitFiles(obj,aFileList, percentageToSplit)
            %csplitFiles ...
            %  With a images names list, this create a file with random
            %  contents            
            splittedFile1='';
            splittedFile2='';
        end        
    end
end

