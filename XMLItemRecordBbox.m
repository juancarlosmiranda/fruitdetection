% XMLITEMRECORDBBOX 
%
% Author: https://github.com/juancarlosmiranda/
% Date: December 2020
classdef XMLItemRecordBbox
    %XMLItemRecordBBOX This serve as record variable to read XML format
    % This save data in MATLAB format bounding boxes for rectangle function
    
    properties
        name='';
        difficult=0;
        xmin=0;
        ymin=0;
        width=0;
        height=0;
    end
    
    methods
        function obj = XMLItemRecordBbox()
            %XMLItemRecord
            obj.name='';
            obj.difficult=0;
            obj.xmin=0;
            obj.ymin=0;
            obj.width=0;
            obj.height=0;
        end
        function vectorBoundingBox = getBoundingBox(obj)
            vectorBoundingBox=[ obj.xmin, obj.ymin, obj.width, obj.height];            
        end      
    end
end


