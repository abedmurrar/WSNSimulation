% an assumption is made that the initial energies of the nodes are none and
% that at each transmission stage the energies are also sent, so there is
% no need to send the energies in seperate messages

function n2 = BCDCP( n, numOfClusters, msgSize)
    % find the average of all energies of the nodes %
    energySum = 0;
    for i = 1:18
        energySum = energySum + n.nodes(i).energy;
    end
    energyAvg = energySum / 18;
    
    % create set S %
    S = [];
    for i = 1:18
       if n.nodes(i).energy >= energyAvg
           S = [S i];
       end
    end
    
    % divide to clusters into 'numOfClusters' clusters %
    Clusters = {S};
    for i = 1:numOfClusters-1
        % get max size cluster so far to divide it
        maxLen = -inf;
        maxLenIndex = 0;
        maxLenVector = [];
        for j = 1:length(Clusters)
            if length(Clusters{j}) > maxLen
                maxLen = length(Clusters{j});
                maxLenVector = Clusters{j};
                maxLenIndex = j;
            end
        end

        % remove the max length vector in the Clusters and replace with 2 %
        Clusters(maxLenIndex) = [];
        [c1, c2] = create2Clusters(n, maxLenVector);
        Clusters{length(Clusters)+1} = c1;
        Clusters{length(Clusters)+1} = c2;
    end
    
    
    % Assume direct transmission to base station from clusterheads for now
    for i=1:length(Clusters)
        F = Clusters{i};
        for j=2:length(F)
            n = n.sendMessage(F(j),F(1), msgSize);
        end
        n = n.sendMessage(F(1), 19, msgSize);
    end
    
    
    n2 = n;
end


function [S1, S2] = create2Clusters(n, S)
    % Find the 2 most furthest nodes in S %
    max = -inf;
    maxNodes = [0,0];
    for i = 1:length(S)
        for j = i:length(S)
            d = sqrt((n.nodes(S(i)).x-n.nodes(S(j)).x)^2 + (n.nodes(S(i)).y-n.nodes(S(j)).y)^2 + (n.nodes(S(i)).z-n.nodes(S(j)).z)^2) * 154; 
            if d > max
                max = d;
                maxNodes = [S(i),S(j)];
            end
        end
    end
    % make cluster heads the first entry
    S1 = maxNodes(1);
    S2 = maxNodes(2);
    
    % create the clusters S1 and S2
    for i = S
       if i == maxNodes(1) || i ==  maxNodes(2)
           continue;
       end
       d1 = sqrt((n.nodes(i).x-n.nodes(maxNodes(1)).x)^2 + (n.nodes(i).y-n.nodes(maxNodes(1)).y)^2 + (n.nodes(i).z-n.nodes(maxNodes(1)).z)^2) * 154; 
       d2 = sqrt((n.nodes(i).x-n.nodes(maxNodes(2)).x)^2 + (n.nodes(i).y-n.nodes(maxNodes(2)).y)^2 + (n.nodes(i).z-n.nodes(maxNodes(2)).z)^2) * 154; 
       if  d1 < d2
           S1 = [S1 i];
       else
           S2 = [S2 i];
       end
    end
end

