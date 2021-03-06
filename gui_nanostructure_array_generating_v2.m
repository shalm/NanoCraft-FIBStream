function varargout = gui_nanostructure_array_generating_v2(varargin)
% GUI_NANOSTRUCTURE_ARRAY_GENERATING_V2 MATLAB code for gui_nanostructure_array_generating_v2.fig
%      GUI_NANOSTRUCTURE_ARRAY_GENERATING_V2, by itself, creates a new GUI_NANOSTRUCTURE_ARRAY_GENERATING_V2 or raises the existing
%      singleton*.
%
%      H = GUI_NANOSTRUCTURE_ARRAY_GENERATING_V2 returns the handle to a new GUI_NANOSTRUCTURE_ARRAY_GENERATING_V2 or the handle to
%      the existing singleton*.
%
%      GUI_NANOSTRUCTURE_ARRAY_GENERATING_V2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_NANOSTRUCTURE_ARRAY_GENERATING_V2.M with the given input arguments.
%
%      GUI_NANOSTRUCTURE_ARRAY_GENERATING_V2('Property','Value',...) creates a new GUI_NANOSTRUCTURE_ARRAY_GENERATING_V2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_nanostructure_array_generating_v2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_nanostructure_array_generating_v2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_nanostructure_array_generating_v2

% Last Modified by GUIDE v2.5 11-Sep-2016 22:07:27

% Begin initialization code - DO NOT EDIT

%% GUI code generated by default
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_nanostructure_array_generating_v2_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_nanostructure_array_generating_v2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_nanostructure_array_generating_v2 is made visible.
function gui_nanostructure_array_generating_v2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_nanostructure_array_generating_v2 (see VARARGIN)

% Choose default command line output for gui_nanostructure_array_generating_v2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_nanostructure_array_generating_v2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_nanostructure_array_generating_v2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function row_edit_Callback(hObject, eventdata, handles)
% hObject    handle to row_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of row_edit as text
%        str2double(get(hObject,'String')) returns contents of row_edit as a double


% --- Executes during object creation, after setting all properties.
function row_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to row_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function column_edit_Callback(hObject, eventdata, handles)
% hObject    handle to column_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of column_edit as text
%        str2double(get(hObject,'String')) returns contents of column_edit as a double


% --- Executes during object creation, after setting all properties.
function column_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to column_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%

%% MAIN CODE: INPUTS

% --- Executes on button press in generate.
function generate_Callback(hObject, eventdata, handles)
% hObject    handle to generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FID=0;
num_pixel = 3696; 
pixel_offset = 200; 
dwtime = 10*str2num(get(handles.dwelltime_max_edit,'string')); % us, need to multiply by 10 because units of dwell time in xT UI are 0.1 us     
n = str2num(get(handles.row_edit,'string'));
m = str2num(get(handles.column_edit,'string'));
separation = str2num(get(handles.separation_edit,'string'));
grid_spacing_pixel = str2num(get(handles.grid_spacing_edit,'string'));
rad = str2num(get(handles.radius_edit,'string'));
l = str2num(get(handles.length_edit,'string'));
w = str2num(get(handles.width_edit,'string'));
%%

%% MAIN CODE: CIRCULAR SHAPE ARRAY
index = get(handles.shape_popup,'value');
if index == 1
    cla(handles.axes1);
cla(handles.axes3);
nm_to_pixel = num_pixel/(separation*(n-1)+rad*2*n);   % scale 1 nm to pixel
step_nm = 1/(nm_to_pixel)*grid_spacing_pixel;  % step scaling factor, 1 step to how many pixels    
rad_pixel = rad * nm_to_pixel;
separation_pixel = separation * nm_to_pixel;
magnification = round(60000*nm_to_pixel);  %calcualting magnification
[x,y] = meshgrid(0:separation_pixel:separation_pixel*(n-1),0:separation_pixel:separation_pixel*(m-1));
xx = [];
yy = [];
[r]=rad_pixel*ones(n,m) ;    % a MxN matrix of radius
for i=1:n
	for j=1:m
        fprintf('i=%d j=%d\n', i, j);
     [xc, yc]=str_polygon_50sides(FID,grid_spacing_pixel, 2*r(j));   % everytime calculate all the dots inside
      xc = xc + x(i,j);  %all dots shift to next circle on x direction
      yc = yc + y(i,j); %all dots shift to next circle on y direction
      xx = [xx xc];    % store the dots
      yy = [yy yc];    % store the dots
    end
    axes(handles.axes1);
    hold on
    
    %conversion from pixels to nm
    xx_nm = xx/nm_to_pixel;
    yy_nm = yy/nm_to_pixel;
    xc_nm = xc/nm_to_pixel;
    plot(xx_nm,yy_nm,'r.') % points inside; generates a top view of circular array
    ylim([min(yy_nm)-100 max(yy_nm)+100]);
    xlabel('x [nm]');
    ylabel('y [nm]');
    axis equal
    
