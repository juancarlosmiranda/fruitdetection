% DATAFEATUREPROCESSOR
%
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
%
% Contains methods to extract data from images and NIR data
% With a list of marked objects, cut small rgions to get features
% Contains helper functions
%
% USAGE:
% IRGB= is and image open with imread
% INIR= is a .mat file open with load()
% currentFileName= is a string with file name
% dataFeatureProcessor=DataFeatureProcessor(IRGB, INIR, currentFileName);


%
classdef DataFeatureProcessor
    % DataFeatureProcessor This class contains methods related to features
    % extraction
    % Get as input an RGB image, and NIR data and returns tables
    
    properties
        ARGBImage; % RGB image
        ANIRImage; % NIR matrix with 2 channels
        formatImage; % by default jpg
        formatNIR; % by default .mat
        formatFile; % by default .csv
        imageName;
    end
    
    methods
        function obj = DataFeatureProcessor(ARGBImage, ANIRImage, imageName)
            % DataFeatureProcessor Contructor
            %   ...
            fprintf('DataFeatureProcessor(ARGBImage, ANIRImage, imageName) \n');
            obj.ARGBImage=ARGBImage;
            obj.ANIRImage=ANIRImage;
            obj.formatImage='jpg';
            obj.formatNIR='mat';
            obj.formatFile='csv';
            obj.imageName=imageName;
        end
        
        function drawHeatmap(obj,pathOutputResultsHeatmap)
            % drawHeatmap Given a path, creates a heatmap for NIR data
            % ...
            % to plot data NIR
            % TODO: this is a helper dependent from NIR matrix
            InirChannel1=obj.ANIRImage(:,:,1);  % getn channel 1 from NIR
            t1=70; t2=190;
            nirMask2=(InirChannel1(:,:,1) >= t1 ) & (InirChannel1(:,:,1) <= t2);
            % -----------------
            f1=figure; heatmapHandle1 = heatmap(InirChannel1, 'ColorMap', jet(100));
            maximumValue=max(InirChannel1(:));
            caxis(heatmapHandle1,[0 maximumValue]);
            nameHeatMapPath=fullfile(pathOutputResultsHeatmap,obj.imageName);
            saveas(heatmapHandle1,nameHeatMapPath,'jpg');
            close(f1);
            % -----------------
        end
        
        function resultsFromImage = cutSquaresByLabelRGB(obj,humanLabeledList, humanLabels, labelToFilter, pathToSave)
            % cutSquaresByLabelRGB Given a list  with squares cut and
            % saves results in individual files in RGB format
            % ...
            % humanLabels, labelToFilter will be used to filter by labels
            % this is not implemented yet.
            %
            resultsFromImage=0; % error
            if (size(humanLabeledList,1)==0)
                %Here if objects does not exist
                fprintf('No Objects marked \n');
            else
                % ---------------------------------------
                for n=1:size(humanLabeledList,1)
                    % --------------------------------------------
                    vectorHumanDraw=humanLabeledList(n,:);
                    % -------------------------------------
                    % create a string with the name
                    imageOutput=strcat(obj.imageName,'_',num2str(n),'.', obj.formatImage);
                    pathFileCroppedPath=fullfile(pathToSave, imageOutput);
                    % pathToSave
                    IMcropped = imcrop(obj.ARGBImage,vectorHumanDraw);
                    imwrite( IMcropped, pathFileCroppedPath, obj.formatImage); %// save to file
                    % ------------------------------------
                    resultsFromImage=n;
                    % ------------------------------------
                end
            end
            % ----------------------------------------
        end
        
        function resultsFromImage = cutSquaresByLabelNIR(obj,humanLabeledList, humanLabels, labelToFilter, pathToSave)
            % cutSquaresByLabelNIR Given a list  with squares cut and
            % saves results in individual files in NIR format
            %
            % ...
            % humanLabels, labelToFilter will be used to filter by labels
            % this is not implemented yet.
            %
            resultsFromImage=0; % error
            if (size(humanLabeledList,1)==0)
                %Here if objects does not exist
                fprintf('No Objects marked \n');
            else
                % ---------------------------------------
                for n=1:size(humanLabeledList,1)
                    % -------------------------------------
                    x1=humanLabeledList(n,1);
                    y1=humanLabeledList(n,2);
                    x2=humanLabeledList(n,3)+x1;
                    y2=humanLabeledList(n,4)+y1;
                    % -------------------------------------
                    % copy all NIR channels
                    INIRObject=obj.ANIRImage(y1:y2, x1:x2); % reset variable
                    INIRObject(:,:,1)=0;
                    INIRObject(:,:,2)=0;
                    INIRObject(:,:,1)=obj.ANIRImage(y1:y2, x1:x2, 1);
                    INIRObject(:,:,2)=obj.ANIRImage(y1:y2, x1:x2, 2);
                    % -------------------------------------
                    imagenSalida=strcat(obj.imageName,'_DS','_',num2str(n),'.', obj.formatNIR);
                    pathFileCroppedPath=fullfile(pathToSave, imagenSalida);
                    % pathToSave
                    % -------------------------------------
                    save(pathFileCroppedPath,'INIRObject'); %// save to .mat file
                    % ------------------------------------
                    resultsFromImage=n;  % register objects processed
                    % ------------------------------------
                end
            end
            % ----------------------------------------
        end
        
        
        % --------------------------------------------------
        function resultsFromImage = cutSquaresByLabelNIRUnified(obj,humanLabeledList, humanLabels, labelToFilter, pathToSave)
            % CUTSQUARESBYLABEL Given a LIST WITH SQUARES CUT IMAGES
            % ...
            INIRSelected=obj.ANIRImage;
            INIRSelected(:,:,1)=0;
            INIRSelected(:,:,2)=0;
            % -------------------------------------
            imagenSalidaRGB=strcat(obj.imageName,'_','b_DS', '.', obj.formatNIR);
            pathFileCroppedPath=fullfile(pathToSave, imagenSalidaRGB);
            % -------------------------------------
            
            if (size(humanLabeledList,1)==0)
                %Here if objects does not exist
                fprintf('No Objects marked \n');
            else
                % ---------------------------------------
                for n=1:size(humanLabeledList,1)
                    % pathToSave
                    % -------------------------------------
                    x1=humanLabeledList(n,1);
                    y1=humanLabeledList(n,2);
                    x2=humanLabeledList(n,3)+x1;
                    y2=humanLabeledList(n,4)+y1;
                    % -------------------------------
                    % copy all NIR channels
                    INIRSelected(y1:y2, x1:x2,1) = obj.ANIRImage(y1:y2, x1:x2,1);
                    INIRSelected(y1:y2, x1:x2,2) = obj.ANIRImage(y1:y2, x1:x2,2);
                    % -------------------------------
                    %break
                end
                % -------------------------------------
                save(pathFileCroppedPath,'INIRSelected'); %// save to .mat file
                % ------------------------------------
            end
            resultsFromImage=1;
            % ----------------------------------------
        end
        % --------------------------------------------------
        % --------------------------------------------------
        function resultsFromImage = cutSquaresByLabelRGBUnified(obj,humanLabeledList, humanLabels, labelToFilter, pathToSave)
            % CUTSQUARESBYLABEL Given a LIST WITH SQUARES CUT IMAGES
            % ...
            IRGBBlack=obj.ARGBImage;
            IRGBBlack(:,:,1)=0;
            IRGBBlack(:,:,2)=0;
            IRGBBlack(:,:,3)=0;
            % -------------------------------------
            imagenSalidaNIR=strcat(obj.imageName,'_','b', '.', obj.formatImage);
            pathFileCroppedPath=fullfile(pathToSave, imagenSalidaNIR);
            % -------------------------------------
            resultsFromImage=0;
            
            if (size(humanLabeledList,1)==0)
                %Here if objects does not exist
                fprintf('No Objects marked \n');
            else
                % ---------------------------------------
                for n=1:size(humanLabeledList,1)
                    % pathToSave
                    % -------------------------------------
                    x1=humanLabeledList(n,1);
                    y1=humanLabeledList(n,2);
                    x2=humanLabeledList(n,3)+x1;
                    y2=humanLabeledList(n,4)+y1;
                    % -------------------------------
                    % copy all NIR channels
                    IRGBBlack(y1:y2, x1:x2,1) = obj.ARGBImage(y1:y2, x1:x2,1);
                    IRGBBlack(y1:y2, x1:x2,2) = obj.ARGBImage(y1:y2, x1:x2,2);
                    IRGBBlack(y1:y2, x1:x2,3) = obj.ARGBImage(y1:y2, x1:x2,3);
                    % -------------------------------
                    %break
                    resultsFromImage=n;
                end
                % -------------------------------------
                %save(pathFileCroppedPath,'INIRSelected'); %// save to .mat file
                imwrite(IRGBBlack, pathFileCroppedPath, obj.formatImage); %// save to file
                % ------------------------------------
            end
            % ----------------------------------------
            % ----------------------------------------
        end
        % --------------------------------------------------
        function tablaDSTraining = getFeaturesByLabelRGB(obj,humanLabeledList, humanLabels, labelToFilter, pathFileToSave)
            % getFeaturesByLabelRGB Given a list  with squares get
            % features RGB and save it in a file
            % ...
            % humanLabels, labelToFilter will be used to filter by labels
            % this is not implemented yet.
            %
            currentLabel='NONE';
            fileName=strcat(obj.imageName,'_','.', obj.formatFile); % to tget current box
            pathFileCroppedSave=fullfile(pathFileToSave, fileName);
            
            % ------------------------------
            % initializing tables
            headers_t={'image_name', 'meanLABL', 'meanLABa', 'meanLABb', 'stdLABL', 'stdLABa', 'stdLABb', 'meanNIR1', 'stdNIR1', 'label_class'};
            cellRecord = {'',0,0,0,0,0,0,0,0,''};
            tablaDSTraining = cell2table(cellRecord(1:end,:),'VariableNames',headers_t)
            % ------------------------------
            if (size(humanLabeledList,1)==0)
                %Here if objects does not exist
                fprintf('No Objects marked \n');
            else
                % ---------------------------------------
                for n=1:size(humanLabeledList,1)
                    % --------------------------------------------
                    vectorHumanDraw=humanLabeledList(n,:);
                    currentLabel=humanLabels{n} %'current_label';
                    % -------------------------------------
                    % create a string with the name
                    imageNamedF=strcat(obj.imageName,'_',num2str(n),'.', obj.formatImage); % to tget current box
                    fprintf('imageNamedF=%s \n', imageNamedF);
                    fprintf('currentLabel=%s \n', currentLabel);
                    % pathToSave
                    IMcropped = imcrop(obj.ARGBImage,vectorHumanDraw); % sub image
                    featureExtractor=FeaturesExtractionIM(IMcropped);
                    [meanLABL, meanLABa, meanLABb, stdLABL, stdLABa, stdLABb] = featureExtractor.getColorFeaturesLAB();
                    % ------------------------------------
                    image_name={imageNamedF};
                    meanNIR1=[0.0];
                    stdNIR1=[0.0];
                    label_class={currentLabel};
                    cellRecord = {image_name,meanLABL,meanLABa,meanLABb,stdLABL,stdLABa,stdLABb,meanNIR1,stdNIR1,label_class};
                    tablaDSTraining=[tablaDSTraining;cellRecord];
                    % ------------------------------------
                end
                % ------------------------------------
                % write in file
                % here writes in output file
                % ------------------------------------
                writetable(tablaDSTraining,pathFileCroppedSave,'Delimiter',';')
            end
        end
        % ----------------------------------------------
        function tablaDSTraining = getFeaturesByLabelRGBNIR(obj,humanLabeledList, humanLabels, labelToFilter, pathFileToSave)
            % getFeaturesByLabelRGB Given a list  with squares get
            % features RGB and save it in a file
            % ...
            % humanLabels, labelToFilter will be used to filter by labels
            % this is not implemented yet.
            %
            currentLabel='NONE';
            fileName=strcat(obj.imageName,'_','.', obj.formatFile); % to tget current box
            pathFileCroppedSave=fullfile(pathFileToSave, fileName);
            
            % ------------------------------
            % initializing tables
            headers_t={'image_name', 'meanLABL', 'meanLABa', 'meanLABb', 'stdLABL', 'stdLABa', 'stdLABb', 'meanNIR1', 'stdNIR1', 'label_class'};
            cellRecord = {'',0,0,0,0,0,0,0,0,''};
            tablaDSTraining = cell2table(cellRecord(1:end,:),'VariableNames',headers_t)
            % ------------------------------
            if (size(humanLabeledList,1)==0)
                %Here if objects does not exist
                fprintf('No Objects marked \n');
            else
                % ---------------------------------------
                for n=1:size(humanLabeledList,1)
                    % --------------------------------------------
                    vectorHumanDraw=humanLabeledList(n,:);
                    currentLabel=humanLabels{n} %'current_label';
                    % -------------------------------------
                    % create a string with the name
                    imageNamedF=strcat(obj.imageName,'_',num2str(n),'.', obj.formatImage); % to tget current box
                    fprintf('imageNamedF=%s \n', imageNamedF);
                    fprintf('currentLabel=%s \n', currentLabel);
                    % -------------------------------------
                    % Image features
                    IMcropped = imcrop(obj.ARGBImage,vectorHumanDraw); % sub image
                    featureExtractorRGB=FeaturesExtractionIM(IMcropped);
                    [meanLABL, meanLABa, meanLABb, stdLABL, stdLABa, stdLABb] = featureExtractorRGB.getColorFeaturesLAB();
                    % ------------------------------------
                    % -------------------------------------
                    % NIR features
                    %meanNIR1=[0.0];
                    %stdNIR1=[0.0];
                    %[meanNIR1, stdNIR1]=;
                    % -------------------------------------
                    x1=humanLabeledList(n,1);
                    y1=humanLabeledList(n,2);
                    x2=humanLabeledList(n,3)+x1;
                    y2=humanLabeledList(n,4)+y1;
                    % -------------------------------
                    % copy all NIR channels
                    % -------------------------------------
                    fprintf('y1=%d y2=%d, x1=%d x2=%d', y1,y2, x1,x2)
                    if (y1==0)
                        y1=1;
                    end
                    if (x1==0)
                        x1=1;
                    end                    
                    INIRObject=obj.ANIRImage(y1:y2, x1:x2); % reset variable
                    INIRObject(:,:,1)=0;
                    INIRObject(:,:,2)=0;
                    INIRObject(:,:,1)=obj.ANIRImage(y1:y2, x1:x2, 1);
                    INIRObject(:,:,2)=obj.ANIRImage(y1:y2, x1:x2, 2);
                    % -------------------------------------
                    featureExtractorNIR=FeaturesExtractionNIR(INIRObject);
                    [meanNIR1, meanChannel2, stdNIR1, stdChannel2, minChannel1, maxChannel1] = featureExtractorNIR.getColorFeaturesNIR();
                    %meanNIR1=1.1;
                    %stdNIR1=1.1;
                    % ------------------------------------
                    image_name={imageNamedF};
                    label_class={currentLabel};
                    cellRecord = {image_name,meanLABL,meanLABa,meanLABb,stdLABL,stdLABa,stdLABb,meanNIR1,stdNIR1,label_class};
                    tablaDSTraining=[tablaDSTraining;cellRecord];
                    
                    %break
                    % ------------------------------------
                end
                % ------------------------------------
                % write in file
                % here writes in output file
                % ------------------------------------
                writetable(tablaDSTraining,pathFileCroppedSave,'Delimiter',';')
            end
        end
        % ----------------------------------------------
    end
end

