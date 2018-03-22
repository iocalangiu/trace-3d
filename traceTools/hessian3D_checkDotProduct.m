function [u,v,w] = hessian3D_checkDotProduct(u,v,w, v_last, itr)
% hessian3D_checkDotProduct.m
% Description: this function computes the dot product between the minor vectors found 
% at the previous iteration and all the 3 pairs of eigen vectors found at the current
% iteration (1 minor + 2 major eigenvectors). It then chooses as the current minor
% eigenvectors the pair that gives the dot product with highest magnitude.
% It also prevents two unwanted cases: 1) tracing backwards, the dot product
% is in this case negative, so it can be correct by changing the direction
% of the vectors by 180 degrees;
%                                      2) tracing outside the axon, the dot
% product is very close to 0, and the eigenvectors corresponding to such a
% dot product are considered the major eigenvectors. This situation is
% mostly due to the noiseness of the data, so this step assures choosing the
% correct eigenvector.
% ------------------------------------------------------------------------------------
% Input: u,v,w - three vectors containing the x,y,z components of the three
%                pairs of eigenvectors;
%        itr - the number of the current iteration, used just to verify that
%              this step is not run on the first iteration when there is no
%              previous pair of minor eigenvectors.
% Output: u,v,w - the new three pairs of eigenvectors, corrected: u-minor, v
%                 and w-majors
% ------------------------------------------------------------------------------------
% Author: Ioana Calangiu, Imperial College London, 2015
% ------------------------------------------------------------------------------------

vx_minor = u(1);
vy_minor = u(2);
vz_minor = u(3);
vx_major_1 = v(1);
vy_major_1 = v(2);
vz_major_1 = v(3);
vx_major_2 = w(1);
vy_major_2 = w(2);
vz_major_2 = w(3);

