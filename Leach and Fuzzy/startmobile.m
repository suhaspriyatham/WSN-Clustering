clc;
clear all;
close all;

numNodes = 100; % number of nodes
pr = .1;
algr='fuzzyeval';   % algorithm selection 'leach' or 'fuzzyeval'
netArch  = newNetwork(100, 100, 50, 175);
nodeArch = newNodes(netArch, numNodes);
roundArch = newRound();
clusterModel = newCluster(netArch, nodeArch, algr, 1);


alpha=.8;
figure;
plot1;

par = struct;
direc=rand(numNodes,2)-0.5;
direc=ceil(direc)+floor(direc);

for r = 1:roundArch.numRound
    r
    pt=nodeArch.nodesLoc;
    % motion of nodes
    dx=sqrt(1)*(rand(numNodes,2));
    pt=pt+direc.*dx;
    for i=1:2
        for j=1:numNodes
            if pt(j,i)>100 || pt(j,i)<0
                direc(j,i)=-1*direc(j,i);
                pt(j,i)=direc(j,i)*dx(j,i)+pt(j,i);
            end
        end
    end
    %updating the location of nodes
    nodeArch.nodesLoc=pt;
    for i=1:numNodes
        nodeArch.node(i).x=pt(i,1);
        nodeArch.node(i).y=pt(i,2);
    end
    clusterModel.nodeArch.nodesLoc=pt;
    for i=1:numNodes
        clusterModel.nodeArch.node(i).x=pt(i,1);
        clusterModel.nodeArch.node(i).y=pt(i,2);
    end
    for i=1:length(clusterModel.clusterNode.no)
        clusterModel.cluserNode.loc(i,:)=pt(clusterModel.clusterNode.no(i),:);
    end
    
    %condition for clustering by comparing the energy
    j=1;    
    for i=clusterModel.clusterNode.no
        if nodeArch.node(i).energy<=alpha*clusterModel.CHinitialEng(j)
            clusterModel = newCluster(netArch, nodeArch, algr, r);
            break;
        end
        j=j+1;
    end
    
    clusterModel = dissEnergyCH(clusterModel, roundArch);
    clusterModel = dissEnergyNonCH(clusterModel, roundArch);
    nodeArch     = clusterModel.nodeArch; % new node architecture after select CHs
    
    par = plotResults(clusterModel, r, par);
    if nodeArch.numDead == nodeArch.numNode
        break
    end
    
    plotnodes;
    %pause(.5);
    if r==100 || r==250 || r==500 ||r==800 || r==900
        if r==100
            for i=1:100
                E1(i)=nodeArch.node(i).energy/.5*100;
            end
        end
        if r==250
            for i=1:100
                E2(i)=nodeArch.node(i).energy/.5*100;
            end
        end
        if r==500
            for i=1:100
                E3(i)=nodeArch.node(i).energy/.5*100;
            end
        end
        if r==800
            for i=1:100
                E4(i)=nodeArch.node(i).energy/.5*100;
            end
        end
        if r==900
            for i=1:100
                E5(i)=nodeArch.node(i).energy/.5*100;
            end
            figure;
            l=1:100;
            plot(l,E1,l,E2,l,E3,l,E4,l,E5);
            legend('100 rounds','250 rounds','500 rounds','800 rounds','900 rounds');
            axis([0 120 0 110]);
            xlabel('nodes');
            ylabel('Residual Energy in percentage');
            title('Residual Energy in nodes for alpha=0.8');
            %break;
        end
    end
end