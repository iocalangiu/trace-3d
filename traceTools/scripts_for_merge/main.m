function [new_axons2] = main(A,units_this_voxel,axons)

new_axons = struct;
units = [];
stp_crit = 1;
count = 1;
while stp_crit == 1
%for ijk = 1:100
    all_dots = A(:,6);
    [max_value,max_dot]=max(all_dots);
    %/max_dot = index
    units = [units; A(max_dot,1) A(max_dot,2)];
    chk1 = find(A(:,1)==A(max_dot,1) | A(:,1)==A(max_dot,2));
    chk2 = find(A(:,2)==A(max_dot,1) | A(:,2)==A(max_dot,2));
    A(chk1,6) = NaN;
    A(chk2,6) = NaN;
    if length(units(:))==length(axons) || sum(isnan(A(:,6)))==size(A,1)
        stp_crit = 0;
    end
end
  
X = units(:); 
Y = units_this_voxel;
ismem = ismember(Y,X);
list_other_units = Y(~ismem);


for ik = 1:size(units,1)   
     [axons_tmp] = nanmergev2(axons,units(ik,1),units(ik,2));  
     for il =1:length(axons_tmp)
        new_axons(count).directionx = axons_tmp(il).directionx;
        new_axons(count).directiony = axons_tmp(il).directiony;
        new_axons(count).directionz = axons_tmp(il).directionz;
        count = count + 1;
     end
end



for in = 1:length(list_other_units)
    %if ~isempty(axons(in).directionx)
    new_axons(count).directionx = axons(list_other_units(in)).directionx;
    new_axons(count).directiony = axons(list_other_units(in)).directiony;
    new_axons(count).directionz = axons(list_other_units(in)).directionz;
    count = count + 1;
    %end
end

new_axons2 = struct;
count1 = 1;
for in = 1:length(new_axons)
    if ~isempty(new_axons(in).directionx)
        new_axons2(count1).directionx = new_axons(in).directionx;
        new_axons2(count1).directiony = new_axons(in).directiony;
        new_axons2(count1).directionz = new_axons(in).directionz;
        count1 = count1 + 1;    
    end
end

% rows = unique(A(:,1));
% count = 1;
% for ik = 1:length(rows)
%     
%      
%      indeces = A(A(:,1)==rows(ik),:);
%      this_dots = indeces(:,6);
%      [max_value,max_dot]=max(this_dots);
%      rows(ik);
%      indeces(max_dot,2);
%      if max_value~=0 && ~isempty(axons(indeces(max_dot,2)).directionx) && ~isempty(axons(rows(ik)).directionx)
%      [axons_tmp] = nanmergev2(axons,rows(ik),indeces(max_dot,2));
%      
%      for il =1:length(axons_tmp)
%         new_axons(count).directionx = axons_tmp(il).directionx;
%         new_axons(count).directiony = axons_tmp(il).directiony;
%         new_axons(count).directionz = axons_tmp(il).directionz;
%         count = count + 1;
%      end
%      
%      axons(indeces(max_dot,2)).directionx=[];
%      axons(rows(ik)).directionx=[];
%      end
% end

% for in = 1:length(axons)
%     if ~isempty(axons(in).directionx)
%         new_axons(count).directionx = axons(in).directionx;
%         new_axons(count).directiony = axons(in).directiony;
%         new_axons(count).directionz = axons(in).directionz;
%         count = count + 1;
%     end
% end

% count1 = 1;
% for in = 1:length(new_axons)
%     if ~isempty(new_axons(in).directionx)
%         new_axons2(count1).directionx = new_axons(in).directionx;
%         new_axons2(count1).directiony = new_axons(in).directiony;
%         new_axons2(count1).directionz = new_axons(in).directionz;
%         count1 = count1 + 1;    
%     end
% end


end

