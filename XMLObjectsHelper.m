% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
%
% Returns data from XML format used in 
% [2] Gené-Mola J, Vilaplana V, Rosell-Polo JR, Morros JR, Ruiz-Hidalgo J, Gregorio E. 2019. KFuji RGB-DS database: Fuji apple multi-modal images for fruit detection with color, depth and range-corrected IR data. Data in brief, 25 (2019), 104289. DOI: 10.1016/j.dib.2019.104289
%
% <annotations>
%   <filename>BD04_inf_201724_004_01_RGB.jpg</filename>
%   <size>
%     <width>548</width>
%     <height>373</height>
%     <depth>3</depth>
%   </size>
%   <object>
%     <name>Poma</name>
%     <difficult>0</difficult>
%     <bbox>
%       <xmin>72</xmin>
%       <ymin>10</ymin>
%       <xmax>119</xmax>
%       <ymax>57</ymax>
%     </bbox>
%   </object>
% </annotations>
%
% 
% USAGE
% [humanLabeledListBbox humanLabel]=XMLObjectsHelper.readXMLFromFIleBbox(inputPathFileXML);
% [humanLabeledList humanLabel]=XMLObjectsHelper.readXMLFromFIle(inputPathFileXML);
%
%

classdef XMLObjectsHelper
    %XMLHelper Summary of this class goes here
    %  ...
    
    methods(Static)
        function outputRecord = parseXMLRecord(obj, currentItem)
            %parseXMLRecord Takes data from XML struct
            %   Return an object with data loaded from XML file
            % ----------------------------
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
            xMinValue=str2double(xMinSelected.getFirstChild.getData);
            % ------ field ymin ------------
            yMinTag=bboxSelected.getElementsByTagName('ymin');
            yMinSelected=yMinTag.item(0);
            yMinValue=str2double(yMinSelected.getFirstChild.getData);
            % ------ field xmax ------------
            xMaxTag=bboxSelected.getElementsByTagName('xmax');
            xMaxSelected=xMaxTag.item(0);
            xMaxValue=str2double(xMaxSelected.getFirstChild.getData);
            % ------ field ymax ------------
            yMaxTag=bboxSelected.getElementsByTagName('ymax');
            yMaxSelected=yMaxTag.item(0);
            yMaxValue=str2double(yMaxSelected.getFirstChild.getData);
            % ------------------------------
            % ----------------------------
            modifiedRecord=XMLItemRecord();
            modifiedRecord.name=nameValue;
            modifiedRecord.xmin=xMinValue;
            modifiedRecord.ymin=yMinValue;
            modifiedRecord.xmax=xMaxValue;            
            modifiedRecord.ymax=yMaxValue;
            % ----------------------------
            outputRecord = modifiedRecord;
        end

        function outputRecordBbox = parseXMLRecordBbox(obj, currentItem)
            %PARSEXMLRECORDBBOX Takes data from XML struct
            % Return an object with data loaded from XML file
            % it returns data in MATLAB bounding box format
            % ----------------------------
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
            xMinValue=str2double(xMinSelected.getFirstChild.getData);
            % ------ field ymin ------------
            yMinTag=bboxSelected.getElementsByTagName('ymin');
            yMinSelected=yMinTag.item(0);
            yMinValue=str2double(yMinSelected.getFirstChild.getData);
            % ------ field xmax ------------
            xMaxTag=bboxSelected.getElementsByTagName('xmax');
            xMaxSelected=xMaxTag.item(0);
            width=str2double(xMaxSelected.getFirstChild.getData)-xMinValue;
            % ------ field ymax ------------
            yMaxTag=bboxSelected.getElementsByTagName('ymax');
            yMaxSelected=yMaxTag.item(0);
            height=str2double(yMaxSelected.getFirstChild.getData)-yMinValue;
            % ----------------------------
            modifiedRecordBbox=XMLItemRecordBbox();
            modifiedRecordBbox.name=nameValue;
            modifiedRecordBbox.xmin=xMinValue;
            modifiedRecordBbox.ymin=yMinValue;
            modifiedRecordBbox.width=width;            
            modifiedRecordBbox.height=height;
            % ----------------------------
            outputRecordBbox = modifiedRecordBbox;
        end        
        
        
        
        
        function [rectangleVector, labelCell]=readXMLFromFIle(inputPathFileXML)
            %READXMLFROMFILE Read from files with bounding boxes in format
            % [xmin, ymin, xmax, ymax]
            %   ...
            % -----------------------------------------------------------
            fprintf('\n -------------------------------- \n');
            fprintf('readXMLFromFIle(inputPathFileXML)');
            fprintf('\n -------------------------------- \n');            
            xDoc = xmlread(fullfile(inputPathFileXML));
            % get all item list|
            ItemList = xDoc.getElementsByTagName('object');
            % -------------------
            labelCell=cell('');
            rectangleVector=zeros((ItemList.getLength-1),4);
            % -------------------            
            %Go through the elements
            for k = 0:ItemList.getLength-1
                currentItem = ItemList.item(k);
                % Get the label element. In this file, each
                aRecord=XMLObjectsHelper.parseXMLRecord(XMLObjectsHelper,currentItem);
                % prepare data
                % ----------------------------
                rectangleVector(k+1,:)= aRecord.getBoundingBox();
                labelCell{k+1,1}= aRecord.name;
                % ----------------------------
            end %end of for
            % ------------------------------------------------------------            
            %TODO: create a method to save in files
            % --------------------------------------
        end

        function [rectangleVectorBbox, labelCell]=readXMLFromFIleBbox(inputPathFileXML)
            %readXMLFromFIle Read from files with bounding boxes in format
            %  [xmin, ymin, width, height]
            % -----------------------------------------------------------
            fprintf('\n -------------------------------- \n');
            fprintf('readXMLFromFIleBbox(inputPathFileXML)');
            fprintf('\n -------------------------------- \n');            
            xDoc = xmlread(fullfile(inputPathFileXML));
            % get all item list
            ItemListBbox = xDoc.getElementsByTagName('object');
            % -------------------
            labelCell=cell('');
            rectangleVectorBbox=zeros((ItemListBbox.getLength-1),4);
            % -------------------            
            %Go through the elements
            for k = 0:ItemListBbox.getLength-1
                currentItem = ItemListBbox.item(k);
                % Get the label element. In this file, each
                aRecord=XMLObjectsHelper.parseXMLRecordBbox(XMLObjectsHelper,currentItem);
                % prepare data
                % ----------------------------
                rectangleVectorBbox(k+1,:)= aRecord.getBoundingBox();
                labelCell{k+1,1}= aRecord.name;
                % ----------------------------
            end %end of for
            % ------------------------------------------------------------            
            %TODO: create a method to save in files
            % --------------------------------------
        end        
    % --------------------------
    end
end