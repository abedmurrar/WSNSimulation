img = imread('map1.jpg');

%assuming 1 AA baterries on each node
nodes = [Node(1,12000,0,2.65,1),  Node(2,12000,-0.1,2.46,1),  Node(3,12000,-0.3,2.1,2)];
n = Network(nodes, 10e-12, 0.0013e-12, 50e-9);

X = [];
Y = [];
C = [];

%for i=1:length(nodes)
%    X = [X n.nodes(i).x];
%    Y = [Y n.nodes(i).y];
%    C = [C; (n.nodes(i).energy)/100];
%end

lifetime = 0;

%while (n.nodes(1).energy * n.nodes(2).energy * n.nodes(3).energy > 0)
for i=0:5    
    % Sending and Recieving operations to be done in each cycle %
    n.sendMessage(1,2, 2048);
    n.sendMessage(2,3, 2048);
    
    
    % Update energies of nodes %
    %C = [];
    %for i=1:length(n.nodes)
    %    C = [C; (n.nodes(i).energy)/100];
    %end
    
    % Redraw figure %
    %set(gcf, 'Position', [500, 500, 700, 1500])
    %imagesc([-1 3], [-1 3], flipud(img));
    %hold on
    %scatter(X,Y,C,'filled');
    %xlim([-1 3])
    %ylim([-1 3])
    %drawnow
    %pause(1)
    
    lifetime = lifetime + 1;
end

disp('Network Lifetime: ');
disp(lifetime);
