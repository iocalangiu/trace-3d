
function [index,check_alignment_segment] = merge_last(trace_i1x,trace_i1y,trace_i1z,trace_j1x,trace_j1y,trace_j1z,check_alignment,check_2,stack_out)
index = 0;
check_alignment_segment = Inf;
if check_2<4
if length(trace_j1x)<=length(trace_i1x)
        
    for index = 1:length(trace_j1x)
        p = [trace_i1x(index) trace_i1y(index)];
        q = [trace_j1x(index) trace_j1y(index)];               
        D_pq = euclideanDistance(p,q);
        if D_pq>1  %abs(check_alignment) > 0.95
           break;
        end

    end
    vx1 = diff([trace_i1x(1) trace_i1x(index)]);
    vy1 = diff([trace_i1y(1) trace_i1y(index)]);
    vz1 = diff([trace_i1z(1) trace_i1z(index)]);

    vx2 = diff([trace_j1x(1) trace_j1x(index)]);
    vy2 = diff([trace_j1y(1) trace_j1y(index)]);
    vz2 = diff([trace_j1z(1) trace_j1z(index)]);

    vector1 = [vx1 vy1 vz1];
    vector1 = vector1/norm(vector1);
    vector2 = [vx2 vy2 vz2];
    vector2 = vector2/norm(vector2);
    check_alignment_segment = dot(vector1,vector2); 
else%/ >length(trace_i1x)

    for index = 1:length(trace_i1x)
        p = [trace_i1x(index) trace_i1y(index)];
        q = [trace_j1x(index) trace_j1y(index)];
        D_pq = euclideanDistance(p,q);
        if D_pq>1 %abs(check_alignment) > 0.95
            break;
        end
    end
    vx1 = diff([trace_i1x(1) trace_i1x(index)]);
    vy1 = diff([trace_i1y(1) trace_i1y(index)]);
    vz1 = diff([trace_i1z(1) trace_i1z(index)]);

    vx2 = diff([trace_j1x(1) trace_j1x(index)]);
    vy2 = diff([trace_j1y(1) trace_j1y(index)]);
    vz2 = diff([trace_j1z(1) trace_j1z(index)]);

    vector1 = [vx1 vy1 vz1];
    vector1 = vector1/norm(vector1);
    vector2 = [vx2 vy2 vz2];
    vector2 = vector2/norm(vector2);
    check_alignment_segment = dot(vector1,vector2); 
end
end%//if check_2<3

end

