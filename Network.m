classdef Network
    properties
        nodes;
        e_fs;
        e_mp;
        E_elec;
    end
    
    methods
        function obj = Network(nodes, e_fs, e_mp, E_elec)
            obj.nodes = nodes;
            obj.e_fs = e_fs;
            obj.e_mp = e_mp;
            obj.E_elec = E_elec;
        end
        
        function obj = sendMessage(obj, n1, n2, msg_size)
            % 154 is the scaling factor for the distance
            d = sqrt((obj.nodes(n1).x-obj.nodes(n2).x)^2 + (obj.nodes(n1).y-obj.nodes(n2).y)^2 + (obj.nodes(n1).z-obj.nodes(n2).z)^2) * 154;
            d0 = sqrt(obj.e_fs/obj.e_mp);
            if (d > d0)
                Etx = msg_size * obj.e_mp * d^4;
            else 
                Etx = msg_size * obj.e_fs * d^2;
            end
            obj.nodes(n1).energy = obj.nodes(n1).energy - Etx - obj.E_elec * msg_size;
            obj.nodes(n2).energy = obj.nodes(n2).energy - obj.E_elec * msg_size;
        end
    end
end

