function [ xh,yh,dwtime,nx,ny ] = str_polygon_rectangle_vshape( FID,grid_spacing_pixel,w_pixel,l_pixel,dwtimemax )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%input
pixel_offset=200;
%% calculation 
corr = grid_spacing_pixel;     %to enlarge the boundary a liitle bit to fit all the points inside of the rectangle
xv = [pixel_offset-corr, pixel_offset+w_pixel+corr, pixel_offset+w_pixel+corr, pixel_offset-corr, pixel_offset-corr ] ;  %create the frame
yv = [pixel_offset-corr pixel_offset-corr pixel_offset+l_pixel+corr pixel_offset+l_pixel+corr pixel_offset-corr ];  %create the frame
w_point=round(w_pixel/grid_spacing_pixel)*grid_spacing_pixel+pixel_offset;
l_point=round(l_pixel/grid_spacing_pixel)*grid_spacing_pixel+pixel_offset;


wspace = pixel_offset: grid_spacing_pixel: w_point;% a vector contains x coordinates 
lspace = pixel_offset: grid_spacing_pixel: l_point;
nx = length(wspace);  % how many points on x direction 
ny = length(lspace);  % how many points on y direction 

[X,Y] = meshgrid(wspace, lspace);    
X=reshape(X,1,nx*ny);    % reshape all the x coordinates into 1 column, to fenerate the output txt file
Y=reshape(Y,1,nx*ny);    

[in,on] = inpolygon(X,Y,xv,yv); 

xh=X(in);
yh=Y(in);

dwtime=[];

%% when nx is an odd number
if mod(nx,2)==1
    odd_incrmt = dwtimemax/((nx+1)/2);
    temp = dwtimemax/((nx+1)/2);
    factor = 1;
    for i = 1:nx
        
        for j = 1: ny
            dwtime((i-1)*ny + j) = temp;
        end
        if i == (nx+1)/2
            factor = -1;
        end
        temp = temp + odd_incrmt * factor;
    end
end


%%when nx is an even number
if mod(nx,2)==0
        even_incrmt = dwtimemax/(nx/2);
        temp = dwtimemax/(nx/2);
    factor = 1;
    for i = 1:nx
        
        for j = 1: ny
            dwtime((i-1)*ny + j) = temp;
        end
        if i == nx/2
            factor = 0;
        end
        if i == (nx/2) + 1
            factor = -1;
        end
        temp = temp + even_incrmt * factor;
    end
end

% %% randomizing the order
% rand_index = randperm(length(xh));
% xh = xh(rand_index);
% yh = yh(rand_index);
% dwtime = dwtime(rand_index);


% plot(xv,yv) % polygon
% axis equal
% 
% hold on
% plot(X(in),Y(in),'ro') % points inside
% hold off





end


