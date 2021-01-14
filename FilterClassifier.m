classdef FilterClassifier
    %FILTERCLASSIFIER .
    %   ...
    
    properties
        labelToFilter
    end
    
    methods
        function obj = FilterClassifier(labelToFilter)
            %FilterClassifier
            %   ..
            fprintf('\n -------------------------------- \n');
            fprintf('\n FilterClassifier() \n');
            fprintf('\n -------------------------------- \n');
            obj.labelToFilter=labelToFilter;
            
        end
        
        function imageFiltered = runFilterClassifier(obj,clusterImagesArray)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            
            % read all clusters
            % cut images
            % feature extraction
            % classify
            % if label = filterLabel, put this into a final image
            %
            % ensemble the final image
            imageFiltered=clusterImagesArray{1};
            imageFiltered(:,:)=0;
            
            %% Read clusters images and save it in files
            for k = 1:size(clusterImagesArray,2)
                fprintf('clusterImagesArray %i \n', k);
                % --------------------------------
                currentImage=clusterImagesArray{k};
                figure;imshow(currentImage);
                % --------------------------------
                % get from current image every blob
                % --------------------------------
                automaticThreshold=graythresh(currentImage);
                IBinaryMask=im2bw(currentImage,automaticThreshold);
                [objectList, Ne]=bwlabel(IBinaryMask);
                %% get objects properties in binary image
                objectPropertiesList= regionprops(objectList);
                %% selection by pixel areas
                pixelArea=100;
                objectsSelected=find([objectPropertiesList.Area]>pixelArea);
                %% obtenr coordenadas de areas
                itemsFoundCounter=0; % items found in binary image
                % --------------------------------
                if (size(objectsSelected,2)==0)
                    %si no existen objetos coloca en cero todos los valores de
                    %caracteristicas.
                    fprintf('cantidad de objetos %i \n', itemsFoundCounter);
                else
                    for n=1:size(objectsSelected,2)
                        itemsFoundCounter=itemsFoundCounter+1;
                        coordinates=round(objectPropertiesList(objectsSelected(n)).BoundingBox); %coordenadas de pintado
                        %% recorta las imagenes
                        %ISiluetaROI = imcrop(IFRB1,coordenadasAPintar);
                        %ISelected = imcrop(currentImage,coordinates);

                        
                        %[width, height]=size(ISelected)
                        x1=coordinates(1);
                        y1=coordinates(2);
                        x2=coordinates(3)+x1;                                                                        
                        y2=coordinates(4)+y1;
                        
                        ISelected = currentImage(x1:y1,x2:y2);
                        %figure; imshow(ISelected);
                        
                        imageFiltered(x1:y1,x2:y2,1)=ISelected(:,:,1);
                        %imageFiltered(x1:y1,x2:y2,2)=0;
                        %imageFiltered(x1:y1,x2:y2,3)=0; 

                        %figure; imshow(imageFiltered);
                        %break;
                        % ----------------------------------------
                    end
                end
                %break;
                % --------------------------------
            end
            
            %imageFiltered = 0;
        end
    end
end

