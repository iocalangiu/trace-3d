function [Aaxons] = merge3D_main(all_axons, stack_out)
%merge_3D_traces.m
%Description: this function takes all the traces reconstructed with the
%function trace3D_main.m and merges the ones that represent the same axonal
%segment.
%--------------------------------------------------------------------------
%Input: all_axons - a struct containing all the traces reconstructed with
%       the function trace3D_main.m;
%       stack_out - 3-D matrix containing the fluorescent volume from where
%       the traces were reconstructed.
%Output: Aaxons - a struct containing the new merged traces;
%--------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%--------------------------------------------------------------------------

[axons_split] = trace3D_splitDifferentAzimuth(all_axons);

axon_nou = struct;
count = 1;
for i = 1:length(axons_split)
    if length(axons_split(i).directionx)>2
        axon_nou(count).directionx = axons_split(i).directionx;
        axon_nou(count).directiony = axons_split(i).directiony;
        axon_nou(count).directionz = axons_split(i).directionz;
        count = count+1;
    end
end

Aaxons = axon_nou;
difference = 10;
new_axons = struct;
iteration_difference = 1;
%==========================================================================
% Clustering-ROUND 1
%==========================================================================
while difference~=0
    clear axons
    clear new_axons
    clear Aaxons2
    Aaxons2 = Aaxons;
    axons = Aaxons;
    %/CHANGE DIRECTION
    for i = 1:length(axons)
        %/horizontal
        clear P
        clear Q
        P = [axons(i).directiony(1),axons(i).directionx(1)];
        ax = ones(1,size(stack_out,1));
        ay = 1:size(stack_out,1);
        Q = [ax',ay'];
        D = euclideanDistance(P,Q);
        min_D_start = min(D(:));
        P = [axons(i).directiony(end),axons(i).directionx(end)];
        D = euclideanDistance(P,Q);
        min_D_end = min(D(:));
        distance_1 = abs(min_D_start-min_D_end);
    
        %/vertical
        clear P
        clear Q
        P = [axons(i).directiony(1),axons(i).directionx(1)];
        ay = ones(1,size(stack_out,2))*size(stack_out,1);
        ax = 1:size(stack_out,2);
        Q = [ax',ay'];
        D = euclideanDistance(P,Q);
        min_D_start = min(D(:));
        P = [axons(i).directiony(end),axons(i).directionx(end)];
        D = euclideanDistance(P,Q);
        min_D_end = min(D(:));
        distance_2 = abs(min_D_start-min_D_end);
    
        if distance_1 > distance_2
            %/ horizontal
            P = [axons(i).directiony(1),axons(i).directionx(1)];
            ax = ones(1,size(stack_out,1));
            ay = 1:size(stack_out,1);
            Q = [ax',ay'];
            D = euclideanDistance(P,Q);
            min_D_start = min(D(:));
            P = [axons(i).directiony(end),axons(i).directionx(end)];
            D = euclideanDistance(P,Q);
            min_D_end = min(D(:));
        
            if min_D_end<min_D_start
                new_axons(i).directionx = fliplr(axons(i).directionx);
                new_axons(i).directiony = fliplr(axons(i).directiony);
                new_axons(i).directionz = fliplr(axons(i).directionz);
                new_axons(i).vxx = [0 diff(new_axons(i).directionx)];
                new_axons(i).vyy = [0 diff(new_axons(i).directiony)];
                new_axons(i).vzz = [0 diff(new_axons(i).directionz)];
                new_axons(i).distance = min_D_end;
                new_axons(i).decision = 2;
            else
                new_axons(i).directionx = axons(i).directionx;
                new_axons(i).directiony = axons(i).directiony;
                new_axons(i).directionz = axons(i).directionz;
                new_axons(i).vxx = [0 diff(new_axons(i).directionx)];
                new_axons(i).vyy = [0 diff(new_axons(i).directiony)];
                new_axons(i).vzz = [0 diff(new_axons(i).directionz)];
                new_axons(i).distance = min_D_start;
                new_axons(i).decision = 2;
            end   
        end %/ distance_1 > distance_2
    
        if distance_2 >= distance_1
            %/vertical
            P = [axons(i).directiony(1),axons(i).directionx(1)];
            ay = ones(1,size(stack_out,2))*size(stack_out,1);
            ax = 1:size(stack_out,2);
            Q = [ax',ay'];
            D = euclideanDistance(P,Q);
            min_D_start = min(D(:));
            P = [axons(i).directiony(end),axons(i).directionx(end)];
            D = euclideanDistance(P,Q);
            min_D_end = min(D(:));
    
            if min_D_end>min_D_start
                new_axons(i).directionx = fliplr(axons(i).directionx);
                new_axons(i).directiony = fliplr(axons(i).directiony);
                new_axons(i).directionz = fliplr(axons(i).directionz);
                new_axons(i).vxx = [0 diff(new_axons(i).directionx)];
                new_axons(i).vyy = [0 diff(new_axons(i).directiony)];
                new_axons(i).vzz = [0 diff(new_axons(i).directionz)];
                new_axons(i).distance = min_D_start;
                new_axons(i).decision = 1;
            else
                new_axons(i).directionx = axons(i).directionx;
                new_axons(i).directiony = axons(i).directiony;
                new_axons(i).directionz = axons(i).directionz;
                new_axons(i).vxx = [0 diff(new_axons(i).directionx)];
                new_axons(i).vyy = [0 diff(new_axons(i).directiony)];
                new_axons(i).vzz = [0 diff(new_axons(i).directionz)];
                new_axons(i).distance = min_D_end;
                new_axons(i).decision = 1;
            end    
        end %/ distance_2 > distance_1
    end %/for i = 1:length(axons)



