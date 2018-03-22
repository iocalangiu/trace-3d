function [dirx,diry,dirz,vxx,vyy,vzz,seedspars_in]  = trace3D_computeHessian(seedspars_in,direction)
x = seedspars_in.x;
y = seedspars_in.y;
z = seedspars_in.z;

maxI = seedspars_in.maxI;
im_patch = seedspars_in.im_patch;

seed_x_tmp = seedspars_in.seedsx;
seed_y_tmp = seedspars_in.seedsy;
seed_z_tmp = seedspars_in.seedsz;

dead_seed_x = seedspars_in.dead_seedsx;
dead_seed_y = seedspars_in.dead_seedsy;
dead_seed_z = seedspars_in.dead_seedsz;

vectors = seedspars_in.eigen_vectors;
dst = seedspars_in.dst;
radius = seedspars_in.radius;
size_3D_voxel = seedspars_in.size_3D_voxel;

%disp('Compute Hessian')
%disp('-----------------------------------------------------------')
width = size_3D_voxel(1); %/width of input voxel along x and y dimension
width2 = size_3D_voxel(3);%/width of input voxel along z dimension

%===============Important Parameters=======================================
threshold_azimuth = 2;
%stop = seedspars_in.this_stop;%/maximum number of iterations
stop = 150;
%==========================================================================
dead_seed_x_tmp=[];
dead_seed_y_tmp=[];
dead_seed_z_tmp=[];
%vectors = [];

vx_minor_last = [];
vy_minor_last = [];
vz_minor_last = [];
vxx = [];
vyy = [];
vzz = [];
dirx(1) = x;
diry(1) = y;
dirz(1) = z;

