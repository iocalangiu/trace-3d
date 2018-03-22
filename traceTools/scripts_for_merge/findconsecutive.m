function [rbeg,rend,rlen] = findconsecutive(rr)
% findconsecutive finds groups of consecutive numbers in column vector rr
%
% Outputs: 
%  rbeg: the first number in a series of consecutive numbers
%  rend: the last number in a series of consecutive numbers
%  rlen: the number of consecutive numbers in each series
%
% [rbeg,rend,rlen] = findconsecutive(rr)

if size(rr,2) > size(rr,1)
    rr = rr';
end

% Find consecutive bias trials
vv = [rr(1)-1; rr];
nv = length(vv);
qq = zeros(nv-1,1);
nq = 1;
for iv = 1:nv-1
    if vv(iv+1) == vv(iv)+1
        qq(iv) = nq;
    else
        nq = nq+1;
        qq(iv) = nq;
    end
end

% Find the beginning of each bias trial
uq = unique(qq);
rbeg = zeros(size(uq));
rend = zeros(size(uq));
rlen = zeros(size(uq));
for iuq = 1:length(uq)
    iloop = find(qq==uq(iuq));
    rbeg(iuq) = rr(iloop(1));
    rend(iuq) = rr(iloop(end));
    rlen(iuq) = length(iloop);
end

return

rr = [1 3 5 7 3 5 6 7 4 5];
[rbeg,rend,rlen] = findconsecutive(rr);


