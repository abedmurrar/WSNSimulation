classdef Node
    properties
        id;
        energy;
        x;
        y;
        z;
    end
    methods
        function obj = Node(id, energy, x, y, z)
            obj.id = id;
            obj.energy = energy;
            obj.x = x;
            obj.y = y;
            obj.z = z;
        end
    end
end