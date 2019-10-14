% %evaluating fis output = evalfis(fis,input)
% NodeDegree=1;
% NodeCentrality=0;

% o=evalfis([NodeDegree NodeCentrality],f);

function [nodeArch, clusterNode] = fuzzylogic(clusterModel, clusterFunParam)
% Create the new node architecture using fuzzy logic algorithm in beginning 
%  of each round. This function is called by newCluster function.
%   
%   Input:
%       clusterModel        Cluster model by newCluster function
%       clusterFunParam     Parameters for the cluster function
%                   [r ]
%   Example:
%       [nodeArch, clusterNode] = feval('leach', clusterModel, clusterFunParam);
%
% Mohammad Hossein Homaei, homaee@gmail.com, Homaei@wsnlab.org
% Ver 1. 06/2014
    f=readfis('fuzzyclustering3in.fis');
    nodeArch = clusterModel.nodeArch;
    netArch  = clusterModel.netArch;
    
    Einitial = netArch.Energy.init;
    r = clusterFunParam(1); % round number
    p = clusterModel.p; %probabilty of a node being CH
    N = nodeArch.numNode; % number of nodes
    numAlive = N-nodeArch.numDead; % number of alive nodes
    area = netArch.Yard.Length*netArch.Yard.Width;
    M = netArch.Yard.Length; %network dimension
    
    %%%%%%%% reset the CH after numCluster round
%     if (mod(r, clusterModel.numCluster) == 0)
%         for i = 1:N
%             nodeArch.node(i).G = 0; % not selected for CH
%         end
%     end
    
    %%%%%%%% Checking if there is a dead node
    locAlive = find(~nodeArch.dead); % find the nodes that are alive
    for z = locAlive
        if nodeArch.node(z).energy <= 0
            nodeArch.node(z).type = 'D';
            nodeArch.dead(z) = 1;
        else
            nodeArch.node(z).type = 'N';
        end
    end
    nodeArch.numDead = sum(nodeArch.dead);
    
    %%%%%%%% find the cluster head
    % define cluster structure
    clusterNode     = struct();
    %
    locAlive = find(~nodeArch.dead); % find the nodes that are alive
    countCHs = 0;
    k=1;
    for z = locAlive %evaluating fuzzy cost in alive nodes
        
        %%%%%% calculating inputs for fuzzy logic i.e residual energy, node
        %centrality and node degree
        
        %Redidual energy percentage
        Eresidual = nodeArch.node(z).energy;
        Energylevel(z)=Eresidual/Einitial*100;
        
        % node degree and node centrality
        radius=sqrt(area/(pi*N*p));
        Snbr(z)=-1;
        sumd=0;
        for j=locAlive
            d=sqrt((nodeArch.nodesLoc(z,1)-nodeArch.nodesLoc(j,1))^2 + (nodeArch.nodesLoc(z,2)-nodeArch.nodesLoc(j,2))^2);
            if d<=radius
                Snbr(z)=Snbr(z)+1;
                sumd=sumd+d^2;
            end
        end
        NodeDegree(z)=Snbr(z)/numAlive;
        if Snbr(z)==0
            NodeCentrality(z)=1;
        else
            NodeCentrality(z)=sqrt(sumd/Snbr(z))/M;
        end
        fuzzycost(z)=evalfis([NodeDegree(z) NodeCentrality(z) Energylevel(z)],f);
        fuzzycostwithindex(k,:)=[fuzzycost(z) z];
        k=k+1;
    end
    
    %deciding Cluster Heads
    [~,I] = mink(fuzzycostwithindex(:,1),1/p); %I is indices of min fuzzy cost
    
    CHs=fuzzycostwithindex(I,2);
    countCHs = 0;
    for z=CHs'
        countCHs = countCHs+1;
        nodeArch.node(z).type          = 'C';
        nodeArch.node(1,1).G           = round(1/p)-1;
        clusterNode.no(countCHs)       = z; % the no of node
        xLoc = nodeArch.node(z).x; % x location of CH
        yLoc = nodeArch.node(z).y; % y location of CH
        clusterNode.loc(countCHs, 1)   = xLoc;
        clusterNode.loc(countCHs, 2)   = yLoc;
        % Calculate distance of CH from BS
        clusterNode.distance(countCHs) = sqrt((xLoc - netArch.Sink.x)^2 ...
                                              + (yLoc - netArch.Sink.y)^2);
    end
    
    clusterNode.countCHs = 1/p;
end