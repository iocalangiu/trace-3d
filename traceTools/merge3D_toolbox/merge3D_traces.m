function [merged_axons] = merge3D_traces(axons_splitted_update,indeces,stack)


distances_all = zeros(1,length(indeces));
decision_all = zeros(1,length(indeces));

for i = 1:length(indeces)
    distances_all(i) = axons_splitted_update(indeces(i)).distance;
    decision_all(i) = axons_splitted_update(indeces(i)).decision;
end

    
[c,index_sort]=sort(distances_all);
len_col=6000;
traces = nan(length(indeces)*3,len_col);
m=1;
for i = 1:length(indeces)
    traces(m  ,1:length(axons_splitted_update(indeces(index_sort(i))).directionx)) = axons_splitted_update(indeces(index_sort(i))).directionx;
    traces(m+1,1:length(axons_splitted_update(indeces(index_sort(i))).directiony)) = axons_splitted_update(indeces(index_sort(i))).directiony;
    traces(m+2,1:length(axons_splitted_update(indeces(index_sort(i))).directionz)) = axons_splitted_update(indeces(index_sort(i))).directionz;
    m=m+3;
    axons_splitted_update(indeces(index_sort(i))).distance;
end
%colors = ['g','k'];
%figure; imagesc(max(stack,[],3)); axis equal
%hold on
%for i = 1:length(indeces)
%    traces(m  ,1:length(axons_splitted_update(indeces(index_sort(i))).directionx)) = axons_splitted_update(indeces(index_sort(i))).directionx;
%    traces(m+1,1:length(axons_splitted_update(indeces(index_sort(i))).directiony)) = axons_splitted_update(indeces(index_sort(i))).directiony;
%    traces(m+2,1:length(axons_splitted_update(indeces(index_sort(i))).directionz)) = axons_splitted_update(indeces(index_sort(i))).directionz;
%    m=m+3;
%    axons_splitted_update(indeces(index_sort(i))).distance;
%end
%pause(1)

%hold off

[xm,ym,zm] = merge3D_meanTrajectory(traces,stack);
xm(xm==0)=[];
ym(ym==0)=[];
zm(zm==0)=[];
span = 50;
xs = smooth(xm, span);
ys = smooth(ym, span);
zs = smooth(zm, span);

% figure; imagesc(max(stack,[],3))
% hold on
% xlabel('result')
% %title(num2str(iteration))
%     dir = [ym; xm];
%     dir;
%     fnplt(cscvn(dir),1,'r')
%     %text(ym(1),xm(1),num2str(decision))
%     %text(ym(end),xm(end),num2str(iteration))
%     %hold off
% pause(1)
% % 


% %Correction
% stop=200;
% for correct=1:stop
% vx = [0 diff(xs')];
% vy = [0 diff(ys')];
% vz = [0 diff(zs')];
% ck=0;
% for ix = 3:length(vx)
%     vec1 = [vy(ix-1) vx(ix-1) vz(ix-1)];
%     vec1 = vec1/norm(vec1);
%     vec2 = [vy(ix) vx(ix) vz(ix)];
%     vec2 = vec2/norm(vec2);
%     dot_prod = dot(vec1,vec2);
%     if dot_prod<0
%         xs(ix)=[];
%         ys(ix)=[];
%         zs(ix)=[];
%         ck=1;
%         break;
%     end
% end
% if ck==0
%     break;
% end
% end


count = 1;
merged_axons(count).directionx = xs';
merged_axons(count).directiony = ys';
merged_axons(count).directionz = zs';

%end
% if ~isempty(indeces_not)
% count=2;
% for iix = 1:length(indeces_not)
% merged_axons(count).directionx = axons_splitted_update(indeces_not(iix)).directionx;
% merged_axons(count).directiony = axons_splitted_update(indeces_not(iix)).directiony;
% merged_axons(count).directionz = axons_splitted_update(indeces_not(iix)).directionz;
% count=count+1;
% end
% end


end