end
dwt=[];
for i=1:length(xc)
    dwt(i)=dwtime;
end
% for i=1:n
%    for j=1:m
%     L = linspace(0,2*pi,50);
% xv = r(i,j)*cos(L)' + x(i,j)+rad_pixel;
% yv = r(i,j)*sin(L)' + y(i,j)+pixel_offset+rad_pixel;
% axes(handles.axes1);
% plot(xv, yv, '-');
% end  
% end
    hold off   
axes(handles.axes3);
% view(handles.axes3,[0 180]);
% grid(handles.axes3,'on');
% hold(handles.axes3,'all');
% plot(xc_nm,dwt/10,'.r','MarkerSize',20);
% ylim([0 dwtime/10]);
% xlim([min(xc_nm)-100 max(xc_nm)+100]);
xc_bar=min(xc_nm):step_nm :max(xc_nm);
dwt_bar = zeros(1,length(xc_bar))+dwtime/10;

bar(xc_bar,dwt_bar,'r','LineStyle','none');
set(gca,'YDir','Reverse');  
 
xlim([min(xc_nm)-100 max(xc_nm)+100]);
%scatter3(xc,yc,dwt,20,'r','filled'); % plot cross section view for circular array
    xlabel('x [nm]');
    ylabel('z/dwell time [us]');
   
% hold on
% line(xlim,[0 0])    % add the zero level on cross section view
data = struct('XX',xx,'YY',yy);
set(hObject,'UserData',data);
set(handles.nm2pxl, 'String', num2str(step_nm));

end
%%

%% MAIN CODE: RECTANGULAR SHAPE ARRAY

if index == 2
cla(handles.axes1);
cla(handles.axes3);
%nm_to_pixel = num_pixel/(separation*(n-1)+w*n);   % scale 1 nm to pixel
%nm_to_pixel = num_pixel/(separation*(n-1)+w);

max_pattern_size = max(separation*(n-1)+n*w, l);
nm_to_pixel = num_pixel/max_pattern_size;   % scale 1 nm to pixel


step_nm = 1/(nm_to_pixel)*grid_spacing_pixel;  % step scaling factor, 1 step to how many pixels    

w_pixel = w * nm_to_pixel;
l_pixel = l * nm_to_pixel;
separation_pixel = separation * nm_to_pixel;
magnification = round(60000*nm_to_pixel);  %calcualting magnification

[x] = 0:separation_pixel:separation_pixel*(n-1);
xx = [];
yy = [];

for i=1:n
   fprintf('i=%d ', i);
     [xc, yc]=str_polygon_rectangle(FID,grid_spacing_pixel,w_pixel,l_pixel);   % everytime calculate all the dots inside
      xc = xc + x(i);  %all dots shift to next circle on x direction
      xx = [xx xc];    % store the dots
      yy = [yy yc];    % store the dots
      
    axes(handles.axes1);
    
        %conversion from pixels to nm
    xx_nm = xx/nm_to_pixel;
    yy_nm = yy/nm_to_pixel;
    xc_nm = xc/nm_to_pixel;
    plot(xx_nm,yy_nm,'b.') % points inside, plot top view
    ylim([min(yy_nm)-100 max(yy_nm)+100]);

    xlabel('x [nm]');
    ylabel('y [nm]');

%    ylim([0 4200])    
%axis equal
end

    data = struct('XX',xx,'YY',yy);
    set(hObject,'UserData',data);
  dwt=[];
 for i=1:length(xc)
     dwt(i)=dwtime;
 end
  hold off   
axes(handles.axes3);
%view(handles.axes3,[0 180]);
%grid(handles.axes3,'on');
%hold(handles.axes3,'all');


