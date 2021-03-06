% COUNTINGFRUITSPROCESSOR
%
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
%
classdef CountingFruitsProcessor
    % CountingFruitsProcessor This class contains methods related to fruit
    %counting.
    % Get as input an RGB image and returns operations
    
    properties
        ARGBImage; % RGB image
        IBinarized; % Binarized mask
        objectCounter;
        rectangleVector;
    end
    
    methods
        function obj = CountingFruitsProcessor(ARGBImage)
            % COUNTINGFRUITSPROCESOR Contructor
            %   ...
            fprintf('CountingFruitsProcessor \n');
            obj.ARGBImage=ARGBImage;
            obj.IBinarized=ARGBImage;
            obj.objectCounter=0;
        end
        
        function  obj = detectObjects(obj)
            % DETECTOOBJECTS 
            % From an color image, applies binarization and get a mask.
            % With the mask gets an object list
            % ...           
            
            %% Binarize silhouette with background removed
            threshold=graythresh(obj.ARGBImage);
            obj.IBinarized=im2bw(obj.ARGBImage,threshold);            
            % ------------------------------------                      
            %% Labeling connected elements            
            [ListOfObjects, ~]=bwlabel(obj.IBinarized);
            
            %% Get objects properties from image
            properties= regionprops(ListOfObjects);
            
            %% Search objects pixel areas
            selection=find([properties.Area]);           
            rectangleVector=zeros(size(selection,2),4); % allocate space
            
            %% get locations in image
            objectCounter=0; % objects found
            % If this image is empty or not
            if (size(selection,2)==0)
                %Here if objects does not exist
                fprintf('Total objects detected %i \n', obj.objectCounter);
            else
                %% ------------------------
                for n=1:size(selection,2)
                    objectCounter=objectCounter+1;
                    coordinatesToPaint=round(properties(selection(n)).BoundingBox); % coordinates to paint
                    rectangleVector(n,:)=coordinatesToPaint;                    
                end % end while                
                fprintf('Total objects detected %i \n', objectCounter);                
            end% fin if
            
            obj.objectCounter=objectCounter;
            obj.rectangleVector=rectangleVector;
            % ------------------------------------
        end
        
        function resultsFromImage = evaluateObjectsInImage(obj,humanLabeledList, humanLabels, overlapThreshold)
            % EVALUATEOBJECTS Given an image, mark and show marked.
            % ...
            TP=0;
            
            if (size(obj.rectangleVector,1)==0)
                %Here if objects does not exist
                fprintf('Objects detected in image %i \n', obj.objectCounter);
            else
                % ---------------------------------------
                FP=0;
                TP=0;
                FN=0;
                TN=0;
                % ---------------------------------------
                fh = figure;
                imshow(obj.ARGBImage, 'border', 'tight'); %//show your image
                hold on;
                % ---------------------------------------
                for n=1:size(humanLabeledList,1)                    
                    vectorHumanDraw=humanLabeledList(n,:);
                    rectangle('Position',vectorHumanDraw,'EdgeColor','R','LineWidth',2)
                    hold on
                end
                
                % ---------------------------------------
                for c=1:size(obj.rectangleVector,1)
                    overlapRatio=0;
                    detectedFlag=0;
                    % rectangleVector has the format structure of
                    % boundingboxes [xmin, ymin, with, height]
                    % This was saved from regionprops function                   
                    % to draw is the same
                    xminP=obj.rectangleVector(c,1);
                    yminP=obj.rectangleVector(c,2);                    
                    vectorPredictDraw=obj.rectangleVector(c,:);
                    % --------------------------------------------
                    for n=1:size(humanLabeledList,1)                       
                        xminH=humanLabeledList(n,1);
                        yminH=humanLabeledList(n,2);
                        widthH=humanLabeledList(n,3);
                        heigthH=humanLabeledList(n,4);
                        % -------------------------------------
                        vectorHumanDraw=humanLabeledList(n,:);
                        % -------------------------------------
                        overlapRatio = bboxOverlapRatio(vectorPredictDraw,vectorHumanDraw);
                        % -------------------------------------                        
                        if (overlapRatio >= overlapThreshold)
                            % TRUE POSITIVES human mark correct in green
                            detectedFlag=1;
                            TP=TP+1; % counting objects
                            fprintf('inner overlap=%d \n', overlapRatio);
                            % blue box when is a correct detection
                            rectangle('Position',vectorPredictDraw,'EdgeColor','b','LineWidth',2);
                            text(xminP, yminP,num2str(overlapRatio),'Color','r');
                            hold on                            
                            % ---------------------------------------------                            
                            rectangle('Position',vectorHumanDraw,'EdgeColor','g','LineWidth',2)
                            text(xminH+widthH, yminH+heigthH, humanLabels(n),'Color','r');
                            hold on
                            % ---------------------------------------------
                        end
                        % ------------------------------------                        
                    end
                    if (detectedFlag==0)
                        % --------------------------------------------
                        % detected by system but not detected by human is
                        % reach to end and has not any coincidence
                        % FALSE POSITIVE
                        FP=FP+1;
                        rectangle('Position',vectorPredictDraw,'EdgeColor','y','LineWidth',2);
                        text(xminP, yminP,num2str(overlapRatio),'Color','r');
                        hold on
                    end    
                end
                % ----------------------------------------
            end
            fprintf('Algorithm FP = %i \n', FP);
            fprintf('Algorithm TP = %i \n', TP);
            
            % all objects detected with the system
            allDetectedSize=size(obj.rectangleVector,1);
            % all objects marked by humans as groundtruth
            allGroundTruthsSize=size(humanLabeledList,1);
            resultsFromImage=MetricResultsItemRecord(allDetectedSize, allGroundTruthsSize, TP);
            
            
            %FP=allDetected-TP;
            %FN=allGroundTruths-TP;
            %% Explanation allDetected=(TP+FP) precision=TP/(TP+FP);
            %precision=TP/(TP+FP);
            %% Explanation allGroundTruths=(TP+FN) recall=TP/(TP+FN);
            %recall=TP/allGroundTruths;  
            %fprintf('allGroundTruths = %i \n', allGroundTruths);
            %fprintf('allDetected = %i \n', allDetected);            
            %fprintf('Detected TP = %i \n', TP);
            %fprintf('Detected by system only FP = %i \n', FP);
            %fprintf('Ground truth not detected FN = %i \n', FN);
            %fprintf('Precision = %3f \n', precision);
            %fprintf('Recall = %3f \n', recall);
            %outputArg=0;
        end
        
        function IBinarizedObjectsDetected = getBinarizedObjectsDetected(obj)
            % GETBINARIZAEDOBJECTSDETECTED Returns a binary mask from objects detected
            % ...
            IBinarizedObjectsDetected = obj.IBinarized;
        end

        function metricResults = getMetricResults(obj)
            % getMetricResults
            % ...
            IBinarizedObjectsDetected = obj.IBinarized;
        end        
        
    end
end

