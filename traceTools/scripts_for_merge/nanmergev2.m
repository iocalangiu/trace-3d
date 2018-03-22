function [new_neurites] = nanmergev2(new_axons,i,j)

%===============Important Parameters=======================================
count = 1;
axons = struct;
%==========================================================================

%/ i is first
trace_x = smooth(new_axons(i).directionx,1,'loess')';
trace_y = smooth(new_axons(i).directiony,1,'loess')';
trace_z = smooth(new_axons(i).directionz,1,'loess')';
trace_x_test = smooth(new_axons(j).directionx,1,'loess')';
trace_y_test = smooth(new_axons(j).directiony,1,'loess')';
trace_z_test = smooth(new_axons(j).directionz,1,'loess')';
            
P = [trace_x', trace_y'];
Q = [trace_x_test', trace_y_test'];

D = pdist2(P,Q);  
max_half_length = 5000;
transf_x = NaN(2,2*max_half_length);
transf_y = NaN(2,2*max_half_length);
transf_z = NaN(2,2*max_half_length);

                   

[~,ll] = min(D(:)); %/ belongs to first trace
[row,col] = ind2sub(size(D),ll); %/row is trace_x, and col is trace_x_test
%/ row + 2000 - index
index_align_1 = row;
index_align_2 = col;


transf_x(1,max_half_length-index_align_1:max_half_length+length(trace_x)-index_align_1-1) = trace_x;
transf_y(1,max_half_length-index_align_1:max_half_length+length(trace_x)-index_align_1-1) = trace_y;
transf_z(1,max_half_length-index_align_1:max_half_length+length(trace_x)-index_align_1-1) = trace_z;

transf_x(2,max_half_length-index_align_2:max_half_length+length(trace_x_test)-index_align_2-1) = trace_x_test;
transf_y(2,max_half_length-index_align_2:max_half_length+length(trace_y_test)-index_align_2-1) = trace_y_test;
transf_z(2,max_half_length-index_align_2:max_half_length+length(trace_z_test)-index_align_2-1) = trace_z_test;

%/case 1
X = [transf_x(1,max_half_length+1:max_half_length+1+5)' transf_y(1,max_half_length+1:max_half_length+1+5)' transf_z(1,max_half_length+1:max_half_length+1+5)'];
Y = [transf_x(2,max_half_length+1:max_half_length+1+5)' transf_y(2,max_half_length+1:max_half_length+1+5)' transf_z(2,max_half_length+1:max_half_length+1+5)'];
[distance,min_distance1] = euclideanDistance_sequential(X,Y);
                    
%/case 2
X = [transf_x(1,max_half_length+1:max_half_length+1+5)' transf_y(1,max_half_length+1:max_half_length+1+5)' transf_z(1,max_half_length+1:max_half_length+1+5)'];
Y = [transf_x(2,max_half_length-1-5:max_half_length-1)' transf_y(2,max_half_length-1-5:max_half_length-1)' transf_z(2,max_half_length-1-5:max_half_length-1)'];
[distance,min_distance2] = euclideanDistance_sequential(X,Y);

if min_distance2<min_distance1
    %disp('Flipping')
    transf_x(2,:) = fliplr(transf_x(2,:));
    transf_y(2,:) = fliplr(transf_y(2,:));
    transf_z(2,:) = fliplr(transf_z(2,:));
end

[e_d] = naneuclidean(transf_x,transf_y,transf_z);

% ADDED !!!!!!!!
e_d(isnan(e_d)) = 200;

lk=find(e_d>1);
if ~isempty(lk)
    cut_points = find(diff(lk)~=1);
    
%     if isempty(cut_points)
%         cut_points = [1];
%     end
%     if ~isempty(cut_points)
    cut_points = [1 cut_points length(lk)];

    for inm = 1:length(cut_points)-1
    %/Axon 1 (1:cut_point)
    tmp = transf_x(1,lk(cut_points(inm)):lk(cut_points(inm+1)));
    axons(count).directionx = tmp(~isnan(tmp));
    transf_x(1,lk(cut_points(inm)):lk(cut_points(inm+1))) = NaN;

    tmp = transf_y(1,lk(cut_points(inm)):lk(cut_points(inm+1)));
    axons(count).directiony = tmp(~isnan(tmp));
    transf_y(1,lk(cut_points(inm)):lk(cut_points(inm+1))) = NaN;

    tmp = transf_z(1,lk(cut_points(inm)):lk(cut_points(inm+1)));
    axons(count).directionz = tmp(~isnan(tmp));
    transf_z(1,lk(cut_points(inm)):lk(cut_points(inm+1))) = NaN;
    count=count+1;

    %/Axon 2 (1:cut_point)
    tmp = transf_x(2,lk(cut_points(inm)):lk(cut_points(inm+1)));
    axons(count).directionx = tmp(~isnan(tmp));
    transf_x(2,lk(cut_points(inm)):lk(cut_points(inm+1))) = NaN;

    tmp = transf_y(2,lk(cut_points(inm)):lk(cut_points(inm+1)));
    axons(count).directiony = tmp(~isnan(tmp));
    transf_y(2,lk(cut_points(inm)):lk(cut_points(inm+1))) = NaN;

    tmp = transf_z(2,lk(cut_points(inm)):lk(cut_points(inm+1)));
    axons(count).directionz = tmp(~isnan(tmp));
    transf_z(2,lk(cut_points(inm)):lk(cut_points(inm+1)))=NaN;
    count=count+1;

    tmp = nanmean( transf_x(:,1:lk(cut_points(inm+1))) ,1);
    axons(count).directionx = tmp(~isnan(tmp));
    transf_x(:,1:lk(cut_points(inm+1)))=NaN;

    tmp = nanmean( transf_y(:,1:lk(cut_points(inm+1))) ,1);
    axons(count).directiony = tmp(~isnan(tmp));
    transf_y(:,1:lk(cut_points(inm+1)))=NaN;

    tmp = nanmean( transf_z(:,1:lk(cut_points(inm+1))) ,1);
    axons(count).directionz = tmp(~isnan(tmp));
    transf_z(:,1:lk(cut_points(inm+1)))=NaN;
    count=count+1;

    cut_points(inm+1) = cut_points(inm+1) + 1;                   
    end
%     end
end
tmp = nanmean( transf_x ,1);
axons(count).directionx = tmp(~isnan(tmp));
tmp(~isnan(tmp));

tmp = nanmean( transf_y ,1);
axons(count).directiony = tmp(~isnan(tmp));
tmp(~isnan(tmp));

tmp = nanmean( transf_z ,1);
axons(count).directionz = tmp(~isnan(tmp));
tmp(~isnan(tmp));
new_neurites = axons;


end