%plot(linspace(0,2*pi,100), sin(linspace(0,2*pi,100)));
%set(gca,'YDir','Reverse');
%plot(xc,dwt/10,'.b','Markersize',20)

xc_bar=min(xc_nm):step_nm :max(xc_nm);
dwt_bar = zeros(1,length(xc_bar))+dwtime/10;

bar(xc_bar,dwt_bar,'b','LineStyle','none');
set(gca,'YDir','Reverse');  
 
xlim([min(xc_nm)-100 max(xc_nm)+100]);
%scatter3(xc,yc,dwt/10,20,'b','filled'); %plot cross section view for rectangular array
%plot(xc,dwt/10,20,'b','filled'); 
    xlabel('x [nm]');
    ylabel('z/dwell time [us]');
hold on
line(xlim,[0 0]) 

data = struct('XX',xx,'YY',yy);
set(hObject,'UserData',data);
%  figure1 = figure;
% axes1 = axes('Parent',figure1);
% %view(axes1,[180 180]);
% grid(axes1,'on');
% hold(axes1,'all');
% scatter3(xc,yc,dwt);

set(handles.nm2pxl, 'String', num2str(step_nm));



end
%%

%% MAIN CODE: V-GROOVE ARRAY 
if index == 3
    cla(handles.axes1);
cla(handles.axes3);
dwtimemax=dwtime;
max_pattern_size = max(separation*(n-1)+n*w, l);
nm_to_pixel = num_pixel/max_pattern_size;   % scale 1 nm to pixel
step_nm = 1/(nm_to_pixel)*grid_spacing_pixel;  % step scaling factor, 1 step to how many pixels    

w_pixel = w * nm_to_pixel;
l_pixel = l * nm_to_pixel;
separation_pixel = separation * nm_to_pixel;
magnification = round(60000*nm_to_pixel);  %calcualting magnification


[x] = 0:separation_pixel:separation_pixel*(n-1);
xx = [];
yy = [];
dwelltime=[];


for i=1:n
	
        fprintf('i=%d ', i);
     [xc, yc,dw_time,nx,ny]=str_polygon_rectangle_vshape(FID,grid_spacing_pixel,w_pixel,l_pixel,dwtimemax);   % everytime calculate all the dots inside
      xc = xc + x(i);  %all dots shift to next circle on x direction
      xx = [xx xc];    % store the dots
      yy = [yy yc];    % store the dots     
     hold on
     axes(handles.axes1);

     %conversion from pixels to nm
     xx_nm = xx/nm_to_pixel;
     yy_nm = yy/nm_to_pixel;
     xc_nm = xc/nm_to_pixel;
     
     xc_reshape = reshape(xc_nm,ny,nx);   %reshape the xc dots to a nx*ny matrix
     xc_reshape = xc_reshape(1,:);        % extract the first row in order to plot the cross section view
     dw_time_reshape=reshape(dw_time,ny,nx);
     dw_time_reshape=dw_time_reshape(1,:);
     plot(xx_nm,yy_nm,'g.') % points inside, plot top view of v-groove array
     xlabel('x [nm]');
     ylabel('y [nm]');
     %ylim([0 4200])
     ylim([min(yy_nm)-100 max(yy_nm)+100]);

     % axis equal
end
 dwelltime = repmat(dw_time,1,n);

% for i=1:n
%     xv = [pixel_offset pixel_offset+w_pixel pixel_offset+w_pixel pixel_offset pixel_offset ]+x(i);
%     yv = [pixel_offset pixel_offset pixel_offset+l_pixel pixel_offset+l_pixel pixel_offset ];
%     plot(xv, yv);     % plot the frame in top view 
%    end  
%     hold off   
  
axes(handles.axes3);
% view(handles.axes3,[0 180]);
% grid(handles.axes3,'on');
% hold(handles.axes3,'all');
%plot(xc_reshape,dw_time_reshape, '.g', 'MarkerSize',20)


bar(xc_reshape,dw_time_reshape,'g','LineStyle','none');
set(gca,'YDir','Reverse');   
xlim([min(xc_reshape)-100 max(xc_reshape)+100]);
%scatter3(xc,yc,dw_time,20,'g','filled'); %plot cross section view for v-groove array
    xlabel('x [nm]');
    ylabel('z/dwell time [us]');

