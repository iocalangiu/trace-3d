function [new_axons2,close_dots] = create_pairs(Aaxons,index,step_trace)


ccount = 1;
axons =  struct;
units_this_voxel = [];

for ij = 1:length(Aaxons)
    if Aaxons(ij).voxel == index
        axons(ccount).directionx = Aaxons(ij).directionx;
        axons(ccount).directiony = Aaxons(ij).directiony;
        axons(ccount).directionz = Aaxons(ij).directionz;
        units_this_voxel(ccount) = ccount;
        ccount = ccount + 1;
    end
end

valid_good_dots = [25 25 15 15 10 10 10 10 10 10];
count = 1;
a_len = length( axons );
step = step_trace;

for ix = 1:a_len
    for iy = 1:a_len
        
        if ix~=iy && ix < iy
                trace_x = axons(ix).directionx(1:step:end);
                trace_y = axons(ix).directiony(1:step:end);
                trace_z = axons(ix).directionz(1:step:end);
                trace_x_test = axons(iy).directionx(1:step:end);
                trace_y_test = axons(iy).directiony(1:step:end);
                trace_z_test = axons(iy).directionz(1:step:end);
            
                P = [trace_x', trace_y', trace_z'];
                Q = [trace_x_test', trace_y_test', trace_z_test'];

                D = pdist2(P,Q); 
                
                D_min = find(D(:)<=1);
                
                dot_ij = [];
                for in3 = 1:length(D_min)
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
                %seq_dots = diff(find(abs(dot_ij)>0.9));
                good_dots = sum(abs(dot_ij)>0.9);
                if good_dots > valid_good_dots (step)%25
                    idata(count,:) = [ix iy length(D_min) length(trace_x) length(trace_x_test) good_dots];
                    count=count+1;
                %save_for_parfor(name,idata)
                end
        end
    end
end


if count>1
[new_axons2] = main(idata,units_this_voxel,axons);
close_dots = sum(idata(:,6));
else
new_axons2 = axons;
close_dots = 0;
end


end

