function [stack_out] = preprocess3D_ZeropadRGBstack(stack_in)

length_stack = length(stack_in);
offset = 5;

for index = 1:5
    stack_out{index} = stack_in{1}.*0;
end

%% =====For middle slices in stack ==========================================
%%getting ready, get the input matrix and number of zeros to pad
for index = 1:length_stack

matrix3d = stack_in{index};
input=matrix3d;
Nzeros = offset; 
sizeX=size(input,1); %in the first dimension, there are 3 rows
sizeY=size(input,2); %there are 7 columns
sizeZ=size(input,3); %there are 3 planes
zero2D1end=zeros(sizeX,Nzeros); %this creates a plane of sizeX (=3) x offset (= 3) zero matrix 
for i=1:sizeZ
    zero3D1end(:,:,i)=zero2D1end;
end
zeroPadded3DBothEnds = [zero3D1end input zero3D1end];
disp('padded both ends of the 3D matrix')
PaddedsizeY = Nzeros + sizeY + Nzeros; 
zero2DTop=zeros(Nzeros,PaddedsizeY); 
for i=1:sizeZ
    zero3Dtop(:,:,i)=zero2DTop;
end
PadTop = cat(1, zero3Dtop, zeroPadded3DBothEnds); %cat(1, a,b) = [a;b]
PadBottom = cat(1, PadTop, zero3Dtop);
zero3DTopBottom = PadBottom;
disp('padded both top and bottom')
stack_out{index+5} = zero3DTopBottom;
end

n = length(stack_out);
for index = 1:5
    stack_out{index} = stack_out{n}.*0;
end

n = length(stack_out);
for index = n+1:n+5
    stack_out{index} = stack_out{1}.*0;
end

end