data = struct('XX',xx,'YY',yy);
    set(hObject,'UserData',data);
set(handles.nm2pxl, 'String', num2str(step_nm));

end


set(handles.mag, 'String', num2str(magnification));
guidata(hObject,handles);
    

% --- Executes on selection change in shape_popup.
%%

%% GUI INPUT FIELDS
function shape_popup_Callback(hObject, eventdata, handles) %shape button
% hObject    handle to shape_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns shape_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from shape_popup


index = get(handles.shape_popup,'value');

if (index == 1) % input menu options for circular array
% enabled/disabled fields
set(handles.length_edit,'Enable','off');
set(handles.width_edit,'Enable','off');
set(handles.radius_edit,'Enable','on');
set(handles.column_edit,'Enable','on');
set(handles.mag,'Enable','off');

cla(handles.axes1);
cla(handles.axes3);

%default settings
set(handles.radius_edit,'String','50');
set(handles.width_edit,'String','');
set(handles.length_edit,'String','');
set(handles.row_edit,'String','3');
set(handles.column_edit,'String','3');
set(handles.separation_edit,'String','500');
set(handles.dwelltime_max_edit,'String','300');
set(handles.grid_spacing_edit,'String','5');
set(handles.mag,'String','');
set(handles.nm2pxl,'String','');

end

if (index == 2) % input menu options for rectangular array
% enabled/disabled fields
set(handles.length_edit,'Enable','on');
set(handles.width_edit,'Enable','on');
set(handles.radius_edit,'Enable','off');
set(handles.column_edit,'Enable','off');
set(handles.mag,'Enable','off');

cla(handles.axes1);
cla(handles.axes3);
%set(handles.axes3,'Visible','off');
set(handles.mag,'String','');
%set(handles.save,'Visible','off');

%default settings
set(handles.radius_edit,'String','');
set(handles.separation_edit,'String','1000');
set(handles.grid_spacing_edit,'String','3');
set(handles.width_edit,'String','300');
set(handles.length_edit,'String','2000');
set(handles.dwelltime_max_edit,'String','300');
set(handles.column_edit,'String','1');
set(handles.row_edit,'String','5');
set(handles.nm2pxl,'String','');

end

if (index == 3) % input menu options for v-groove array
% enabled/disabled fields
set(handles.length_edit,'Enable','on');
set(handles.width_edit,'Enable','on');
set(handles.radius_edit,'Enable','off');
set(handles.column_edit,'Enable','off');
set(handles.mag,'Enable','off');

cla(handles.axes1);
cla(handles.axes3);

set(handles.axes3,'Visible','on');
set(handles.mag,'String','');
set(handles.save,'Visible','on');

%default settings
set(handles.radius_edit,'String','');
set(handles.separation_edit,'String','1000');
set(handles.grid_spacing_edit,'String','3');
set(handles.width_edit,'String','300');
set(handles.length_edit,'String','2000');
set(handles.dwelltime_max_edit,'String','460');
set(handles.column_edit,'String','1');
set(handles.row_edit,'String','5');
set(handles.nm2pxl,'String','');

end

% generated by GUIDE
% --- Executes during object creation, after setting all properties.
function shape_popup_CreateFcn(hObject, eventdata, handles) 
% hObject    handle to shape_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%generated by GUIDE
% --- Executes on button press in figure.
function figure_Callback(hObject, eventdata, handles)
% hObject    handle to figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of figure

%generated by GUIDE
% --- Executes on button press in file.
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of file



function grid_spacing_edit_Callback(hObject, eventdata, handles)
% hObject    handle to grid_spacing_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of grid_spacing_edit as text
%        str2double(get(hObject,'String')) returns contents of grid_spacing_edit as a double


% --- Executes during object creation, after setting all properties.
function grid_spacing_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to grid_spacing_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radius_edit_Callback(hObject, eventdata, handles)
% hObject    handle to radius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius_edit as text
%        str2double(get(hObject,'String')) returns contents of radius_edit as a double


% --- Executes during object creation, after setting all properties.
function radius_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function length_edit_Callback(hObject, eventdata, handles)
% hObject    handle to length_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of length_edit as text
%        str2double(get(hObject,'String')) returns contents of length_edit as a double




