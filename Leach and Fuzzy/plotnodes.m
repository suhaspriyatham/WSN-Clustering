% plotting the nodes with the given cluster heads


clear d;

nodloc=nodeArch.nodesLoc;
CHnum=clusterModel.clusterNode.no;
Cnum=clusterModel.reportstoCH; %belong to cluster number/ reports to CH
j=1;
for i=CHnum
    CHloc(j,:)=nodloc(i,:);
    j=j+1;
end
% Cnum=zeros(nodeArch.numNode,1); %cluster number
% % determining the cluster members
% for nod=1:nodeArch.numNode
%     if nodeArch.dead(nod)==0
%         for chnod=1:length(CHnum)
%             d(chnod)=sqrt((CHloc(chnod,1)-nodloc(nod,1))^2+(CHloc(chnod,2)-nodloc(nod,2))^2);
%         end
%         [~,I]=min(d);
%         Cnum(nod)=clusterModel.clusterNode.no(I);
%     end
% end
       
% plotting
figure(1);
scatter(nodloc(:,1),nodloc(:,2),'.','r');
hold on;
scatter(CHloc(:,1),CHloc(:,2),'*','k');
for nod=1:nodeArch.numNode
    if nodeArch.dead(nod)==0 
        scatter(nodloc(nod,1),nodloc(nod,2),'.','b');
        hold on;
        plot([nodloc(Cnum(nod),1) nodloc(nod,1)],[nodloc(Cnum(nod),2) nodloc(nod,2)],'b');
        hold on;
    end
end
hold off;
