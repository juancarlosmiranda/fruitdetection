classdef FruitDetectorMain
    % FRUITDETECTORMAIN
    % Author: https://github.com/juancarlosmiranda/
    % 
    % 
    %
    % USAGE:
    % Run it with ->
    % FruitDetectorMain.Main()

    
    properties

    end    
    % ----------------------
    methods(Static)               
        function Main()
            clc, clear all, close all;
            fprintf('\n -------------------------------- \n');
            fprintf('MAIN METHOD - Fruit detector');
            fprintf('\n -------------------------------- \n');
            fprintf('\n loading flower net, transfer learning \n');
            % -------------------------
            c=ConfigDataFruitDetector;
            APathRGBImage=fullfile(c.pathRGBImages, 'BD12_sup_201711_165_09_RGBhr.jpg');
            APathDEPTHImage=fullfile(c.pathDEPTHImages, 'BD12_sup_201711_165_09_DS.mat');
            % -------------------------
            % read images
            I=imread(APathRGBImage); % load RGB data pre-processed
            load(APathDEPTHImage); % load Depth data from Kinect
            %DEPTHI=NIR_DEPTH_res_crop;
            % -------------------------
            fruitDetector=FruitDetectorClass(I,NIR_DEPTH_res_crop)            
            fruitDetector.runDetection();
            %fruitDetector.showImageRGB()
            %imageResult=fruitDetector.getRGBResult();
            %imshow(imageResult)
            % -------------------------            
        end        
    end
end

    