% --- Executes during object creation, after setting all properties.
function length_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to length_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function width_edit_Callback(hObject, eventdata, handles)
% hObject    handle to width_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of width_edit as text
%        str2double(get(hObject,'String')) returns contents of width_edit as a double


% --- Executes during object creation, after setting all properties.
function width_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to width_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% function separation_edit_Callback(hObject, eventdata, handles)
% % hObject    handle to separation_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of separation_edit as text
% %        str2double(get(hObject,'String')) returns contents of separation_edit as a double


% --- Executes during object creation, after setting all properties.
function separation_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to separation_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%

%% DOWNLOAD BUTTON
% --- Executes on button press in download.
function download_Callback(hObject, eventdata, handles)
% hObject    handle to download (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num_pixel = 3696; % number of available pixels along x and y directions
pixel_offset = 200; % pixel offset (related to machine specifications)
FID=0;
dwtime=str2num(get(handles.dwelltime_max_edit,'string'));
n = str2num(get(handles.row_edit,'string'));
m = str2num(get(handles.column_edit,'string'));
separation = str2num(get(handles.separation_edit,'string'));
grid_spacing_pixel = str2num(get(handles.grid_spacing_edit,'string'));
rad = str2num(get(handles.radius_edit,'string'));
l = str2num(get(handles.length_edit,'string'));
w = str2num(get(handles.width_edit,'string'));
index = get(handles.shape_popup,'value');
if index == 1
    nm_to_pixel = num_pixel/(separation*(n-1)+rad*2*n);   % scale 1 nm to pixel
    rad_pixel = rad * nm_to_pixel;
separation_pixel = separation * nm_to_pixel;
magnification = round(60000*nm_to_pixel);
end

if index==2
nm_to_pixel = num_pixel/(separation*(n-1)+w*n);   % scale 1 nm to pixel
w_pixel = w * nm_to_pixel;
l_pixel = l * nm_to_pixel;
separation_pixel = separation * nm_to_pixel;
magnification = round(60000*nm_to_pixel);
end

if index == 3
max_pattern_size = max(separation*(n-1)+n*w, l);
nm_to_pixel = num_pixel/max_pattern_size;   % scale 1 nm to pixel
w_pixel = w * nm_to_pixel;
l_pixel = l * nm_to_pixel;
separation_pixel = separation * nm_to_pixel;
magnification = round(60000*nm_to_pixel); 
dwtimemax=dwtime;
end

h = findobj('Tag','generate');
data = get(h,'UserData');
xx = data.XX;
yy = data.YY;
sz=size(xx);
time_matrix=zeros(sz)+dwtime;
row12=char('s','1');
xx_round=ceil(xx);
yy_round=ceil(yy);
final_matrix=[time_matrix',xx_round',yy_round'];
number_point=length(xx);

if index == 1
filename = strcat('circ_array_', num2str(n),'x', num2str(m), 'rad',num2str(rad),'nm_', 'sep', num2str(separation),'nm_', '_dwtime',num2str(dwtime), '_us', '_grid_sp',num2str(grid_spacing_pixel), 'px','_mag',num2str(magnification),'.txt');
save('stream_file','final_matrix');
system('exportfile stream_file.mat');   
end

if index==2
filename = strcat('rect_array_1x', num2str(n), 'l',num2str(l),'nm_', 'w',num2str(w),'nm_', 'sep', num2str(separation),'nm_','_dwtime',num2str(dwtime), '_us','_grid_sp',num2str(grid_spacing_pixel), 'px','_mag',num2str(magnification),'.txt');
save('stream_file','final_matrix');
system('exportfile stream_file.mat'); 
end

if index ==3
filename = strcat('vgr_array_1x', num2str(n), 'l',num2str(l),'nm_', 'w',num2str(w),'nm_', 'sep', num2str(separation),'nm_','_dwtimemax',num2str(dwtimemax), '_us','_grid_sp',num2str(grid_spacing_pixel), 'px','_mag',num2str(magnification),'.txt');
save('stream_file','final_matrix');
system('exportfile stream_file.mat'); 
end


dlmwrite(filename,row12)
dlmwrite(filename,number_point,'-append','precision',10)
dlmwrite(filename,final_matrix,'-append','delimiter',' ')
guidata(hObject,handles);

% generated by GUIDE
function dwelltime_max_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dwelltime_max_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dwelltime_max_edit as text
%        str2double(get(hObject,'String')) returns contents of dwelltime_max_edit as a double


% --- Executes during object creation, after setting all properties.
function dwelltime_max_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dwelltime_max_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2



function mag_Callback(hObject, eventdata, handles)
% hObject    handle to mag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mag as text
%        str2double(get(hObject,'String')) returns contents of mag as a double



% --- Executes during object creation, after setting all properties.
function mag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%

%% HELP BUTTON
% --- Executes on button press in helpbutton.
function helpbutton_Callback(hObject, eventdata, handles)
% hObject    handle to helpbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index = get(handles.shape_popup,'value');
if (index == 1)
 msgbox({'Creat a circular nanostructure array.' 'Separation distance: The distance between two circular nanostructures.' 'Grid Spacing: Distance between two punching holes.' 'Radius: The radius of the circular nanostructure.' 'Max dwell time: The maximum dwelling time.'} , 'Circular nanostructrue array');
end

if (index == 2)
 msgbox({'Creat a rectangular nanostructure array, whose depth are consistent.' 'Separation distance: The distance between two rectangular nanostructures.' 'Grid Spacing: Distance between two punching holes.' 'Length: The length of the rectangular nanostructure.' 'Width: The width of the rectangular nanostructure.' 'Max dwell time: The maximum dwelling time.'} , 'Rectangular nanostructrue array');
end

if (index == 3)
 msgbox({'Creat a rectangular nanostructure array, whose depth are varying. The cross-section view looks like as v-groove.' 'Separation distance: The distance between two rectangular nanostructures.' 'Grid Spacing: Distance between two punching holes.' 'Length: The length of the rectangular nanostructure.' 'Width: The width of the rectangular nanostructure.' 'Max dwell time: The maximum dwelling time.'} , 'V-groove nanostructrue array');
end
%%    
    
%% SAVING CROSS SECTION FIGURE

% save the cross section view
% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index=get(handles.shape_popup,'value');
if (index==1)
    fg= figure;
    copyobj(handles.axes3, fg);
    saveas(fg,'circular_nanostructure_array_cross-section_view.fig','fig');
%     close(fg);
%     system(' exportfile circular_nanostructure_array_cross-section_view.fig');

end

if (index==2)
    fg= figure;
    copyobj(handles.axes3, fg);
    saveas(fg,'rectangular_nanostructure_array_cross-section_view.fig','fig');
%     close(fg);
%     system(' exportfile rectangular_nanostructure_array_cross-section_view.fig');

end

if (index==3)
    fg= figure;
    copyobj(handles.axes3, fg);
    saveas(fg,'vgroove_nanostructure_array_cross-section_view.fig','fig');
%     close(fg);
%     system(' exportfile vgroove_nanostructure_array_cross-section_view.fig');

end

% save the top view
% --- Executes on button press in save1.
function save1_Callback(hObject, eventdata, handles)
% hObject    handle to save1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index=get(handles.shape_popup,'value');
if (index==1)
    fg= figure;
    copyobj(handles.axes1, fg);
    saveas(fg,'circular_nanostructure_array_top_view.fig','fig');
%     close(fg);
%     system('exportfile circular_nanostructure_array_top_view.fig');


end
if (index==2)
 fg= figure;
    copyobj(handles.axes1, fg);
    saveas(fg,'rectangular_nanostructure_array_top_view.fig','fig');
%     close(fg);
%     system('exportfile rectangular_nanostructure_array_top_view.fig');

end
if (index==3)
 fg= figure;
    copyobj(handles.axes1, fg);
    saveas(fg,'vgroove_nanostructure_array_top_view.fig','fig');
%     close(fg);
%     system(' exportfile vgroove_nanostructure_array_top_view.fig');

end



function separation_edit_Callback(hObject, eventdata, handles)
% hObject    handle to separation_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of separation_edit as text
%        str2double(get(hObject,'String')) returns contents of separation_edit as a double


% --- Executes during object creation, after setting all properties.
% function separation_edit_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to separation_edit (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



function nm2pxl_Callback(hObject, eventdata, handles)
% hObject    handle to nm2pxl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nm2pxl as text
%        str2double(get(hObject,'String')) returns contents of nm2pxl as a double


% --- Executes during object creation, after setting all properties.
function nm2pxl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nm2pxl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


