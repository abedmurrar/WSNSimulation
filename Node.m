classdef Node
    properties
        energy;
        x;
        y;
        z;
    end
    methods
        function obj = Node(energy, x, y, z)
            obj.energy = energy;
            obj.x = x;
            obj.y = y;
            obj.z = z;
        end
    end
end