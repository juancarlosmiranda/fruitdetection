classdef XMLItemRecord
    %XMLItemRecord This serve as record variable to read XML format
    %   ...
    
    properties
        name='';
        difficult=0;
        xmin=0;
        ymin=0;
        xmax=0;
        ymax=0;
    end
    
    methods
        function obj = XMLItemRecord()
            %XMLItemRecord
            obj.name='';
            obj.difficult=0;
            obj.xmin=0;
            obj.ymin=0;
            obj.xmax=0;
            obj.ymax=0;
        end
        function vectorBoundingBox = getBoundingBox(obj)
            vectorBoundingBox=[ obj.xmin, obj.ymin, obj.xmax, obj.ymax];            
        end        
    end
end


