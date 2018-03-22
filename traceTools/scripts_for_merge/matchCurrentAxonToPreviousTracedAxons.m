function [pair_x] = matchCurrentAxonToPreviousTracedAxons(axons, new_trace)

step = 5;


if isfield(axons,'directionx')
    idata = NaN(size(axons,2), 5);
    
    for ix = 1: size(axons,2)

        trace_x = axons(ix).directionx(1:step:end);
        trace_y = axons(ix).directiony(1:step:end);
        trace_z = axons(ix).directionz(1:step:end);
        
        trace_x_test = new_trace.directionx(1:step:end);
        trace_y_test = new_trace.directiony(1:step:end);
        trace_z_test = new_trace.directionz(1:step:end);

        P = [trace_x', trace_y', trace_z'];
        Q = [trace_x_test', trace_y_test', trace_z_test'];

        D = pdist2(P,Q); 

        D_min = find(D(:)<=1);

        dot_ij = [];
        for in3 = 1: numel(D_min)
            ll = D_min(in3);
            [row,col] = ind2sub(size(D),ll);

            if row~= length(trace_x) && col~=length(trace_x_test)
            vx1 = trace_x(row:row+1);
            vy1 = trace_y(row:row+1);
            vz1 = trace_z(row:row+1);

            vx2 = trace_x_test(col:col+1);
            vy2 = trace_y_test(col:col+1);
            vz2 = trace_z_test(col:col+1);

            v1 = [vx1(2)-vx1(1) vy1(2)-vy1(1) vz1(2)-vz1(1)];
            v1 = v1./norm(v1);

            v2 = [vx2(2)-vx2(1) vy2(2)-vy2(1) vz2(2)-vz2(1)];
            v2 = v2./norm(v2);

            dot_ij = [dot_ij dot(v1, v2)];
            end
        end
        good_dots = sum(abs(dot_ij)>0.9);
        idata(ix,:) = [ix length(D_min) length(trace_x) length(trace_x_test) good_dots];
    end
    
    all_lengths = idata(:,2);
    %[max_value,max_dot]=max(all_dots);
    [max_value,max_dmin] = max(all_lengths);
        
    if max_value > 10
        pair_x = idata(max_dmin,1); 
    else
        pair_x = [];
    end
    
else % First round
    pair_x = [];
end

end