chnge_tmp = zeros(1,3);
if (itr~=1) 
        vs = [vx_minor vy_minor vz_minor; ...           
              vx_major_1 vy_major_1 vz_major_1; ...
              vx_major_2 vy_major_2 vz_major_2];
        for vct = 1:3
            m = vs(vct,:);
            m = m/norm(m);
            chnge = dot(v_last,m);
            chnge_tmp(vct) = chnge; %/chnge_tmp: contains the 3 dot products
        end
        ixs = [1 2 3];
        test1 = chnge_tmp<-0.8; %/-0.8 considered the lower limit of a high magnitude of the dot product
        test2 = chnge_tmp>0.8; %/0.8 considered the lower limit of a high magnitude of the dot product
        if sum(test1)>=1 && sum(test2)==0 %/case test1: there is/are one/more pair/s that give/s a high magnitude dot product, but it negative, so it must be reversed
            tmp = (chnge_tmp(test1)); %/putting a mask, to take only the vectors that fulfilled this condition
            tmp_ix = (ixs(test1));
            if sum(test1) > 1 %/more pairs gave a product>0.8, so we have to decide which one was the highest
                abs_tmp = abs(tmp);
                [~,one] = max(abs_tmp); %/looking for the pair that gave the high magnitude
                vx_minor = -vs(tmp_ix(one),1); %/changing the sign (test1)
                vy_minor = -vs(tmp_ix(one),2); %/changing the sign (test1)
                vz_minor = -vs(tmp_ix(one),3); %/changing the sign (test1)
                u = [vx_minor vy_minor vz_minor]; %THE MINOR
                ace = tmp_ix(one); %/save which one is the minor, to later identify the majors
            else %/only one pair gave the highest magnitude
                vx_minor = -vs(tmp_ix,1); 
                vy_minor = -vs(tmp_ix,2);
                vz_minor = -vs(tmp_ix,3);
                u = [vx_minor vy_minor vz_minor]; %/THE MINOR
                ace = tmp_ix; %/save which one is the minor, to later identify the majors
            end
        elseif sum(test2)>=1 && sum(test1)==0; %/case test2: there is/are one/more pair/s that give/s a high magnitude dot product, and it is positive, so the correct direction
            tmp = (chnge_tmp(test2)); %/putting a mask, to take only the vectors that fulfilled this condition
            tmp_ix = (ixs(test2));
            if sum(test2) > 1 %/more pairs, choosing the maximum
                abs_tmp = abs(tmp);
                [~,one] = max(abs_tmp);
                vx_minor = vs(tmp_ix(one),1);
                vy_minor = vs(tmp_ix(one),2);
                vz_minor = vs(tmp_ix(one),3);
                u = [vx_minor vy_minor vz_minor]; %/THE MINOR
                ace = tmp_ix(one); %/save which one is the minor, to later identify the majors
            else %just one pair
                vx_minor = vs(tmp_ix,1);
                vy_minor = vs(tmp_ix,2);
                vz_minor = vs(tmp_ix,3);
                u = [vx_minor vy_minor vz_minor]; %/THE MINOR
                ace = tmp_ix; %/save which one is the minor, to later identify the majors
            end
        elseif sum(test2)==1 && sum(test1)==1; %/case: one dot product>0.8 and one<0.8
            tmp_ix = (ixs(test2)); %/ chose the positive dot product
            vx_minor = vs(tmp_ix,1);
            vy_minor = vs(tmp_ix,2);
            vz_minor = vs(tmp_ix,3);
            u = [vx_minor vy_minor vz_minor]; %/THE MINOR
            ace = tmp_ix; %/save which one is the minor, to later identify the majors
        end
        if sum(test1) == 0 && sum(test2) == 0 %/case: no dot product>0.8 and no<0.8
            [~,ix] = max(abs(chnge_tmp)); %/just the maximum that is
            if chnge_tmp(ix) < 0 %/if that chosen dot product is negative, change sign
                vx_minor = -vs(ix,1);
                vy_minor = -vs(ix,2);
                vz_minor = -vs(ix,3);
                u = [vx_minor vy_minor vz_minor]; %THE MINOR
                ace = ix; %/save which one is the minor, to later identify the majors
            else %/the chosen dot product is positive
                vx_minor = vs(ix,1);
                vy_minor = vs(ix,2);
                vz_minor = vs(ix,3);
                u = [vx_minor vy_minor vz_minor]; %/THE MINOR
                ace = ix; %/save which one is the minor, to later identify the majors
            end
            vector_sign = [vz_minor,v(3)]; %/checking the sign between the last minor eigenvector z component and the current one
            check_sign = sign(vector_sign); %/ compare if the sign is changed between what was inputed as vz_minor and what this code decided to be vz_minor
            if check_sign(1) - check_sign(2) ~= 0 && diff(abs(vector_sign)) ~= 0 %/if the signs are different, delete the chose dot product and choose the next highest one
                chnge_tmp(ix) = [];
                [~,ix] = max(abs(chnge_tmp));
                if chnge_tmp(ix) < 0 %/if dot product is negative
                    vx_minor = -vs(ix,1);
                    vy_minor = -vs(ix,2);
                    vz_minor = -vs(ix,3);
                    u = [vx_minor vy_minor vz_minor]; %/THE MINOR
                    ace = ix; %/save which one is the minor, so that to know later who are the majors
                else %/if positive
                    vx_minor = vs(ix,1);
                    vy_minor = vs(ix,2);
                    vz_minor = vs(ix,3);
                    u = [vx_minor vy_minor vz_minor]; %/THE MINOR
                    ace = ix; %/save which one is the minor, so that to know later who are the majors
                end      
            end
        end
        switch ace %/one the account of the chosen minor eigenvector, load the major eigenvectors
            case 1
                vx_major_1 = vs(2,1);
                vy_major_1 = vs(2,2);
                vz_major_1 = vs(2,3);
                vx_major_2 = vs(3,1);
                vy_major_2 = vs(3,2);
                vz_major_2 = vs(3,3);
                v = [vx_major_1 vy_major_1 vz_major_1]; %/MAJOR 1
                w = [vx_major_2 vy_major_2 vz_major_2]; %/MAJOR 2
            case 2
                vx_major_1 = vs(1,1);
                vy_major_1 = vs(1,2);
                vz_major_1 = vs(1,3);
                vx_major_2 = vs(3,1);
                vy_major_2 = vs(3,2);
                vz_major_2 = vs(3,3);
                v = [vx_major_1 vy_major_1 vz_major_1]; %/MAJOR 1
                w = [vx_major_2 vy_major_2 vz_major_2]; %/MAJOR 2
           case 3
                vx_major_1 = vs(1,1);
                vy_major_1 = vs(1,2);
                vz_major_1 = vs(1,3);
                vx_major_2 = vs(2,1);
                vy_major_2 = vs(2,2);
                vz_major_2 = vs(2,3);
                v = [vx_major_1 vy_major_1 vz_major_1]; %/MAJOR 1
                w = [vx_major_2 vy_major_2 vz_major_2]; %/MAJOR 2
        end
end
end
