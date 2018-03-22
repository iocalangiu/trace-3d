function [ax_merged,pairs_that_dont_work] = merge3D_other_step2(axons,stack_out)

check1_thresh = 25;
check2_thresh = 0.8;
connected_pair = [NaN NaN];
counter = 1;
pairs_that_dont_work = [];

for ix = 1:length(axons)
    
    if ~isempty(axons(ix).friends)
    
    pairs = axons(ix).friends;
    length(pairs)
    for iy = 1:length(pairs)
    
    if ~isempty(axons(ix).friends{iy})
    check_tr = zeros(1,5);
        
    pair = pairs{iy};
    %Check 1
    check1 = abs(pair{3}-pair{4});
    whos connected_pair
    if check1<check1_thresh && isempty(find(connected_pair(:)==pair{1})) && isempty(find(connected_pair(:)==pair{2}))%&& isempty(find(ismember(connected_pair,[pair{1} pair{2}],'rows')))
        disp('CHECK1 - GOOD')
        c=1;
        clear new_ax
        clear merged_axons_tmp
        
        this_x_red = pair{5}(1,:);
        this_y_red = pair{5}(2,:);
        this_x_green = pair{6}(1,:);
        this_y_green = pair{6}(2,:);
        cut_point = length(this_x_red);
        
        cut_point1 = max(find(round(axons(pair{1}).directionx)==round(this_x_red(cut_point))));
        new_ax(c).directionx = axons(pair{1}).directionx(1:cut_point1);
        new_ax(c).directiony = axons(pair{1}).directiony(1:cut_point1);
        new_ax(c).directionz = axons(pair{1}).directionz(1:cut_point1);
        vect11 = [new_ax(c).directionx(1)-new_ax(c).directionx(end) new_ax(c).directiony(1)-new_ax(c).directiony(end) new_ax(c).directionz(1)-new_ax(c).directionz(end)];
        vect11 = vect11/norm(vect11);
        c=c+1;
        
        new_ax(c).directionx = axons(pair{1}).directionx(cut_point1:end);
        new_ax(c).directiony = axons(pair{1}).directiony(cut_point1:end);
        new_ax(c).directionz = axons(pair{1}).directionz(cut_point1:end);
        vect12 = [new_ax(c).directionx(1)-new_ax(c).directionx(end) new_ax(c).directiony(1)-new_ax(c).directiony(end) new_ax(c).directionz(1)-new_ax(c).directionz(end)];
        vect12 = vect12/norm(vect12);
        c=c+1;
        
        axons(pair{1}).directionx(cut_point1);
        axons(pair{1}).directiony(cut_point1);
        axons(pair{1}).directionz(cut_point1);
        
        cut_point2 = max(find(round(axons(pair{2}).directionx)==round(this_x_green(cut_point))));
        new_ax(c).directionx = axons(pair{2}).directionx(1:cut_point2);
        new_ax(c).directiony = axons(pair{2}).directiony(1:cut_point2);
        new_ax(c).directionz = axons(pair{2}).directionz(1:cut_point2);
        
        vect21 = [new_ax(c).directionx(1)-new_ax(c).directionx(end) new_ax(c).directiony(1)-new_ax(c).directiony(end) new_ax(c).directionz(1)-new_ax(c).directionz(end)];
        vect21 = vect21/norm(vect21); 
        c=c+1;
        
        new_ax(c).directionx = axons(pair{2}).directionx(cut_point2:end);
        new_ax(c).directiony = axons(pair{2}).directiony(cut_point2:end);
        new_ax(c).directionz = axons(pair{2}).directionz(cut_point2:end);
        vect22 = [new_ax(c).directionx(1)-new_ax(c).directionx(end) new_ax(c).directiony(1)-new_ax(c).directiony(end) new_ax(c).directionz(1)-new_ax(c).directionz(end)];
        vect22 = vect22/norm(vect22);
        
        axons(pair{2}).directionx(cut_point2);
        axons(pair{2}).directiony(cut_point2);
        axons(pair{2}).directionz(cut_point2);
        
        dot1 = dot(vect11, vect21);%1 and 3
        dot2 = dot(vect12, vect22);%2 and 4
        dot3 = dot(vect21, vect12);%3 and 2
        dot4 = dot(vect22, vect11);%4 and 1
        dots = [dot1 dot2 dot3 dot4];
        [max_dot,index_dot]=max(abs(dots));
        
        if dots(index_dot)<0
            new_ax(index_dot).directionx = fliplr(new_ax(index_dot).directionx);
            new_ax(index_dot).directiony = fliplr(new_ax(index_dot).directiony);
            new_ax(index_dot).directionz = fliplr(new_ax(index_dot).directionz);
        end
        
        if max_dot>check2_thresh
        disp('CHECK2 - GOOD')
        switch index_dot
            case 1
                [merged_axons_tmp] = merge3D_main(new_ax,stack_out);
            case 2
                [merged_axons_tmp] = merge3D_main(new_ax,stack_out);
            case 3
                [merged_axons_tmp] = merge3D_main(new_ax,stack_out);
            case 4
                [merged_axons_tmp] = merge3D_main(new_ax,stack_out);
        end
        %disp(['ELEMENTS: ' num2str(length(merged_axons_tmp))])   
        %pause(1)
        length(new_ax)
        
        length(merged_axons_tmp)
        for ij = 1:length(merged_axons_tmp)
            ax_merged(counter).directionx = merged_axons_tmp(ij).directionx;
            ax_merged(counter).directiony = merged_axons_tmp(ij).directiony;
            ax_merged(counter).directionz = merged_axons_tmp(ij).directionz;
            counter = counter + 1;
        end
        check_tr(1,1) = 1;
        connected_pair = [connected_pair; [pair{1} pair{2}]];
        
        else %/ dot_max<0.9
           pairs_that_dont_work = [pairs_that_dont_work; [pair{1} pair{2}]];
           %ax_merged(counter).directionx = axons(pair{1}).directionx;
           %ax_merged(counter).directiony = axons(pair{1}).directiony;
           %ax_merged(counter).directionz = axons(pair{1}).directionz;
           %counter = counter + 1;
           
           %ax_merged(counter).directionx = axons(pair{2}).directionx;
           %ax_merged(counter).directiony = axons(pair{2}).directiony;
           %ax_merged(counter).directionz = axons(pair{2}).directionz;
           %counter = counter + 1;
           
           %connected_pair = [connected_pair; [pair{1} pair{2}]];
           check_tr(1,2) = 1;
        end
    end
    
