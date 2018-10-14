img = imread('map.jpg');
format longEng
%assuming 1 AA baterries on each node
nodes = [Node(1200,-0.23,0.3345,0),...
    Node(1200,0.0944,0.7074,0),...
    Node(1200,0.2712,-0.1497,0),...
    Node(1200,0.7797,0.1155,0),...
    Node(1200,1.245,1.027,0),...
    Node(1200,1.717,0.7006,0),...
    Node(1200,1.707,0.9607,0),...
    Node(1200,1.857,0.7742,0),...
    Node(1200,1.961,0.6544,0),...
    Node(1200,2.153,0.6544,0),...
    Node(1200,1.511,1.459,0),...
    Node(1200,1.031,1.705,0),...
    Node(1200,0.6489,1.878,0),...
    Node(1200,0.2857,0.2352,0),...
    Node(1200,0.4939,0.627,0),...
    Node(1200,0.8475,0.4885,0),...
    Node(1200,0.477,1.332,0),...
    Node(1200,1.385,0.3755,0),...
    Node(inf,-0.6271,0.4012,0)...       % base station has infinite energy
    ];

n = Network(nodes, 10e-12, 0.0013e-12, 50e-9);

X = [];
Y = [];
C = [];

for i=1:length(nodes)
    X = [X n.nodes(i).x];
    Y = [Y n.nodes(i).y];
    C = [C; (n.nodes(i).energy)/100];
end


% draw figure %
set(gcf, 'Position', [500, 500, 700, 1500])
imagesc([-1 3], [-1 3], flipud(img));
hold on
scatter(X,Y,C,'filled');
xlim([-1 3])
ylim([-1 3])
drawnow
pause(1)
    
    
    
lifetime = 0;
simulationDone = 0;

while simulationDone == 0
    % Sending and Recieving operations to be done in each cycle %
    
    % ------ Algorithm Begin ------ %
    n = BCDCP(n, 3, 2048);
    % ------ Algorithm End   ------ %
    
    lifetime = lifetime + 1;
    
    
    % check if any node is dead %
    for i = 1:19
       if n.nodes(i).energy <= 0
          simulationDone = 1;
       end
    end
end

format
disp('Network Lifetime: ');
disp(lifetime);