%disp(['Stop is: ' num2str(stop)])
for itr = 1:stop
    %/Stop condition; outside the 3-D volume data
    if (y-width)<1 || (y+width)>=size(im_patch,2) || (x-width)<1 || (x+width)>=size(im_patch,1) || (z-width2)<1 || (z+width2)>size(im_patch,3)
        break;
    end
    im = im_patch(x-width:x+width,y-width:y+width,z-width2:z+width2);%/input voxel
    [uN] = preprocess3D_LocalContrastEnhancement3(im, maxI);
    [u,v,w] = hessian3D_arrangeEigenVectors(uN,direction);
    if isempty(u)
        disp('')
        break;
    end
    
    if ~isempty(vx_minor_last)
        v_last = [vx_minor_last, vy_minor_last, vz_minor_last];
        norm(v_last);
        v_last = v_last/norm(v_last);
        [u,v,w] = hessian3D_checkDotProduct(u,v,w,v_last,itr);
        vx_minor = u(1);
        vy_minor = u(2);
        vz_minor = u(3);
    else
        vx_minor = u(1);
        vy_minor = u(2);
        vz_minor = u(3);
    end
    
    if itr ~= 1
        [s1,s2] = hessian3D_angle2number(vx_minor,vy_minor,vz_minor);
        if abs(s1-s1_start) > threshold_azimuth %|| abs(s2-s2_start) > 1
            if abs(s1-s1_start) == 31
                %disp('It is alright')
            else
                %disp('Azimuth changed')% and Elevation changed')
                break;
            end
        end
    end
    alpha = 1;%/step of tracing
    %/The Coordinates (x,y,z)
    x = round(x+alpha*vx_minor);
    y = round(y+alpha*vy_minor);
    z = round(z+alpha*vz_minor);
    
    %/Check for close seeds
    if ~isempty(seed_y_tmp) %/if there are no more seeds in the list, there is no need to look!!
        [closest_seed_x, closest_seed_y, closest_seed_z] = seeds3D_checkCloseSeeds(x,y,z,seed_x_tmp,seed_y_tmp,seed_z_tmp, ...
            dead_seed_x, dead_seed_y, dead_seed_z,vectors,vx_minor,vy_minor,vz_minor,dst);
    end
    
    %     if ~isempty(dead_seed_x)
    %         [check_DEAD] = seeds3D_checkDEADSeeds(x,y,z,dead_seed_x,dead_seed_y,dead_seed_z,dst,itr,stop);
    %     end
    %
    %     if check_DEAD == 1
    %         disp('....and we are OUT!')
    %         break;
    %     end
    
    %/Update DEAD seeds
    if ~isempty(seed_y_tmp) && ~isempty(closest_seed_y) %/second condition is to assure that you not replace x with []
        [seed_x_tmp, seed_y_tmp, seed_z_tmp, dead_seed_x, dead_seed_y, dead_seed_z, vectors] = ...
            seeds3D_removeDEAD(seed_x_tmp, seed_y_tmp, seed_z_tmp, ...
            closest_seed_x, closest_seed_y, closest_seed_z, ...
            dead_seed_x, dead_seed_y, dead_seed_z, ...
            vx_minor, vy_minor, vz_minor, vectors);
    end
    
    %//find local maximum
    
    %     [seed_x_tmp, seed_y_tmp, seed_z_tmp,dead_seed_x_tmp,dead_seed_y_tmp,dead_seed_z_tmp] = close_seeds2(x,y,z,seed_x_tmp, seed_y_tmp, seed_z_tmp,dead_seed_x_tmp,dead_seed_y_tmp,dead_seed_z_tmp);
    %
    %     [stop_cond] = stop_dead_seeds(x,y,z,dead_seed_x,dead_seed_y,dead_seed_z,itr,vx_minor,vy_minor,vz_minor,im_patch,maxI);
    %     if stop_cond == stop
    %         break;
    %     end
    
    [x,y,z] = hessian3D_findLocalMaximum(im_patch,x,y,z,vx_minor,vy_minor,vz_minor,radius); %/Correction 2: local maximum of 2-D slice
    
    
    if itr == 1
        [s1_start,s2_start] = hessian3D_angle2number(vx_minor,vy_minor,vz_minor);%/azimuth and elevation
    end
    vx_minor_last = vx_minor;
    vz_minor_last = vz_minor;
    vy_minor_last = vy_minor;
    
    if direction == 1 %/trace right
        dirx = [dirx x];
        diry = [diry y];
        dirz = [dirz z];
        vxx = [vxx vx_minor];
        vyy = [vyy vy_minor];
        vzz = [vzz vz_minor];
    end
    
    if direction == 2 %/trace left
        dirx = [x dirx];
        diry = [y diry];
        dirz = [z dirz];
        vxx = [vx_minor vxx];
        vyy = [vy_minor vyy];
        vzz = [vz_minor vzz];
    end
    
    if (itr == 1) && (dirx(end-1)-x == 0) && (diry(end-1)-y == 0) && (abs(dirz(end-1)-z) == 1)
        dirx = [];
        diry = [];
        dirz = [];
        break;
    end
end

%/Add minor eigenvectors for the first iteration, so that the vectors of
%coordinates and the one with the minor eigenvectors will have the same length
if direction == 1
    if ~isempty(vxx)
        vxx = [0 vxx];
        vyy = [0 vyy];
        vzz = [0 vzz];
    end
end

if direction == 2
    if ~isempty(vxx)
        vxx = [vxx 0];
        vyy = [vyy 0];
        vzz = [vzz 0];
    end
end

dead_seed_x = [dead_seed_x dead_seed_x_tmp];
dead_seed_y = [dead_seed_y dead_seed_y_tmp];
dead_seed_z = [dead_seed_z dead_seed_z_tmp];

seedspars_in.dead_seedsx = dead_seed_x;
seedspars_in.dead_seedsy = dead_seed_y;
seedspars_in.dead_seedsz = dead_seed_z;

seedspars_in.eigen_vectors = vectors;

seedspars_in.seedsx = seed_x_tmp;
seedspars_in.seedsy = seed_y_tmp;
seedspars_in.seedsz = seed_z_tmp;
end