%     if check1>=check1_thresh && isempty(find(connected_pair(:)==pair{1})) && isempty(find(connected_pair(:)==pair{2}))
%        disp('CHECK1 - NOT GOOD')
%        pairs_that_dont_work = [pairs_that_dont_work; [pair{1} pair{2}]];
%        ax_merged(counter).directionx = axons(pair{1}).directionx;
%        ax_merged(counter).directiony = axons(pair{1}).directiony;
%        ax_merged(counter).directionz = axons(pair{1}).directionz;
%        counter = counter + 1;
% 
%        ax_merged(counter).directionx = axons(pair{2}).directionx;
%        ax_merged(counter).directiony = axons(pair{2}).directiony;
%        ax_merged(counter).directionz = axons(pair{2}).directionz;
%        counter = counter + 1;   
%        
%        connected_pair = [connected_pair; [pair{1} pair{2}]];
%        check_tr(1,3)=1;
%     end
%     
%     if isempty(find(connected_pair(:)==pair{1})) && ~isempty(find(connected_pair(:)==pair{2}))
%         
%        ax_merged(counter).directionx = axons(pair{1}).directionx;
%        ax_merged(counter).directiony = axons(pair{1}).directiony;
%        ax_merged(counter).directionz = axons(pair{1}).directionz;
%        counter = counter + 1; 
%        connected_pair = [connected_pair; [pair{1} NaN]];
%        check_tr(1,4)=1;
%     end
%     
%     if ~isempty(find(connected_pair(:)==pair{1})) && isempty(find(connected_pair(:)==pair{2}))
%        ax_merged(counter).directionx = axons(pair{2}).directionx;
%        ax_merged(counter).directiony = axons(pair{2}).directiony;
%        ax_merged(counter).directionz = axons(pair{2}).directionz;
%        connected_pair = [connected_pair; [NaN pair{2}]];
%        counter = counter + 1;   
%        check_tr(1,5)=1;
%     end
    
    %if sum(check_tr)~=1
    %    disp('!!!!!!!!!!!!!!!!!!!!!!')
    %    check_tr
    %    pause(1)
    %end
    end
    disp('-----------------------')
    end
    end
end


for ix = 1:length(axons)
    if isempty(find(connected_pair(:)==ix))
           ax_merged(counter).directionx = axons(ix).directionx;
           ax_merged(counter).directiony = axons(ix).directiony;
           ax_merged(counter).directionz = axons(ix).directionz;
           counter = counter + 1;        
    end
end

[~,pixel_length1] = trace3D_computeAxonalLength(axons,[1 1 1])
[~,pixel_length2] = trace3D_computeAxonalLength(ax_merged,[1 1 1])
