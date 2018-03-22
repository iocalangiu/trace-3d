function [axons] = create_middle_point(axons)

for in = 1:length(axons)
    this_length = round(length(axons(in).directionx)/2);
    axons(in).middleCoord = [axons(in).directionx(this_length) axons(in).directiony(this_length) axons(in).directionz(this_length)];
end


end

