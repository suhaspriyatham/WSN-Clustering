clear all;
clc;

n=100;
nc=5;
pt=100*rand(n, 2);
axis([-20 120 -20 120]);
d=rand(n,2)-0.5;
d=ceil(d)+floor(d);
[idx,C] = kmeans(pt,nc);
while(1)
    [idx,C] = kmeans(pt,nc);
    %cluster head selection------------------------------------------------
    for i=1:n
        dist(i)=sqrt((pt(i,1)-C(idx(i),1))^2+(pt(i,2)-C(idx(i),2))^2);
    end
    dCH=100*ones(nc,1);
    for i=1:n
        for j=1:nc
            if idx(i)==j && dCH(j)>=dist(i)
                CH(j)=i;
                dCH(j)=dist(i);
            end
        end 
    end
    %----------------------------------------------------------------------
    % plotting the nodes with the given cluster heads
    for wait=1:12
        dx=sqrt(0.01)*(rand(n,2));
        pt=pt+d.*dx;
        for i=1:2
            for j=1:n
                if pt(j,i)>100 || pt(j,i)<0
                    d(j,i)=-1*d(j,i);
                    pt(j,i)=d(j,i)*dx(j,i)+pt(j,i);
                end
            end
        end

        figure(1);
        gscatter(pt(:,1),pt(:,2));
        axis([0 100 0 100]);
        hold on;
    %     for i=1:nc
    %         plot(pt(CH(i),1),pt(CH(i),2),'o');
    %     end
        plot(C(:,1),C(:,2),'kx');
        for i=1:n
            plot([pt(CH(idx(i)),1) pt(i,1)],[pt(CH(idx(i)),2) pt(i,2)],'b');
        end
         %legend('Cluster 1','Cluster 2','Cluster 3','Cluster Centroid');
        hold off;
        axis([0 100 0 100]);
        pause(1/24);
    end
    
end