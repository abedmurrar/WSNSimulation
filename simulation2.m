img = imread('map.jpg');
format longEng
% Calculating for 1J initial energy
nodes = [
    Node(1,1.717,0.7006,0),...
    Node(10000,1.707,0.9607,0),...      % sink
    Node(1,1.857,0.7742,0),...
    Node(1,2.153,0.6544,0)...
    % base station has infinite energy
    ];

n = Network(nodes, 10e-12, 0.0013e-12, 1.65e-5);

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
    n = n.sendMessage(2, 1, 20*8);
    n = n.sendMessage(1, 3, 20*8);
    n = n.sendMessage(3, 4, 20*8);
    n = n.sendMessage(4, 3, 20*8);
    n = n.sendMessage(3, 1, 20*8);
    n = n.sendMessage(1, 2, 20*8);
%      n = n.sendMessage(2, 1, 20*8);
%      n = n.sendMessage(1, 2, 20*8);
%      n = n.sendMessage(2, 3, 20*8);
%      n = n.sendMessage(3, 2, 20*8);
%      n = n.sendMessage(2, 4, 20*8);
%      n = n.sendMessage(4, 2, 20*8);
    % ------ Algorithm End   ------ %
    
    lifetime = lifetime + 1;
    
    
    % check if any node is dead %
    for i = 1:length(nodes)
       if n.nodes(i).energy <= 0
          simulationDone = 1;
       end
    end
end

format
disp('Network Lifetime: ');
disp(lifetime);

