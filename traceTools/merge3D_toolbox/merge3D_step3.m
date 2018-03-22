function [new_axons] = merge3D_step3(new_axons,stack_out)

step = 1;
%===============Important Parameters=======================================
threshold = 1;
threshold_Dmin = 4;
%==========================================================================
for i = 1:length(new_axons)
    link = 1;
    for j = 1:length(new_axons)
        if i~=j && i<j
                clear ppointsx
                clear ppointsy
                clear pppointsx
                clear pppointsy
                indic = 1;
                
                ck=0;
                intensity1 = [];
                intensity2 = [];
                %/ i is first
                trace_x = new_axons(i).directionx;
                trace_y = new_axons(i).directiony;
                trace_z = new_axons(i).directionz;
                trace_x_test = new_axons(j).directionx;
                trace_y_test = new_axons(j).directiony;
                trace_z_test = new_axons(j).directionz;
            
                P = [trace_x', trace_y'];
                Q = [trace_x_test', trace_y_test'];
                D = pdist2(P,Q);
                D_vect = D(:);
                min(D(:));   
                transf_x = NaN(2,4000);
                transf_y = NaN(2,4000);
                transf_z = NaN(2,4000);
                if sum(D_vect<threshold_Dmin) > 4
                    index = round(length(trace_x)/2);
                    length(transf_x(1,2000-index:2000+index-1));
                    length(trace_x);
                    transf_x(1,2000-index:2000+index-1) = trace_x;
                    [~,ll] = min(D(:)); %/ belongs to first trace
                    [row,col] = ind2sub(size(D),ll); %/row is trace_x, and col is trace_x_test
                    %/ row + 2000 - index
                    length(trace_x_test);
                    length(transf_x(2,2000-index-col:2000-index+length(trace_x_test)-col-1));
                    transf_x(2,2000-index-col:2000-index+length(trace_x_test)-col-1) = trace_x_test;
                    std_x = nanstd(transf_x,1);
                    std_x(~isnan(std_x))
                    disp('-------------------------------------')
                    break;
                    tr_x = trace_x(ll:end);%/ part from first 
                    tr_y = trace_y(ll:end);
                    tr_z = trace_z(ll:end);
                    if length(tr_x)>length(trace_x_test) %/ second trace terminates before first does
                        for im = 1:step:length(trace_x_test)
                            clear p
                            clear q
                            clear D_pq
                            p = [tr_x(im) tr_y(im)];
                            q = [trace_x_test(im) trace_y_test(im)];
                            D_pq = euclideanDistance(p,q) ;
                            if D_pq<threshold                              
                                
                                intensity1 = [intensity1 stack_out(round(tr_x(im)),round(tr_y(im)),round(tr_z(im)))];
                                intensity2 = [intensity2 stack_out(round(trace_x_test(im)),round(trace_y_test(im)),round(trace_z_test(im)))];
                                ppointsx(indic)=tr_x(im);
                                ppointsy(indic)=tr_y(im);
                                pppointsx(indic)=trace_x_test(im);
                                pppointsy(indic)=trace_y_test(im);
                                pace(indic)=im;
                                units{indic}=[i,j];
                                indic=indic+1;
                                ck=1;
                                disp('11')
                                
                            end
                        end
                        
                        if ck == 1
                        
                        new_axons(i).friends{link} = {i,j,mean(intensity1),mean(intensity2),[ppointsx;ppointsy],[pppointsx;pppointsy]};
                        new_axons(j).friends{link} = {i,j,mean(intensity1),mean(intensity2),[ppointsx;ppointsy],[pppointsx;pppointsy]};
                        link=link+1;
                        end
                        
                    else %/ length(tr_x)<length(trace_x_test) - first trace terminates before second does

                        for im = 1:step:length(tr_x)
                            clear q
                            clear p
                            clear D_pq
                            p = [tr_x(im) tr_y(im)];
                            q = [trace_x_test(im) trace_y_test(im)];
                            D_pq = euclideanDistance(p,q);
                            D_pq;
                            if D_pq<threshold
                                
                                intensity1 = [intensity1 stack_out(round(tr_x(im)),round(tr_y(im)),round(tr_z(im)))];
                                intensity2 = [intensity2 stack_out(round(trace_x_test(im)),round(trace_y_test(im)),round(trace_z_test(im)))];
                                ppointsx(indic)=tr_x(im);
                                ppointsy(indic)=tr_y(im);
                                pppointsx(indic)=trace_x_test(im);
                                pppointsy(indic)=trace_y_test(im);
                                pace(indic)=im;
                                units{indic}=[i,j];
                                indic=indic+1;
                                ck=1;
                                disp('22')
                                
                            end
                        end
                        
                        if ck == 1
                        new_axons(i).friends{link} = {i,j,mean(intensity1),mean(intensity2),[ppointsx;ppointsy],[pppointsx;pppointsy]};
                        new_axons(j).friends{link} = {i,j,mean(intensity1),mean(intensity2),[ppointsx;ppointsy],[pppointsx;pppointsy]};
                        %new_axons(i).friends = [new_axons(i).friends {i,j,mean(intensity1),mean(intensity2),[ppointsx;ppointsy],[pppointsx;pppointsy]}];
                        %new_axons(j).friends = [new_axons(j).friends {i,j,mean(intensity1),mean(intensity2),[ppointsx;ppointsy],[pppointsx;pppointsy]}];
                        link=link+1;
                        end
                        
                    end   
                end%/ index_distance == 1
            %end%/ if D_tst<50
        end%/ i~=j
    end
end

end

