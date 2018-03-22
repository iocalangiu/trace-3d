function [distance,decision] = gets_distance(trace_x,trace_y,stack_out)

P = [trace_y(1),trace_x(1)];
ax = ones(1,size(stack_out,1));
ay = 1:size(stack_out,1);
Q = [ax',ay'];
D = euclideanDistance(P,Q);
min_D_start = min(D(:));
P = [trace_y(end),trace_x(end)];
D = euclideanDistance(P,Q);
min_D_end = min(D(:));
distance_1 = abs(min_D_start-min_D_end);

%/vertical
clear P
clear Q
P = [trace_y(1),trace_x(1)];
ay = ones(1,size(stack_out,2))*size(stack_out,1);
ax = 1:size(stack_out,2);
Q = [ax',ay'];
D = euclideanDistance(P,Q);
min_D_start = min(D(:));
P = [trace_y(end),trace_x(end)];
D = euclideanDistance(P,Q);
min_D_end = min(D(:));
distance_2 = abs(min_D_start-min_D_end);

if distance_1 > distance_2
    %/ horizontal
    P = [trace_y(1),trace_x(1)];
    ax = ones(1,size(stack_out,1));
    ay = 1:size(stack_out,1);
    Q = [ax',ay'];
    D = euclideanDistance(P,Q);
    min_D_start = min(D(:));
    P = [trace_y(end),trace_x(end)];
    D = euclideanDistance(P,Q);
    min_D_end = min(D(:));

    if min_D_end<min_D_start
        distance = min_D_end;
        decision = 2;
    else
        distance = min_D_start;
        decision = 2;
    end   
end %/ distance_1 > distance_2

if distance_2 >= distance_1
    %/vertical
    P = [trace_y(1),trace_x(1)];
    ay = ones(1,size(stack_out,2))*size(stack_out,1);
    ax = 1:size(stack_out,2);
    Q = [ax',ay'];
    D = euclideanDistance(P,Q);
    min_D_start = min(D(:));
    P = [trace_y(end),trace_x(end)];
    D = euclideanDistance(P,Q);
    min_D_end = min(D(:));

    if min_D_end>min_D_start
        distance = min_D_start;
        decision = 1;
    else
        distance = min_D_end;
        decision = 1;
    end    
end %/ distance_2 > distance_1


end

