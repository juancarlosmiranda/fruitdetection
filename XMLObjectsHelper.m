classdef XMLObjectsHelper
    %XMLHelper Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1=1;
    end
    
    methods(Static)
        function outputRecord = parseXMLRecord(obj,currentItem)
            %parseXMLRecord Takes data from XML struct
            %   Return an object with data loaded from XML file
            % ----------------------------
            xMinValue=''; yMinValue=''; xMaxValue=''; yMaxValue='';            
            % ------ field name ------------
            nameTag = currentItem.getElementsByTagName('name');
            nameSelected=nameTag.item(0);
            nameValue = char(nameSelected.getFirstChild.getData);
            
            % ------ field bbox ------------
            bboxTag = currentItem.getElementsByTagName('bbox');
            bboxSelected=bboxTag.item(0);
            % ------ field xmin ------------
            xMinTag=bboxSelected.getElementsByTagName('xmin');
            xMinSelected=xMinTag.item(0);
            xMinValue=str2num(xMinSelected.getFirstChild.getData);
            % ------ field ymin ------------
            yMinTag=bboxSelected.getElementsByTagName('ymin');
            yMinSelected=yMinTag.item(0);
            yMinValue=str2num(yMinSelected.getFirstChild.getData);
            % ------ field xmax ------------
            xMaxTag=bboxSelected.getElementsByTagName('xmax');
            xMaxSelected=xMaxTag.item(0);
            xMaxValue=str2num(xMaxSelected.getFirstChild.getData);
            % ------ field ymax ------------
            yMaxTag=bboxSelected.getElementsByTagName('ymax');
            yMaxSelected=yMaxTag.item(0);
            yMaxValue=str2num(yMaxSelected.getFirstChild.getData);
            % ------------------------------
            %fprintf('%s %s %s %s %s \n', nameValue, xMinValue, yMinValue, xMaxValue, yMaxValue);
            % ------------------------------
            
            % ----------------------------
            modifiedRecord=XMLItemRecord();
            modifiedRecord.name=nameValue;
            modifiedRecord.xmin=xMinValue;
            modifiedRecord.ymin=yMinValue;
            modifiedRecord.xmax=xMaxValue;            
            modifiedRecord.ymax=yMaxValue;
            % ----------------------------
            %modifiedRecord.getBoundingBox();
            outputRecord = modifiedRecord;
        end
        
        function [rectangleVector, labelCell]=readXMLFromFIle(inputPathFileXML)
            %readXMLFromFIle Read from files with bounding boxes
            %   ...
            % -----------------------------------------------------------
            %% Lectura de XML
            %Valores a buscar en el XML
            fprintf('\n -------------------------------- \n');
            fprintf('readXMLFromFIle(inputPathFileXML)');
            fprintf('\n -------------------------------- \n');
            
            xDoc = xmlread(fullfile(inputPathFileXML)); %Lectura del archivo
            
            
            % get all item list|
            ItemList = xDoc.getElementsByTagName('object');
            % -------------------
            labelCell=cell('');
            rectangleVector=[];
            
            %Go through the elements
            for k = 0:ItemList.getLength-1
                currentItem = ItemList.item(k);
                % Get the label element. In this file, each
                aRecord=XMLObjectsHelper.parseXMLRecord(XMLObjectsHelper,currentItem);
                %aRecord.getBoundingBox()

                %aRecord.name
                % prepare data
                % ----------------------------
                rectangleVector(k+1,:)= aRecord.getBoundingBox()
                labelCell{k+1,1}= aRecord.name
                % ----------------------------
                %break
            end %end of for
            % ------------------------------------------------------------
            
            %TODO: create a method to save in files
            % --------------------------------------
        end
        

    end
end


%nodeItemStruct = struct('name', 'Poma', 'difficult', '0', 'bbox', '');
%nodeBboxStruct = struct('xmin', 0, 'ymin', 0, 'xmax', 0, 'ymax', 0);


%nodeBboxStruct = struct('xmin', 0, 'ymin', 0, 'xmax', 0, 'ymax', 0);
%nodeItemStruct = struct('name', '', 'difficult', '0', 'bbox', nodeBboxStruct);