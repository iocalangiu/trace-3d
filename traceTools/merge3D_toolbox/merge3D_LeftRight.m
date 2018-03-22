function [new_trace_x, new_trace_y, new_trace_z, new_vxx, new_vyy, new_vzz] = merge3D_LeftRight(found_trace_x, found_trace_y, found_trace_z, ...
                                            current_trace_x, current_trace_y, current_trace_z, ...
                                            found_vxx, found_vyy, found_vzz, ...
                                            current_vxx, current_vyy, current_vzz)
%merge3D_LeftRight.m
%Description: after the tracing goes left and right, this function merges them
%-----------------------------------------------------------------------------
%Input: found_trace_x,found_trace_y,found_trace_z - the right trace, the x,y,z
%                                                   coordinates;
%       current_trace_x,current_trace_y,current_trace_z - the left trace, the 
%                                                         x,y,z coordinates;
%       found_vxx,found_vyy,found_vzz - the right trace, the vector components;
%       current_vxx,current_vyy,current_vzz - the left trace, the vector
%                                             components.
%Output: new_trace_x,new_trace_y,new_trace_z - the new merged trace, the x,y,z 
%                                              coordinates;
%        new_vxx,new_vyy,new_vzz - the new merged trace, the vector components.
%-----------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%-----------------------------------------------------------------------------

new_trace_x = [current_trace_x found_trace_x(2:end)];
new_trace_y = [current_trace_y found_trace_y(2:end)];
new_trace_z = [current_trace_z found_trace_z(2:end)];
new_vxx = [current_vxx found_vxx(2:end)];
new_vyy = [current_vyy found_vyy(2:end)];
new_vzz = [current_vzz found_vzz(2:end)];

end

