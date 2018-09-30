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
            d = 120;
            %sqrt((node1.x-node2.x)^2 + (node1.y-node2.y)^2 + (node1.z-node2.z)^2);
            d0 = sqrt(obj.e_fs/obj.e_mp);
            if (d > d0)
                Etx = msg_size * obj.e_mp * d^4;
            else 
                Etx = msg_size * obj.e_fs * d^2;
            end
            disp(Etx);
            obj.nodes(n1).energy = obj.nodes(n1).energy - Etx - obj.E_elec * msg_size;
            obj.nodes(n2).energy = obj.nodes(n2).energy - obj.E_elec * msg_size;
        end
    end
end