for i = 1:length(new_axons)
    new_axons(i).cluster = i;
    new_axons(i).marked = Inf;
end

step = 1;
clear Aaxons
count1 = 1;
%===============Important Parameters=======================================
threshold =4;
threshold_Dmin = 4;
thresh_count = 10;
iterat_ion = 1;
%==========================================================================
for i = 1: numel(new_axons)
    for j = 1: numel(new_axons)
        if i~=j && new_axons(j).marked == Inf && new_axons(i).marked == Inf
                %see which one starts first
                distances = [new_axons(i).distance new_axons(j).distance];
                [~,index_distances] = min(distances);
                
                if index_distances == 1
                    %/ i is first
                    trace_x = new_axons(i).directionx;
                    trace_y = new_axons(i).directiony;
                    %trace_z = new_axons(i).directionz;
                    trace_x_test = new_axons(j).directionx;
                    trace_y_test = new_axons(j).directiony;
                    %trace_z_test = new_axons(j).directionz;
                else
                    %/ j is first
                    trace_x = new_axons(j).directionx;
                    trace_y = new_axons(j).directiony;
                    %trace_z = new_axons(j).directionz;
                    trace_x_test = new_axons(i).directionx;
                    trace_y_test = new_axons(i).directiony;
                    %trace_z_test = new_axons(i).directionz;
                end
                clear P
                clear Q
                clear D
                P = [trace_x', trace_y'];
                Q = [trace_x_test(1)', trace_y_test(1)'];
                D = euclideanDistance(P,Q);
                min(D(:));   
                if min(D(:)) < threshold_Dmin
                    [~,ll] = min(D(:)); %/ belongs to first trace
                    tr_x = trace_x(ll:end);%/ part from first 
                    tr_y = trace_y(ll:end);
                    %tr_z = trace_z(ll:end);
                    
                    if length(tr_x)>length(trace_x_test) %/ second trace terminates before first does
                        ck = 0;
                        count = 0;
                        for im = 1:step:length(trace_x_test)
                            clear p
                            clear q
                            clear D_pq
                            p = [tr_x(im) tr_y(im)];
                            q = [trace_x_test(im) trace_y_test(im)];
                            D_pq = euclideanDistance(p,q) ;
                            if D_pq>threshold
                                ck = 1;
                                break;
                            else
                                count=count+1;
                            end
                        end                       
                        if ck==0 && count>thresh_count
                            new_axons(j).cluster = new_axons(i).cluster;
                            %disp('match')
                            clear indeces
                            indeces = [i j];
                            clear merged_axons2
                            [merged_axons2] = merge3D_traces(new_axons,indeces,stack_out);
                            lx=1;
                            Aaxons(count1).directionx = merged_axons2(lx).directionx;
                            Aaxons(count1).directiony = merged_axons2(lx).directiony;
                            Aaxons(count1).directionz = merged_axons2(lx).directionz;
                            count1 = count1 + 1;   
                            new_axons(i).marked = 1;
                            new_axons(j).marked = 1;
                        end
                    else %/ length(tr_x)<length(trace_x_test) - first trace terminates before second does
                        ck = 0;
                        count=0;
                        for im = 1:step:length(tr_x)
                            clear q
                            clear p
                            clear D_pq
                            p = [tr_x(im) tr_y(im)];
                            q = [trace_x_test(im) trace_y_test(im)];
                            D_pq = euclideanDistance(p,q);
                            
                            if D_pq>threshold
                                ck = 1;
                                break;
                            else
                                count=count+1;
                            end
                        end
                        if ck==0 && count>thresh_count
                            new_axons(j).cluster = new_axons(i).cluster;
                            clear indeces
                            indeces = [i j];
                            clear merged_axons2
                            [merged_axons2] = merge3D_traces(new_axons,indeces,stack_out);
                            lx=1;
                            Aaxons(count1).directionx = merged_axons2(lx).directionx;
                            Aaxons(count1).directiony = merged_axons2(lx).directiony;
                            Aaxons(count1).directionz = merged_axons2(lx).directionz;
                            count1 = count1 + 1;   
                            new_axons(i).marked = 1;
                            new_axons(j).marked = 1;
                        end
                    end   
                end%/ index_distance == 1
            %end%/ if D_tst<50
        end%/ i~=j
        iterat_ion = iterat_ion + 1;
        if rem(iterat_ion,1000) == 0 && rem(count1,100) == 0
            disp('Pausing 5 sec')
            disp(['iterat_ion is: ' num2str(iterat_ion) '.'])
            disp(['i is: ' num2str(i) ' and j is: ' num2str(j) '.'])
            disp(['count1 is: ' num2str(count1) '.'])
            disp('------------------------------------------------------------------------')
            %pause(5)
        end
    end
end

for ix = 1:length(new_axons)
    if new_axons(ix).marked == Inf
    Aaxons(count1).directionx = new_axons(ix).directionx;
    Aaxons(count1).directiony = new_axons(ix).directiony;
    Aaxons(count1).directionz = new_axons(ix).directionz;
    count1 = count1+1;
    end
end

difference = length(Aaxons2)-length(Aaxons);
iteration_difference = iteration_difference + 1;

disp(['Iteration ' num2str(iteration_difference) ' has ended with success!'])
disp('-----------------------------------------------------------')

end
% Clustering-ROUND 1-ended
%==========================================================================





end

