function [new_neurites] = nanmergev3(new_axons, i, j)

count = 1;
axons = struct;

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
transf_x = NaN(2,4000);
transf_y = NaN(2,4000);
transf_z = NaN(2,4000);

                   

[~,ll] = min(D(:)); %/ belongs to first trace
[row,col] = ind2sub(size(D),ll); %/row is trace_x, and col is trace_x_test
%/ row + 2000 - index
index_align_1 = row;
index_align_2 = col;

transf_x(1,2000-index_align_1:2000+length(trace_x)-index_align_1-1) = trace_x;
transf_y(1,2000-index_align_1:2000+length(trace_x)-index_align_1-1) = trace_y;
transf_z(1,2000-index_align_1:2000+length(trace_x)-index_align_1-1) = trace_z;

transf_x(2,2000-index_align_2:2000+length(trace_x_test)-index_align_2-1) = trace_x_test;
transf_y(2,2000-index_align_2:2000+length(trace_y_test)-index_align_2-1) = trace_y_test;
transf_z(2,2000-index_align_2:2000+length(trace_z_test)-index_align_2-1) = trace_z_test;

%/case 1
X = [transf_x(1,2001:2001+5)' transf_y(1,2001:2001+5)' transf_z(1,2001:2001+5)'];
Y = [transf_x(2,2001:2001+5)' transf_y(2,2001:2001+5)' transf_z(2,2001:2001+5)'];
[distance,min_distance1] = euclideanDistance_sequential(X,Y);
                    
%/case 2
X = [transf_x(1,2001:2001+5)' transf_y(1,2001:2001+5)' transf_z(1,2001:2001+5)'];
Y = [transf_x(2,1999-5:1999)' transf_y(2,1999-5:1999)' transf_z(2,1999-5:1999)'];
[distance,min_distance2] = euclideanDistance_sequential(X,Y);

if min_distance2<min_distance1
    %disp('Flipping')
    transf_x(2,:) = fliplr(transf_x(2,:));
    transf_y(2,:) = fliplr(transf_y(2,:));
    transf_z(2,:) = fliplr(transf_z(2,:));
end

[e_d] = naneuclidean(transf_x,transf_y,transf_z);
e_d(isnan(e_d)) = -200;
lk=find(e_d>1);

if ~isempty(lk)
    [rbeg,rend,rlen] = findconsecutive(lk);
    cut_points = find(rlen>=2);
    
    rbeg_valid = rbeg(rlen>=2);
    rend_valid = rend(rlen>=2);
    
    for inm = 1:length(cut_points)
    %/Axon 1 (1:cut_point)
    %this_start = find(lk==rbeg(cut_points(inm)));
    %this_end = find(lk==rend(cut_points(inm)));

    this_start = rbeg_valid(inm);
    this_end   = rend_valid(inm);
    
    if this_start-1 ~= 0
        this_start = this_start - 1;
    end
    
    if this_end + 1 <= size(transf_x,2)
        this_end = this_end + 1;
    end
    this_section = this_start:this_end;
    
    tmp = transf_x(1,this_section);
    axons(count).directionx = tmp(~isnan(tmp));
    transf_x(1,this_section) = NaN;
    %transf_x(2,this_section) = NaN;
    
    tmp = transf_y(1,this_section);
    axons(count).directiony = tmp(~isnan(tmp));
    transf_y(1,this_section) = NaN;
    %transf_y(2,this_section) = NaN;
    
    tmp = transf_z(1,this_section);
    axons(count).directionz = tmp(~isnan(tmp));
    transf_z(1,this_section) = NaN;
    %transf_z(2,this_section) = NaN;
    count=count+1;

    end
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

cin = 1;
new_neurites = struct;
for in = 1:size(new_axons,2)
    if in ~= i && in ~= j
        
        new_neurites(1,cin).directionx = new_axons(1,in).directionx;
        new_neurites(1,cin).directiony = new_axons(1,in).directiony;
        new_neurites(1,cin).directionz = new_axons(1,in).directionz;
        cin = cin + 1;
        
    end
end

for in = 1:size(axons,2)
    if ~isempty(axons(1,in).directionx)
        clear ctmp
        ctmp = axons(1,in).directionx;
        ctmp(ctmp == 0) = [];
        new_neurites(1,cin).directionx = ctmp;
        
        clear ctmp
        ctmp = axons(1,in).directiony;
        ctmp(ctmp == 0) = [];
        new_neurites(1,cin).directiony = ctmp;
        
        clear ctmp
        ctmp = axons(1,in).directionz;
        ctmp(ctmp == 0) = [];
        new_neurites(1,cin).directionz = ctmp;
        cin = cin + 1;
        
    end
end



end







