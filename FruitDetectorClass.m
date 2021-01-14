classdef FruitDetectorClass
    %FRUITDETECTORCLASS a description of my class
    %
    % Author: https://github.com/juancarlosmiranda/
    % Date: December 2020
    %
    %
    % USAGE
    % Here how to get help for this class from command line
    % >> help GenericTemplateForClass
    %
    
    properties
        RGBImage;
        DepthImageMatrix;
        RGBImageFruitsDetected;%=imread('/home/usuario/development/fruitDetector/testingImages/BD04_inf_201724_004_RGB.jpg1C2.jpg');
        RGBBinaryMaskFruitsDetected;
        SquaresDetectedListResults;
    end
    
    methods
        function obj = FruitDetectorClass(RGBImageExternal, DepthMatrixExternal)
            fprintf('\n Constructor-> FruitDetectorClass');
            % initialize object properties
            obj.RGBImage=RGBImageExternal;
            obj.DepthImageMatrix=DepthMatrixExternal;
        end
        % -----------------------
        function outputResult = showImageRGB(obj)
            % METHOD_1
            % Here how to get help for this method, it is a template
            % from command line:
            % >> help GenericTemplateForClass
            fprintf('\n -------------------------------- \n');
            fprintf('\n showImageRGB() \n');
            fprintf('\n -------------------------------- \n');
            % -------------------------------------
            figure; imshow(obj.RGBImage)
            outputResult = 0;
        end
        % -----------------------
        function outputRGB = getRGBResult(obj)
            % GETRGBRESULT
            % Returns an image with fruits detected
            fprintf('\n -------------------------------- \n');
            fprintf('\n getRGBResult(obj) \n');
            fprintf('\n -------------------------------- \n');
            % -------------------------------------
            outputRGB = obj.RGBImageFruitsDetected;
        end
        function outputBinaryMask = getRGBBinaryMaskResult(obj)
            % getRGBBinaryMaskResult
            % Returns an image with fruits detected
            fprintf('\n -------------------------------- \n');
            fprintf('\n getRGBBinaryMaskResult(obj) \n');
            fprintf('\n -------------------------------- \n');
            % -------------------------------------
            outputBinaryMask = 0;
        end
        % -----------------------
        function outputResult = runDetection(obj)
            % runDetection
            % Returns an image with fruits detected
            fprintf('\n -------------------------------- \n');
            fprintf('\n runDetection(obj) \n');
            fprintf('\n -------------------------------- \n');
            % -------------------------------------
            % -------------------------------------
            % returns
            % number of detected fruits with bounding boxes
            % -------------------------------------
            outputResult = 0;
        end
        % -----------------------
    end
end
