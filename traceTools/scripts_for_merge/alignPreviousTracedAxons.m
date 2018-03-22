function [axons] =  alignPreviousTracedAxons(axons,i,j)


startx1 = axons(i).directionx(1);
starty1 = axons(i).directiony(1);
startz1 = axons(i).directionz(1);

startx2 = axons(j).directionx(1);
starty2 = axons(j).directiony(1);
startz2 = axons(j).directionz(1);

[e_d1] = pdist2([startx1 startx2],[starty1 starty2]);

endx2 = axons(j).directionx(end);
endy2 = axons(j).directiony(end);
endz2 = axons(j).directionz(end);

[e_d2] = pdist2([endx2 startx1],[endy2 starty1]);

if e_d1>e_d2
    disp('Fliplr')
    axons(i).directionx = fliplr(axons(i).directionx);
    axons(i).directiony = fliplr(axons(i).directiony);
    axons(i).directionz = fliplr(axons(i).directionz);
end

end

